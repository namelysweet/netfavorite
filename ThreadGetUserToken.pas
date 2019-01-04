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
    procedure APIGetUserTocken();//��ȡ�û�TOKEN
    procedure ShowAlertMsgForm();//������ʾ��Ϣ����

    var
      IdHttpMain:TIdHTTP; //HTTP RFC
      XmlDocumentMain:TXMLDocument;  //XML����
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
  InitIndyObject;//��ʼ��HTTP����
  //XML
  XMLDocumentMain:=TXMLDocument.Create(Application);
  XMLDocumentMain.Active:=False;
  XmlUserInfo:='';
  //URL����
  Param:=TStringList.Create;
  RStream:=TStringStream.Create('',TEncoding.UTF8); //UTF-8

  //���Ĵ���
  DebugTrace('ǩ��:=', API_USER_SIGN);

  UserSign:=UTF8Encode(API_USER_SIGN);
  SetCodePage(UserSign, 0, False);//��Ҫע�ᴦ��
  UserSign:=StrToMD5(UserSign, 9);

  DebugTrace('ǩ��MD5:=', UserSign);
  //�ύ�ֶ�
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


  FreeIndyObject; //�ͷ�HTTP����
  FreeAndNil(Param);
  FreeAndNil(RStream);

  //��ȡ�û�Token
  if (XmlUserInfo <> '') then begin

    DebugTrace('��ȡ�û�TOKEN�ӿ�', XmlUserInfo);

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
        <new><!���û�������-->
          <new_at></new_at><!����@->
        <new_msg></new_msg><!����˽��->
        <new_beloved></new_beloved><!���±�ϲ��-->
        <new_reply></new_reply><!��������-->
        <new_fans></new_fans><!���·�˿-->
        </ new >

      }

      //��ȡ�û���Ϣ����
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


      //ƥ��������Ҫ���������
      if (CONF_DISCOUNT_MSG = 0) then iMsgNewPrice:=0;
      if (CONF_AT_MSG = 0) then iMsgAt:=0;
      if (CONF_MALL_MSG = 0) then iMsgShopGoods:=0;

      API_USER_MSG_COUNT:= iMsgAt + iMsgNewPrice + iMsgShopGoods;

      DebugTrace('����������Ҫ���ѵ���Ϣ����=', IntToStr(API_USER_MSG_COUNT));
    end;


  end;

  //�ͷ�XML����
  FreeAndNil(XmlDocumentMain);
end;
{*******************************************************************************}
procedure ThreadUserTockenGet.Execute;
begin
  { Place thread code here }
  FreeOnTerminate:=True;

  APIGetUserTocken;
  if  API_USER_MSG_COUNT > 0 then
    Synchronize(ShowAlertMsgForm); //�߳�ͬ��

end;
{*******************************************************************************}
procedure ThreadUserTockenGet.FreeIndyObject;
begin
  FreeAndNil(IdHttpMain);

end;
{*******************************************************************************}
procedure ThreadUserTockenGet.InitIndyObject;
begin
  //��̬ǩ��
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
