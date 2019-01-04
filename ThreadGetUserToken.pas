unit ThreadGetUserToken;

interface

uses
  ActiveX, Classes, SysUtils, ShlObj, Windows, XMLDom, XMLIntf, MSXMLDom, XMLDoc,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP, Forms,
  StrUtils, HTTPApp, Variants;

type
  ThreadUserTockenGet = class(TThread)
  private
    { Private declarations }

  protected
    procedure InitIndyObject;
    procedure FreeIndyObject;
    procedure Execute; override;
    procedure APIGetUserTocken();//获取用户TOKEN
    procedure ShowAlertMsgForm();//调用显示消息窗体

    var
      IdHttpMain:TIdHTTP; //HTTP RFC
      XmlDocumentMain:TXMLDocument;  //XML对象
  end;

implementation

  uses MD5, FunctionCommon, SystemConfig;

{ 
  Important: Methods and properties of objects in visual components can only be
  used in a method called using Synchronize, for example,

      Synchronize(UpdateCaption);  

  and UpdateCaption could look like,

    procedure ThreadGetUserTocken.UpdateCaption;
    begin
      Form1.Caption := 'Updated in a thread';
    end; 
    
    or 
    
    Synchronize( 
      procedure 
      begin
        Form1.Caption := 'Updated in thread via an anonymous method' 
      end
      )
    );
    
  where an anonymous method is passed.
  
  Similarly, the developer can call the Queue method with similar parameters as 
  above, instead passing another TThread class as the first parameter, putting
  the calling thread in a queue with the other thread.
    
}

{ ThreadGetUserTocken }

procedure ThreadUserTockenGet.APIGetUserTocken;
var
  Param:TStringList;
  RStream:TStringStream;
  XmlUserInfo: string;
  Node, mNode:IXMLNode;
  UserSign: RawByteString;
  iMsgAt, iMsgNewPrice, iMsgShopGoods: integer;
begin
  InitIndyObject;//初始化HTTP对象
  //XML
  XMLDocumentMain:=TXMLDocument.Create(Application);
  XMLDocumentMain.Active:=False;
  XmlUserInfo:='';
  //URL参数
  Param:=TStringList.Create;
  RStream:=TStringStream.Create('',TEncoding.UTF8); //UTF-8

  //中文处理
  DebugTrace('签名:=', API_USER_SIGN);

  UserSign:=UTF8Encode(API_USER_SIGN);
  SetCodePage(UserSign, 0, False);//重要注册处理
  UserSign:=StrToMD5(UserSign, 9);

  DebugTrace('签名MD5:=', UserSign);
  //提交字段
  Param.Add('app_id=' + IntToStr(API_ID));
  Param.Add('uid='+ IntToStr(USER_ID));
  Param.Add('username=' + USER_NAME);
  Param.Add('login_key=' + USER_LOGIN_KEY);
  Param.Add('sign=' + UserSign);



  try
    try
      IdHttpMain.Post(API_URL_USERINFO, Param, RStream);
    except on E: Exception do begin
        Log(E.Message);
      end;

    end;
  finally
    XmlUserInfo:= RStream.DataString;
  end;


  FreeIndyObject; //释放HTTP对象
  FreeAndNil(Param);
  FreeAndNil(RStream);

  //获取用户Token
  if (XmlUserInfo <> '') then begin

    DebugTrace('获取用户TOKEN接口', XmlUserInfo);

    XmlDocumentMain.XML.Text:= XmlUserInfo;

    try
      try
        XmlDocumentMain.Active:= True;
      except on E: Exception do begin
          Log(E.Message);
        end;
      end;

    finally

      try
        Node:=XmlDocumentMain.DocumentElement.ChildNodes.Get(4);
        mNode:= Node;
        Node:=Node.ChildNodes.Get(0);
      except on E: Exception do begin
          Log(E.Message);
        end;

      end;

      API_USER_TOCKEN:= Node.NodeValue;


      {
        <new><!—用户新提醒-->
          <new_at></new_at><!—新@->
        <new_msg></new_msg><!—新私信->
        <new_beloved></new_beloved><!—新被喜欢-->
        <new_reply></new_reply><!—新评论-->
        <new_fans></new_fans><!—新粉丝-->
        </ new >

      }

      //获取用户消息数量
      try
        mNode:= mNode.ChildNodes.Get(4);
        Node:= mNode;

        mNode:=Node.ChildNodes.Get(0);
        iMsgAt:= StrToInt(mNode.NodeValue);

        mNode:=Node.ChildNodes.Get(1);
        iMsgNewPrice:= StrToInt(mNode.NodeValue);

        mNode:=Node.ChildNodes.Get(2);
        iMsgShopGoods:= StrToInt(mNode.NodeValue);


      except on E: Exception do begin
          Log(E.Message);
        end;

      end;


      //匹配设置需要报告的数量
      if (CONF_DISCOUNT_MSG = 0) then iMsgNewPrice:=0;
      if (CONF_AT_MSG = 0) then iMsgAt:=0;
      if (CONF_MALL_MSG = 0) then iMsgShopGoods:=0;

      API_USER_MSG_COUNT:= iMsgAt + iMsgNewPrice + iMsgShopGoods;

      DebugTrace('最终设置需要提醒的消息数量=', IntToStr(API_USER_MSG_COUNT));
    end;


  end;

  //释放XML对象
  FreeAndNil(XmlDocumentMain);
end;
{*******************************************************************************}
procedure ThreadUserTockenGet.Execute;
begin
  { Place thread code here }
  FreeOnTerminate:=True;

  APIGetUserTocken;
  if  API_USER_MSG_COUNT > 0 then
    Synchronize(ShowAlertMsgForm); //线程同步

end;
{*******************************************************************************}
procedure ThreadUserTockenGet.FreeIndyObject;
begin
  FreeAndNil(IdHttpMain);

end;
{*******************************************************************************}
procedure ThreadUserTockenGet.InitIndyObject;
begin
  //动态签名
  API_USER_SIGN:='app_id' + IntToStr(API_ID) + 'login_key' + USER_LOGIN_KEY
            + 'uid' + IntToStr(USER_ID) + 'username' + USER_NAME
            + API_KEY;

  IdHttpMain := TIdHTTP.Create(nil);
  IdHttpMain.Request.UserAgent := 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.4 (KHTML, like Gecko) Chrome/22.0.1229.79 Safari/537.4 AlexaToolbar/alxg-3.1';
  IdHttpMain.HandleRedirects := True;
  IdHttpMain.ReadTimeout := 5000;

end;
{*******************************************************************************}
procedure ThreadUserTockenGet.ShowAlertMsgForm;
begin
  ShowFormAlertMessage;
end;

{*******************************************************************************}
end.
