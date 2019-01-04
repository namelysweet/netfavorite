unit ThreadSyncFavorites;

interface

uses
  ActiveX, Classes, SysUtils, ShlObj, Windows, XMLDom, XMLIntf, MSXMLDom, XMLDoc,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP, Forms,
  IdAntiFreezeBase, IdAntiFreeze, StrUtils, HTTPApp, Variants;

type
  ThreadFavoritesSync = class(TThread)
  private
    procedure InitIndyObject;
    procedure FreeIndyObject;
    { Private declarations }
  protected
    procedure Execute; override;
    procedure SyncFormCaptions();//��ɺ����ֵĵ���
    procedure SwitchSyncTab();
    procedure InitSystemVar();//��ʼ��ϵͳ����
    procedure GetUserIEFavorites();//��ȡIE�ղؼ�
    procedure FreeSystemVar();
    procedure FreePidl(pidl: PItemIDList);
    procedure ProcessFavorData();//���������ղؼ�����
    procedure SyncProcess();//�߳�ͬ��ʵʱ��������
    procedure APIGetUserTocken();//��ȡ�û�TOKEN
    procedure GetAPIFavorResult();//��ȡͬ�����

    var
      IdHttpMain:TIdHTTP; //HTTP RFC
      XmlDocumentMain:TXMLDocument;  //XML����
      IdAntiFreezeMain: TIdAntiFreeze;

  public
    constructor Create(Suspended: Boolean; IsShowForm: Boolean);
    destructor Destroy; override;

  end;

var iImport, iCurrent, iSum, iFinish, iTotal: Integer;
    TASK_ID: string = '';

implementation

  uses MD5, FormImportSync, FrameImportSyncStepTwo, FunctionCommon, SystemConfig;

var slFavor: TStrings;
    NeedShowForm: Boolean;

{ 
  Important: Methods and properties of objects in visual components can only be
  used in a method called using Synchronize, for example,

      Synchronize(UpdateCaption);  

  and UpdateCaption could look like,

    procedure ThreadSyncFavorites.UpdateCaption;
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

{ ThreadSyncFavorites }

{*******************************************************************************}
constructor ThreadFavoritesSync.Create(Suspended, IsShowForm: Boolean);
begin
  inherited Create(Suspended);
  NeedShowForm:=IsShowForm;

end;
{*******************************************************************************}
destructor ThreadFavoritesSync.Destroy;
begin

  inherited Destroy;
end;
{*******************************************************************************}
procedure ThreadFavoritesSync.Execute;
begin
  { Place thread code here }
  FreeOnTerminate:=True;

  InitSystemVar;
  GetUserIEFavorites;
  APIGetUserTocken;
  ProcessFavorData; //��������

  GetAPIFavorResult; //��ȡ���

  FreeSystemVar;

  if NeedShowForm then begin
    Synchronize(SyncFormCaptions);
    Sleep(300);
    Synchronize(SwitchSyncTab);//������ת
  end;

end;
{*******************************************************************************}
procedure ThreadFavoritesSync.FreePidl(pidl: PItemIDList);
var
  allocator: IMalloc;
begin
  if Succeeded(SHGetMalloc(allocator)) then
  begin
    allocator.Free(pidl);
    {$IFDEF VER100}
    allocator.Release;
    {$ENDIF}
  end;
end;
{*******************************************************************************}
procedure ThreadFavoritesSync.FreeSystemVar;
begin
  FreeAndNil(slFavor);
  FreeAndNil(IdAntiFreezeMain);
end;

{*******************************************************************************}
procedure ThreadFavoritesSync.GetAPIFavorResult;
var
  Param:TStringList;
  RStream:TStringStream;
  XmlResultInfo, TASK_SIGN: string;
  fNode, tNode:IXMLNode;
begin
  if TASK_ID <> '' then begin

    TASK_SIGN:= StrToMD5('app_id' + IntToStr(API_ID) + 'queue_id' + TASK_ID
            + 'uid' + IntToStr(USER_ID) + API_KEY + API_USER_TOCKEN, 9);

    InitIndyObject;//��ʼ��HTTP����
    //XML
    XMLDocumentMain:=TXMLDocument.Create(Application);
    XMLDocumentMain.Active:=False;
    XmlResultInfo:='';
    //URL����
    Param:=TStringList.Create;
    RStream:=TStringStream.Create('',TEncoding.UTF8); //UTF-8
    //�ύ�ֶ�
    Param.Add('app_id=' + IntToStr(API_ID));
    Param.Add('uid='+ IntToStr(USER_ID));
    Param.Add('queue_id=' + TASK_ID);
    Param.Add('sign=' + TASK_SIGN);

    try
      try
        IdHttpMain.Post(API_URL_SYNC_PROGRESS, Param, RStream);
      except on E: Exception do begin
          Log(E.Message);
        end;

      end;
    finally
      XmlResultInfo:= RStream.DataString;
    end;

    FreeIndyObject; //�ͷ�HTTP����
    FreeAndNil(Param);
    FreeAndNil(RStream);

    //��ȡ�û�Token
    if (XmlResultInfo <> '') then begin

      DebugTrace('��ȡ�ղؼ�ͬ������ӿ�', XmlResultInfo);

      XmlDocumentMain.XML.Text:= XmlResultInfo;

      try
        try
          XmlDocumentMain.Active:= True;
        except on E: Exception do begin
            Log(E.Message);
          end;
        end;

      finally

        try
          tNode:=XmlDocumentMain.DocumentElement.ChildNodes.Get(4);
          fNode:=tNode;

          tNode:=tNode.ChildNodes.Get(1);  //Total
          fNode:=fNode.ChildNodes.Get(3);  //Finish Done
        except on E: Exception do begin
            Log(E.Message);
          end;

        end;

        iTotal:= StrToInt(tNode.NodeValue);
        iFinish:= StrToInt(tNode.NodeValue);

        //DebugTrace('����='+tNode.NodeValue+'|���='+fNode.NodeValue);
      end;


    end;

    //�ͷ�XML����
    FreeAndNil(XmlDocumentMain);

  end;
end;
{*******************************************************************************}
procedure ThreadFavoritesSync.GetUserIEFavorites;
var
  pidl: PItemIDList;
  FavPath: array[0..MAX_PATH] of Char;
begin
  if Succeeded(ShGetSpecialFolderLocation(Handle, CSIDL_FAVORITES, pidl)) then
  begin
    if ShGetPathfromIDList(pidl, FavPath) then
      slFavor:=GetIEFavourites(StrPas(FavPath));
      iSum:= slFavor.Count;
      // The calling application is responsible for freeing the PItemIDList-pointer
      // with the Shell's IMalloc interface
    FreePIDL(pidl);
  end;
end;
{*******************************************************************************}
procedure ThreadFavoritesSync.APIGetUserTocken;
var
  Param:TStringList;
  RStream:TStringStream;
  XmlUserInfo: string;
  Node:IXMLNode;
  UserSign: RawByteString;
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
        Node:=Node.ChildNodes.Get(0);
      except on E: Exception do begin
          Log(E.Message);
        end;

      end;

      API_USER_TOCKEN:= Node.NodeValue;
    end;


  end;

  //�ͷ�XML����
  FreeAndNil(XmlDocumentMain);


end;
{*******************************************************************************}
procedure ThreadFavoritesSync.FreeIndyObject;
begin
  //�ͷ�HTTP���ʶ���
  FreeAndNil(IdHttpMain);
end;
{*******************************************************************************}
procedure ThreadFavoritesSync.InitIndyObject;
begin
  //INDY
  IdHttpMain := TIdHTTP.Create(nil);
  IdHttpMain.Request.UserAgent := 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.4 (KHTML, like Gecko) Chrome/22.0.1229.79 Safari/537.4 AlexaToolbar/alxg-3.1';
  IdHttpMain.HandleRedirects := True;
  IdHttpMain.ReadTimeout := 5000;

end;

{*******************************************************************************}
procedure ThreadFavoritesSync.InitSystemVar;
begin
  iImport:=0;
  iSum:=0;
  iCurrent:=0;
  iFinish:=0;
  iTotal:=0;
  slFavor:=TStringList.Create;
  if NeedShowForm then frmImportSync.FrameSyncStep2.ProgressBarSync.Percent:=0;


  //��̬����SIGNǩ��
  API_USER_SIGN:='app_id' + IntToStr(API_ID) + 'login_key' + USER_LOGIN_KEY
            + 'uid' + IntToStr(USER_ID) + 'username' + USER_NAME
            + API_KEY;


  IdAntiFreezeMain:=TIdAntiFreeze.Create(nil);
  IdAntiFreezeMain.OnlyWhenIdle:= False;
end;
{*******************************************************************************}
procedure ThreadFavoritesSync.ProcessFavorData;
var I:integer;
    tempUrl, XmlFavorInfo, FAV_DATA, FAV_SIGN: string;
    Param:TStringList;
    RStream:TStringStream;
    Node:IXMLNode;
begin
  FAV_DATA:='';
  XmlFavorInfo:='';
  for I := 0 to iSum - 1 do begin
    iCurrent:=I;

    //�ж�ֻ��TAOBAO|TMALL��վ�����÷���
    tempUrl:= HTTPEncode(slFavor.Strings[I]);//URL
    if ((Pos('taobao.com', LowerCase(tempUrl))<>0) or (Pos('tmall.com', LowerCase(tempUrl))<>0)) then begin

      Inc(iImport);  //������ٸ��ղ���Ʒ
      FAV_DATA:= FAV_DATA + tempUrl + '{|}' + '{||}';


    end;


    Synchronize(SyncProcess);
  end;

  if FAV_DATA<>'' then
    FAV_DATA:= LeftStr(FAV_DATA, Length(FAV_DATA)-4);

  //DebugTrace('�ղؼ�����', FAV_DATA);

  //��̬ǩ��
  FAV_SIGN:= StrToMD5('app_id' + IntToStr(API_ID) + 'favor_data' + FAV_DATA
            + 'uid' + IntToStr(USER_ID) + API_KEY + API_USER_TOCKEN, 9);


  if ((iImport <> 0) and (FAV_DATA <> '')) then begin

    //���������ղؼ�����
    InitIndyObject;

    //URL����
    Param:=TStringList.Create;
    RStream:=TStringStream.Create('',TEncoding.UTF8); //UTF-8

    //�ύ�ֶ�
    Param.Add('app_id=' + IntToStr(API_ID));
    Param.Add('uid='+ IntToStr(USER_ID));
    Param.Add('favor_data=' + FAV_DATA);
    Param.Add('sign=' + FAV_SIGN);

    try
      try
        IdHttpMain.Post(API_URL_SYNC_FAVOR, Param, RStream);
      except on E: Exception do begin
          Log(E.Message);
        end;

      end;
    finally
      XmlFavorInfo:= RStream.DataString;
    end;

    FreeIndyObject; //�ͷ�HTTP����
    FreeAndNil(Param);
    FreeAndNil(RStream);


    //��ȡ����ID
    if (XmlFavorInfo <> '') then begin

      //XML
      XMLDocumentMain:=TXMLDocument.Create(Application);
      XMLDocumentMain.Active:=False;

      XmlDocumentMain.XML.Text:= XmlFavorInfo;

      DebugTrace('��ȡ����ID�ӿ�', XmlFavorInfo);
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
          Node:=Node.ChildNodes.Get(1);
        except on E: Exception do begin
            Log(E.Message);
          end;

        end;

        TASK_ID:= VarToStr(Node.NodeValue);  //��ȡ����ID

      end;


    end;

    FreeAndNil(XmlDocumentMain);

  end;


end;

{*******************************************************************************}
procedure ThreadFavoritesSync.SwitchSyncTab;
begin
  if iImport = 0 then begin
    frmImportSync.FrameSyncStep2.PageControlStepSync.ActivePageIndex:=2;
  end else begin
    frmImportSync.FrameSyncStep2.PageControlStepSync.ActivePageIndex:=1;
  end;
end;
{*******************************************************************************}
procedure ThreadFavoritesSync.SyncFormCaptions;
begin
  frmImportSync.FrameSyncStep2.ProgressBarSync.Percent:=100;
  frmImportSync.FrameSyncStep2.lblProcess.Caption:= IntToStr(iImport);
  frmImportSync.FrameSyncStep2.lblRet1.Caption:=IntToStr(iImport);

  //frmImportSync.btnOk.Visible:=False;
  frmImportSync.btnSmall.Caption:='���';
  frmImportSync.Caption:= '����ɹ�';
  frmImportSync.lblTitleBase.Caption:='����ɹ�';
  frmImportSync.FrameSyncStep2.SetLastLabelPostion;
end;
{*******************************************************************************}
procedure ThreadFavoritesSync.SyncProcess;
begin
  if iSum <> 0 then begin
    if NeedShowForm then begin
      frmImportSync.FrameSyncStep2.ProgressBarSync.Percent:= iCurrent*100 div iSum;
    end;

  end;

end;

{*******************************************************************************}
end.
