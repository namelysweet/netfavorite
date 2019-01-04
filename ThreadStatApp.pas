unit ThreadStatApp;

interface

uses
  ActiveX, Classes, SysUtils, ShlObj, Windows, XMLDom, XMLIntf, MSXMLDom, XMLDoc,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP, Forms,
  StrUtils, HTTPApp, Variants;

type
  ThreadAppStat = class(TThread)
  private
    { Private declarations }
  protected
    procedure InitIndyObject;

    procedure Execute; override;
    procedure StatInfoSend();//发送统计信息
    var
      IdHttpMain:TIdHTTP; //HTTP RFC
      //XmlDocumentMain:TXMLDocument;  //XML对象
  public
    constructor Create(Suspended: Boolean; OperationId, TimeSpan: Int64);
    destructor Destroy; override;
  end;

implementation

  uses EncdDecd, FormMain, MD5, FunctionCommon, SystemConfig;

  var iOperationId:integer;
      iTimeSpan: Int64;

{ 
  Important: Methods and properties of objects in visual components can only be
  used in a method called using Synchronize, for example,

      Synchronize(UpdateCaption);  

  and UpdateCaption could look like,

    procedure ThreadStatApp.UpdateCaption;
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

{ ThreadStatApp }

constructor ThreadAppStat.Create(Suspended: Boolean; OperationId, TimeSpan: Int64);
begin
  inherited Create(Suspended);
  iOperationId:=OperationId;
  iTimeSpan:=TimeSpan;

end;
{*******************************************************************************}
destructor ThreadAppStat.Destroy;
begin

  inherited Destroy;
end;
{*******************************************************************************}
procedure ThreadAppStat.Execute;
begin
  { Place thread code here }
  FreeOnTerminate := True;
  //Log('操作=' + IntToStr(iOperationId));
  InitIndyObject;
  StatInfoSend;  //发送统计数据

end;

{*******************************************************************************}
procedure ThreadAppStat.InitIndyObject;
begin

  IdHttpMain := TIdHTTP.Create(nil);
  IdHttpMain.Request.UserAgent := 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.4 (KHTML, like Gecko) Chrome/22.0.1229.79 Safari/537.4 AlexaToolbar/alxg-3.1';
  IdHttpMain.HandleRedirects := True;
  IdHttpMain.ReadTimeout := 5000;

  //XMLDocumentMain:= TXMLDocument.Create(Application);
  //XMLDocumentMain.Active:=False;
end;
{*******************************************************************************}
procedure ThreadAppStat.StatInfoSend;
var
  Param:TStringList;
  RStream:TStringStream;
  XmlUserInfo, STAT_SIGN, Params, Params64: string;
  Node:IXMLNode;
  ScreenWidth, ScreenHeight, OsVersion, AppVersion: string;
  //XmlResult:integer;
begin
  //XmlResult:=0;
  //URL参数
  Param:=TStringList.Create;
  RStream:=TStringStream.Create('',TEncoding.UTF8); //UTF-8

  //组合参数BASE64
  ScreenWidth:= IntToStr(Screen.Width);
  ScreenHeight:= IntToStr(Screen.Height);
  OsVersion:= FloatToStr(GetWindowsVersion);
  AppVersion:= frmMain.VersionInfoMain.FileVersion;

  Params:= 'screenwidth=' + ScreenWidth + '&screenheight=' + ScreenHeight + '&os=' + OsVersion + '&appver=' + AppVersion + '&timespan=' + IntToStr(iTimeSpan);
  Params64:= EncodeBase64(BytesOf(Params), Length(BytesOf(Params)));

  DebugTrace('统计字段','操作=' + IntToStr(iOperationId) + '用户=' + IntToStr(USER_ID) + ' - '
          + GBL_SYS_UINIQID + ' - 参数' + Params + ' - BASE64=' + Params64);

  STAT_SIGN:=StrToMD5('app_id' + IntToStr(API_ID) + 'device_id' + GBL_SYS_UINIQID
            + 'operation_type' + IntToStr(iOperationId) + 'params' + Params64
            + 'uid' + IntToStr(USER_ID)  + API_KEY , 9);   //统计签名

  DebugTrace('统计MD5:=', STAT_SIGN);
  //提交字段
  Param.Add('app_id=' + IntToStr(API_ID));
  Param.Add('device_id=' + GBL_SYS_UINIQID);  //机器唯一ID
  Param.Add('operation_type=' + IntToStr(iOperationId));  //1-新安装应用|2-打开应用|3-退出应用|4-卸载应用
  Param.Add('params=' + Params64);
  Param.Add('uid=' + IntToStr(USER_ID));

  Param.Add('sign=' + STAT_SIGN);



  try
    try
      IdHttpMain.Post(API_URL_STAT, Param, RStream);
    except on E: Exception do begin
        Log(E.Message);
      end;

    end;
  finally
    XmlUserInfo:= RStream.DataString;
  end;

  FreeAndNil(Param);
  FreeAndNil(RStream);

  FreeAndNil(IdHttpMain);


  {
    <?xml version="1.0" encoding="UTF-8"?><xiayijian>
      <status>1</status>
      <message></message>
    </xiayijian>
  }


  //升级接口
  {if (XmlUserInfo <> '') then begin

    DebugTrace('发送统计信息', XmlUserInfo);
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
        Node:=XmlDocumentMain.DocumentElement.ChildNodes.Get(0);
        //status=1成功
        XmlResult:= StrToInt(Node.NodeValue);
      except on E: Exception do begin
          Log(E.Message);
        end;

      end;

    end;

    FreeAndNil(XmlDocumentMain);

    if (XmlResult<>1) then Log('统计信息异常...');


  end;}
end;

{*******************************************************************************}
end.
