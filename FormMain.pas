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
    procedure SetFormVar();//设置窗体变量设置
    procedure SendCloseStatInfo(); //发送关闭时的统计信息
  public
    { Public declarations }
    procedure WMSysCommand(var Message: TWMSysCommand); message WM_SYSCOMMAND;
    procedure MinApp(); //最小化窗体
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
      threadF:ThreadFavoritesSync;//同步收藏夹

{$R *.dfm}


{*******************************************************************************}
procedure TfrmMain.FormActivate(Sender: TObject);
begin
  inherited;
  OnActivate:= nil ;

  //获取用户TOCKEN和通知
  if ((CONF_DISCOUNT_MSG = 1) or (CONF_MALL_MSG = 1) or (CONF_AT_MSG = 1)) then begin
    threadU:= ThreadUserTockenGet.Create(False);
    TimerMain.Enabled:= True;  //检查用户消息提示
  end;

  if CONF_AUTO_SYNC = 1 then begin
    threadF:= ThreadFavoritesSync.Create(False, False);
    TimerSync.Enabled := True; //是否开启自动同步
  end;

  //1-新安装应用|2-打开应用|3-退出应用|4-卸载应用 |5-活跃
  threadS:= ThreadAppStat.Create(False, 2, 0);

  //检测版本更新
  if CONF_AUTO_UPDATE = 1 then lblVersionInfoClick(Self);

  //第一次启动提示此对话框
  if (CONF_IMPORT_COUNT < 1) then ShowFormSyncImport;

  if (ParamStr(1)='-static') then begin
    //参数启动设置
    imgMinClick(Self);
  end;

  TimerStat.Enabled:= True;  //定期发送统计信息

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
  if CONF_CLOSE_TIP=1 then ShowFormCloseTip;//关闭提示
  MinApp;

end;
{*******************************************************************************}
procedure TfrmMain.imgMinClick(Sender: TObject);
begin
  inherited;
  TrayIconMain.ShowBalloonHint(GBL_SYS_APPNAME, GBL_SYS_APPNAME + ', 将继续运行在您的系统托盘中.');
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
  lblVersionInfo.Caption:='版本 '+VersionInfoMain.FileVersion + ' (正在检查更新) ...';

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
  //根据系统设置,执行执行截获的系统消息
  if CONF_CLOSE_MIN = 1 then begin
    Perform(WM_SYSCOMMAND, SC_MINIMIZE, 0);
    TrayIconMain.ShowBalloonHint(GBL_SYS_APPNAME, GBL_SYS_APPNAME + ', 将继续运行在您的系统托盘中.');
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
  //计算时间差
  TimeSpan:= SecondsBetween(StartUpTime, CloseTime);

  //20分钟默认间隔: 1-新安装应用|2-打开应用|3-退出应用|4-卸载应用 |5-活跃
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
  DebugTrace('系统启动时间', DateTimeToStr(StartUpTime));

  Width:= DEF_FORM_MAIN_WIDTH;
  Height:= DEF_FORM_MAIN_HEIGHT;

  GBL_SYS_VERSION:= VersionInfoMain.FileVersion;

  Caption:=GBL_SYS_APPNAME + ' ' + GBL_SYS_VERSION;
  {$IFDEF DEBUG}
    Caption:=Caption + ' 内部测试版 - 请勿外传';
  {$ENDIF}
  lblTitleBase.Caption:= Caption + ' Beta';

  lblVersionInfo.Caption:='版本 '+VersionInfoMain.FileVersion + ' (检查更新)';

  //获取时间间隔配置
  TimerMain.Interval:= CONF_TIMER_MSG;
  TimerStat.Interval:=CONF_TIMER_STAT;
  TimerSync.Interval:=CONF_TIMER_SYNC;
end;
{*******************************************************************************}
procedure TfrmMain.TimerMainTimer(Sender: TObject);
begin
  inherited;
  //1小时执行一次-获取用户消息提示
  threadU:= ThreadUserTockenGet.Create(False);
end;
{*******************************************************************************}
procedure TfrmMain.TimerStatTimer(Sender: TObject);
var TimeSpan:Int64;
    CloseTime: TDateTime;
begin
  //发送打开后的统计信息
  CloseTime:=Now();
  //计算时间差
  TimeSpan:= SecondsBetween(StartUpTime, CloseTime);
  inherited;
  //20分钟默认间隔:
  //1-新安装应用|2-打开应用|3-退出应用|4-卸载应用 |5-活跃
  threadS:= ThreadAppStat.Create(False, 5, TimeSpan);
end;
{*******************************************************************************}
procedure TfrmMain.TimerSyncTimer(Sender: TObject);
begin
  inherited;
  //自动同步
  threadF:= ThreadFavoritesSync.Create(False, False);
end;

{*******************************************************************************}
procedure TfrmMain.WMSysCommand(var Message: TWMSysCommand);
begin

  case Message.CmdType of
    SC_CLOSE: begin
                if CONF_CLOSE_TIP=1 then ShowFormCloseTip;//关闭提示
                MinApp;
                Exit;
             end;
  end;
  inherited;
end;

{*******************************************************************************}
end.
