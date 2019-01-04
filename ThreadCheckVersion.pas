unit ThreadCheckVersion;

interface

uses
  ActiveX, Classes, SysUtils, ShlObj, Windows, XMLDom, XMLIntf, MSXMLDom, XMLDoc,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP, Forms,
  StrUtils, HTTPApp, Variants;

type
  ThreadVersionCheck = class(TThread)
  private
    { Private declarations }
    procedure SyncFormLinkText();//�߳�ͬ��
    procedure GetAPIUpdateInfo();//��ȡAPI������Ϣ

  protected
    procedure InitIndyObject;
    procedure FreeIndyObject;
    procedure Execute; override;
    var
      IdHttpMain:TIdHTTP; //HTTP RFC
      XmlDocumentMain:TXMLDocument;  //XML����
      AppVersionInfo: string;
      iUpdate:integer;//�Ƿ���Ҫ����

  public
    constructor Create(Suspended:Boolean;VersionInfo:string);
    destructor Destroy; override;

  end;

implementation

  uses MD5, FormMain, FormUpdate, FunctionCommon, SystemConfig;


{ 
  Important: Methods and properties of objects in visual components can only be
  used in a method called using Synchronize, for example,

      Synchronize(UpdateCaption);  

  and UpdateCaption could look like,

    procedure ThreadCheckVersion.UpdateCaption;
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

{ ThreadCheckVersion }

constructor ThreadVersionCheck.Create(Suspended: Boolean; VersionInfo: string);
begin
  inherited Create(Suspended);
  AppVersionInfo:= VersionInfo;
end;
{*******************************************************************************}
destructor ThreadVersionCheck.Destroy;
begin
  inherited Destroy;
end;
{*******************************************************************************}
procedure ThreadVersionCheck.Execute;
begin
  { Place thread code here }
  FreeOnTerminate:= True;
  iUpdate:= 0;
  GetAPIUpdateInfo(); //��ȡ�����ӿ���Ϣ

  Synchronize(SyncFormLinkText);
end;
{*******************************************************************************}
procedure ThreadVersionCheck.FreeIndyObject;
begin
  FreeAndNil(IdHttpMain);
end;
{*******************************************************************************}
procedure ThreadVersionCheck.GetAPIUpdateInfo;
var
  Param:TStringList;
  RStream:TStringStream;
  XmlUserInfo, UPDATE_SIGN: string;
  Node:IXMLNode;
begin
  DebugTrace('�����ӿ�', AppVersionInfo);
  InitIndyObject;//��ʼ��HTTP����

  //XML
  XMLDocumentMain:= TXMLDocument.Create(Application);
  XMLDocumentMain.Active:=False;
  XmlUserInfo:='';
  //URL����
  Param:=TStringList.Create;
  RStream:=TStringStream.Create('',TEncoding.UTF8); //UTF-8

  UPDATE_SIGN:=StrToMD5('app_id' + IntToStr(API_ID) + 'version' + AppVersionInfo
            + API_KEY , 9);

  DebugTrace('����MD5:=', UPDATE_SIGN);
  //�ύ�ֶ�
  Param.Add('app_id=' + IntToStr(API_ID));
  Param.Add('version='+ AppVersionInfo);
  Param.Add('sign=' + UPDATE_SIGN);

  try
    try
      IdHttpMain.Post(API_URL_UPDATE, Param, RStream);
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

  //�����ӿ�
  if (XmlUserInfo <> '') then begin

    DebugTrace('��ȡ������Ϣ�ӿ�', XmlUserInfo);

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

        iUpdate:= StrToInt(Node.ChildNodes.Get(0).NodeValue);

        if (iUpdate<>0) then begin
          UPDATE_APP_VER:= Node.ChildNodes.Get(1).NodeValue;
          UPDATE_APP_INFO:= Node.ChildNodes.Get(2).NodeValue;
          UPDATE_APP_URL:= Node.ChildNodes.Get(3).NodeValue;
        end;

      except on E: Exception do begin
          Log(E.Message);
        end;

      end;


    {
    <?xml version="1.0" encoding="UTF-8"?>
      <xiayijian>
        <status>1</status>
        <message></message>
          <totalcount>0</totalcount>
          <pagecount>0</pagecount>
        <data>
          <update>1</update>
          <last_ver><![CDATA[1.0.0]]></last_ver>
          <update_log><![CDATA[�ڲ����԰�]]></update_log>
          <url><![CDATA[]]></url>
        </data>
      </xiayijian>
    }

      DebugTrace('����URL��ַ=', UPDATE_APP_URL);
    end;


  end;

  //�ͷ�XML����
  FreeAndNil(XmlDocumentMain);
end;

{*******************************************************************************}
procedure ThreadVersionCheck.InitIndyObject;
begin
  IdHttpMain := TIdHTTP.Create(nil);
  IdHttpMain.Request.UserAgent := 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.4 (KHTML, like Gecko) Chrome/22.0.1229.79 Safari/537.4 AlexaToolbar/alxg-3.1';
  IdHttpMain.HandleRedirects := True;
  IdHttpMain.ReadTimeout := 5000;
end;
{*******************************************************************************}
procedure ThreadVersionCheck.SyncFormLinkText;
begin
  if iUpdate=0 then begin
    frmMain.lblVersionInfo.Caption:= '�汾 ' + frmMain.VersionInfoMain.FileVersion + ' (�������°�)';
  end else begin
    frmMain.lblVersionInfo.Caption:= '�汾 ' + frmMain.VersionInfoMain.FileVersion + ' (���°汾)';
    ShowFormUpdate; //��������
  end;
end;
{*******************************************************************************}
end.
