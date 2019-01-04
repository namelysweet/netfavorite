unit FormMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseFormMain, AppEvnts, Menus, OleCtrls, SHDocVw, ExtCtrls, pngimage,
  StdCtrls, RzPanel, GIFImg, RzTray, ImgList, RzLabel, RzStatus, DateUtils;

type
  TfrmMain = class(TfrmBaseMain)
    TrayIconMain: TRzTrayIcon;
    imglListTray: TImageList;
    PopupMenuTray: TPopupMenu;
    menuShowMainForm: TMenuItem;
    menuSettingTray: TMenuItem;
    menuSoftwareUpdateTray: TMenuItem;
    menuAboutTray: TMenuItem;
    menuClose: TMenuItem;
    popSplitTray2: TMenuItem;
    popSplitTray1: TMenuItem;
    lblUrlAD: TRzURLLabel;
    PopMenuSep1: TMenuItem;
    VersionInfoMain: TRzVersionInfo;
    lblVersionInfo: TRzURLLabel;
    TimerMain: TTimer;
    TimerStat: TTimer;
    TimerSync: TTimer;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure imgCloseClick(Sender: TObject);
    procedure menuCloseClick(Sender: TObject);
    procedure menuShowMainFormClick(Sender: TObject);
    procedure menuSettingTrayClick(Sender: TObject);
    procedure imgMinClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure lblUrlADMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure lblUrlADMouseLeave(Sender: TObject);
    procedure lblVersionInfoMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure lblVersionInfoMouseLeave(Sender: TObject);
    procedure lblVersionInfoClick(Sender: TObject);
    procedure menuAboutTrayClick(Sender: TObject);
    procedure menuSoftwareUpdateTrayClick(Sender: TObject);
    procedure menuCheckUpdateClick(Sender: TObject);
    procedure TimerMainTimer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TimerStatTimer(Sender: TObject);
    procedure TimerSyncTimer(Sender: TObject);

  private
    { Private declarations }
    procedure SetFormVar();//���ô����������
    procedure SendCloseStatInfo(); //���͹ر�ʱ��ͳ����Ϣ
  public
    { Public declarations }
    procedure WMSysCommand(var Message: TWMSysCommand); message WM_SYSCOMMAND;
    procedure MinApp(); //��С������
  protected
    { Protected declarations }

  end;

var
  frmMain: TfrmMain;
  StartUpTime: TDateTime;

implementation

  uses FunctionCommon, SystemConfig, FormLogin, ThreadGetUserToken,
       ThreadStatApp, ThreadCheckVersion, ThreadSyncFavorites;

  var threadU: ThreadUserTockenGet;
      threadC: ThreadVersionCheck;
      threadS: ThreadAppStat;
      threadF:ThreadFavoritesSync;//ͬ���ղؼ�

{$R *.dfm}


{*******************************************************************************}
procedure TfrmMain.FormActivate(Sender: TObject);
begin
  inherited;
  OnActivate:= nil ;

  //��ȡ�û�TOCKEN��֪ͨ
  if ((CONF_DISCOUNT_MSG = 1) or (CONF_MALL_MSG = 1) or (CONF_AT_MSG = 1)) then begin
    threadU:= ThreadUserTockenGet.Create(False);
    TimerMain.Enabled:= True;  //����û���Ϣ��ʾ
  end;

  if CONF_AUTO_SYNC = 1 then begin
    threadF:= ThreadFavoritesSync.Create(False, False);
    TimerSync.Enabled := True; //�Ƿ����Զ�ͬ��
  end;

  //1-�°�װӦ��|2-��Ӧ��|3-�˳�Ӧ��|4-ж��Ӧ�� |5-��Ծ
  threadS:= ThreadAppStat.Create(False, 2, 0);

  //���汾����
  if CONF_AUTO_UPDATE = 1 then lblVersionInfoClick(Self);

  //��һ��������ʾ�˶Ի���
  if (CONF_IMPORT_COUNT < 1) then ShowFormSyncImport;

  if (ParamStr(1)='-static') then begin
    //������������
    imgMinClick(Self);
  end;

  TimerStat.Enabled:= True;  //���ڷ���ͳ����Ϣ

end;

{*******************************************************************************}

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  SendCloseStatInfo;
end;
{*******************************************************************************}
procedure TfrmMain.FormCreate(Sender: TObject);
begin
  wbBase.Silent:=True;
  wbBase.Navigate(DEF_URL_MAIN);

end;
{*******************************************************************************}
procedure TfrmMain.FormShow(Sender: TObject);
begin
  inherited;
  SetFormVar;

  if not GBL_IS_LOGIN then begin
    ShowFormLogin;
  end;

  SetPosition;


end;
{*******************************************************************************}
procedure TfrmMain.imgCloseClick(Sender: TObject);
begin
  if CONF_CLOSE_TIP=1 then ShowFormCloseTip;//�ر���ʾ
  MinApp;

end;
{*******************************************************************************}
procedure TfrmMain.imgMinClick(Sender: TObject);
begin
  inherited;
  TrayIconMain.ShowBalloonHint(GBL_SYS_APPNAME, GBL_SYS_APPNAME + ', ����������������ϵͳ������.');
end;
{*******************************************************************************}
procedure TfrmMain.lblUrlADMouseLeave(Sender: TObject);
begin
  inherited;
  lblUrlAD.Font.Style:=[];
end;
{*******************************************************************************}
procedure TfrmMain.lblUrlADMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  inherited;
  lblUrlAD.Font.Style:=[fsUnderline];
end;
{*******************************************************************************}
procedure TfrmMain.lblVersionInfoClick(Sender: TObject);
begin
  threadC:= ThreadVersionCheck.Create(False, VersionInfoMain.FileVersion);
  lblVersionInfo.Caption:='�汾 '+VersionInfoMain.FileVersion + ' (���ڼ�����) ...';

end;
{*******************************************************************************}
procedure TfrmMain.lblVersionInfoMouseLeave(Sender: TObject);
begin
  inherited;
  lblVersionInfo.Font.Style:=[];
end;
{*******************************************************************************}
procedure TfrmMain.lblVersionInfoMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  inherited;
  lblVersionInfo.Font.Style:=[fsUnderline];
end;

{*******************************************************************************}
procedure TfrmMain.MinApp;
begin
  //����ϵͳ����,ִ��ִ�нػ��ϵͳ��Ϣ
  if CONF_CLOSE_MIN = 1 then begin
    Perform(WM_SYSCOMMAND, SC_MINIMIZE, 0);
    TrayIconMain.ShowBalloonHint(GBL_SYS_APPNAME, GBL_SYS_APPNAME + ', ����������������ϵͳ������.');
  end else begin
    Close;
  end;
end;
{*******************************************************************************}
procedure TfrmMain.menuAboutTrayClick(Sender: TObject);
begin
  inherited;
  ShowFormAbout;
end;
{*******************************************************************************}
procedure TfrmMain.menuCheckUpdateClick(Sender: TObject);
begin
  inherited;
  lblVersionInfoClick(Self);
end;
{*******************************************************************************}
procedure TfrmMain.menuCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

{*******************************************************************************}
procedure TfrmMain.menuSettingTrayClick(Sender: TObject);
begin
  inherited;
  ShowFormSetting;
end;
{*******************************************************************************}
procedure TfrmMain.menuShowMainFormClick(Sender: TObject);
begin
  inherited;
  TrayIconMain.RestoreApp;
end;
{*******************************************************************************}
procedure TfrmMain.menuSoftwareUpdateTrayClick(Sender: TObject);
begin
  inherited;
  lblVersionInfoClick(Self);
end;

{*******************************************************************************}
procedure TfrmMain.SendCloseStatInfo;
var TimeSpan:Int64;
    CloseTime: TDateTime;
begin
  CloseTime:=Now();
  //����ʱ���
  TimeSpan:= SecondsBetween(StartUpTime, CloseTime);

  //20����Ĭ�ϼ��: 1-�°�װӦ��|2-��Ӧ��|3-�˳�Ӧ��|4-ж��Ӧ�� |5-��Ծ
  threadS:= ThreadAppStat.Create(False, 3, TimeSpan);

  if (CONF_AUTO_LOGIN<>1) then begin
    GBL_IS_LOGIN:=False;
    GBL_IS_EXIT:= True;
    wbBase.Navigate(DEF_URL_LOGOUT);
  end;

end;
{*******************************************************************************}
procedure TfrmMain.SetFormVar;
begin
  StartUpTime:= Now();
  DebugTrace('ϵͳ����ʱ��', DateTimeToStr(StartUpTime));

  Width:= DEF_FORM_MAIN_WIDTH;
  Height:= DEF_FORM_MAIN_HEIGHT;

  GBL_SYS_VERSION:= VersionInfoMain.FileVersion;

  Caption:=GBL_SYS_APPNAME + ' ' + GBL_SYS_VERSION;
  {$IFDEF DEBUG}
    Caption:=Caption + ' �ڲ����԰� - �����⴫';
  {$ENDIF}
  lblTitleBase.Caption:= Caption + ' Beta';

  lblVersionInfo.Caption:='�汾 '+VersionInfoMain.FileVersion + ' (������)';

  //��ȡʱ��������
  TimerMain.Interval:= CONF_TIMER_MSG;
  TimerStat.Interval:=CONF_TIMER_STAT;
  TimerSync.Interval:=CONF_TIMER_SYNC;
end;
{*******************************************************************************}
procedure TfrmMain.TimerMainTimer(Sender: TObject);
begin
  inherited;
  //1Сʱִ��һ��-��ȡ�û���Ϣ��ʾ
  threadU:= ThreadUserTockenGet.Create(False);
end;
{*******************************************************************************}
procedure TfrmMain.TimerStatTimer(Sender: TObject);
var TimeSpan:Int64;
    CloseTime: TDateTime;
begin
  //���ʹ򿪺��ͳ����Ϣ
  CloseTime:=Now();
  //����ʱ���
  TimeSpan:= SecondsBetween(StartUpTime, CloseTime);
  inherited;
  //20����Ĭ�ϼ��:
  //1-�°�װӦ��|2-��Ӧ��|3-�˳�Ӧ��|4-ж��Ӧ�� |5-��Ծ
  threadS:= ThreadAppStat.Create(False, 5, TimeSpan);
end;
{*******************************************************************************}
procedure TfrmMain.TimerSyncTimer(Sender: TObject);
begin
  inherited;
  //�Զ�ͬ��
  threadF:= ThreadFavoritesSync.Create(False, False);
end;

{*******************************************************************************}
procedure TfrmMain.WMSysCommand(var Message: TWMSysCommand);
begin

  case Message.CmdType of
    SC_CLOSE: begin
                if CONF_CLOSE_TIP=1 then ShowFormCloseTip;//�ر���ʾ
                MinApp;
                Exit;
             end;
  end;
  inherited;
end;

{*******************************************************************************}
end.
