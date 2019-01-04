unit FormLogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseFormMain, AppEvnts, Menus, GIFImg, OleCtrls, SHDocVw, ExtCtrls,
  StdCtrls, RzPanel, DB, ADODB, ImgList, Registry;

type
  TfrmLogin = class(TfrmBaseMain)
    ADOConnectionMain: TADOConnection;
    ADOQueryMain: TADOQuery;
    procedure FormShow(Sender: TObject);
    procedure imgCloseClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);

  private
    { Private declarations }
    procedure RegisterUniqId();//写入注册表
  public
    { Public declarations }
    procedure ConnDB();
    procedure FreeDB();
    procedure LoadConf();//加载配置信息
    procedure SaveConf(iStartUp, iCloseMin, iCloseTip, iAutoLogin, iDiscountMsg,
              iMallMsg, iAutoSync, iAutoUpdate, iAtMsg: Integer);//保存配置
    procedure SaveConfCloseTip(iCloseTip, iCloseMin: integer); //仅保存部分配置--关闭提醒
    procedure WMSysCommand(var Message: TWMSysCommand); message WM_SYSCOMMAND;
    procedure UpdateRunTime();
    procedure UpdateImportCount();
  end;

var
  frmLogin: TfrmLogin;

implementation

  uses SystemConfig, FunctionCommon;
{$R *.dfm}


{*******************************************************************************}

procedure TfrmLogin.ConnDB;
var
  ConnStr: string;
begin
  ConnStr := 'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=' + ExtractFilePath
    (ParamStr(0)) +
    '\config\config.conf;Persist Security Info=False;Jet OLEDB:Database ' +
    'Password='+ CONF_DB_PASS;
  with ADOConnectionMain do
  begin
    ConnectionString := ConnStr;
    LoginPrompt := false;
    try
      Connected := True;
    except
      on e: Exception do
      begin
        Log(e.Message);
        Application.MessageBox('数据配置文件丢失或已损坏! 请重新下载新版本修复!', '错误',
          MB_OK + MB_ICONEXCLAMATION);
        Application.Terminate;
      end;
    end;
  end;
end;
{*******************************************************************************}
procedure TfrmLogin.FormActivate(Sender: TObject);
begin
  inherited;
  OnActivate:=nil;
  UpdateRunTime();
end;

{*******************************************************************************}
procedure TfrmLogin.FormShow(Sender: TObject);
begin
  inherited;
  Width:= DEF_FORM_LOGIN_WIDTH;
  Height:= DEF_FORM_LOGIN_HEIGHT;
  Caption:= GBL_SYS_APPNAME + ' - 登录';
  lblTitleBase.Caption := Caption;
  //加载配置信息
  LoadConf;
end;
{*******************************************************************************}
procedure TfrmLogin.FreeDB;
begin
  ADOQueryMain.Close;
  ADOConnectionMain.Close;
end;
{*******************************************************************************}
procedure TfrmLogin.imgCloseClick(Sender: TObject);
begin
  inherited;
  Application.Terminate;
end;

{*******************************************************************************}
procedure TfrmLogin.LoadConf;
var query: string;
begin
  GBL_SYS_UINIQID:= GetCurrenPCUniqId; //获取当前PC根据硬件唯一ID
  RegisterUniqId();
  DebugTrace('UID',GBL_SYS_UINIQID);

  ConnDB;
  query:='SELECT TOP 1 * FROM CONFIG_TAB';
  with ADOQueryMain do begin
    if Active then Close;
    with SQL do begin
      Clear;
      Add(query);
    end;
    Prepared:=true;
    try
      Open;
    except on E: Exception do
      begin
        Log(E.Message);
      end;
    end;
    while NOT EOF do begin
      CONF_STARTUP:=FieldValues['CONF_STARTUP'];
      CONF_CLOSE_MIN:=FieldValues['CONF_CLOSE_MIN'];
      CONF_CLOSE_TIP:=FieldValues['CONF_CLOSE_TIP'];
      CONF_AUTO_LOGIN:=FieldValues['CONF_AUTO_LOGIN'];
      CONF_DISCOUNT_MSG:=FieldValues['CONF_DISCOUNT_MSG'];
      CONF_MALL_MSG:=FieldValues['CONF_MALL_MSG'];
      CONF_AUTO_SYNC:=FieldValues['CONF_AUTO_SYNC'];
      CONF_AUTO_UPDATE:=FieldValues['CONF_AUTO_UPDATE'];
      CONF_AT_MSG:=FieldValues['CONF_AT_MSG'];
      CONF_RUNTIME:=FieldValues['CONF_RUNTIME'];
      CONF_IMPORT_COUNT:= FieldValues['CONF_IMPORT_COUNT'];
      Next;
    end;
    Close;
  end;

  FreeDB;

end;
{*******************************************************************************}
procedure TfrmLogin.RegisterUniqId;
var
  Reg:TRegistry;
begin
  Reg:=TRegistry.Create; //创建一个新键
  Reg.RootKey:= HKEY_CURRENT_USER;
  Reg.OpenKey('Software\Xiayijian\Tao\',true);//打开
  Reg.WriteString('TaoId', GBL_SYS_UINIQID); //UNIQID
  Reg.WriteString('app_id', IntToStr(API_ID)); //UNIQID
  Reg.CloseKey;
  Reg.Free;
end;

{*******************************************************************************}

procedure TfrmLogin.SaveConf(iStartUp, iCloseMin, iCloseTip, iAutoLogin, iDiscountMsg,
  iMallMsg, iAutoSync, iAutoUpdate, iAtMsg: Integer);
var query: string;
begin
  ConnDB;
  query := 'UPDATE CONFIG_TAB SET CONF_STARTUP=' + IntToStr(iStartUp) +
        ', CONF_CLOSE_MIN=' + IntToStr(iCloseMin) +
        ', CONF_CLOSE_TIP=' + IntToStr(iCloseTip) +
        ', CONF_AUTO_LOGIN=' + IntToStr(iAutoLogin)+
        ', CONF_DISCOUNT_MSG=' + IntToStr(iDiscountMsg) +
        ', CONF_MALL_MSG=' + IntToStr(iMallMsg)+
        ', CONF_AUTO_SYNC=' + IntToStr(iAutoSync) +
        ', CONF_AUTO_UPDATE=' + IntToStr(iAutoUpdate) +
        ', CONF_AT_MSG=' + IntToStr(iAtMsg);
  ExeTSQL(query, ADOQueryMain);
  FreeDB;

end;
{*******************************************************************************}
procedure TfrmLogin.SaveConfCloseTip(iCloseTip, iCloseMin: integer);
var query:string;
begin
  ConnDB;
  query := 'UPDATE CONFIG_TAB SET CONF_CLOSE_TIP=' + IntToStr(iCloseTip)
        +', CONF_CLOSE_MIN=' + IntToStr(iCloseMin);
  ExeTSQL(query, ADOQueryMain);
  FreeDB;
end;

{*******************************************************************************}
procedure TfrmLogin.UpdateImportCount;
var query:string;
begin
  Inc(CONF_IMPORT_COUNT);
  ConnDB;
  query := 'UPDATE CONFIG_TAB SET CONF_IMPORT_COUNT=' + IntToStr(CONF_IMPORT_COUNT);
  ExeTSQL(query, ADOQueryMain);
  FreeDB;
end;
{*******************************************************************************}
procedure TfrmLogin.UpdateRunTime;
var query:string;
begin
  Inc(CONF_RUNTIME);
  ConnDB;
  query := 'UPDATE CONFIG_TAB SET CONF_RUNTIME=' + IntToStr(CONF_RUNTIME);
  ExeTSQL(query, ADOQueryMain);
  FreeDB;
end;

{*******************************************************************************}
procedure TfrmLogin.WMSysCommand(var Message: TWMSysCommand);
begin

  case Message.CmdType of
    SC_CLOSE: begin
                Application.Terminate;
                Exit;
             end;
  end;
  inherited;
end;

{*******************************************************************************}
end.

