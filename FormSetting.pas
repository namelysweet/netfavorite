unit FormSetting;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseFormCommon, ExtCtrls, StdCtrls, RzPanel, RzButton, RzRadChk,
  RzBmpBtn, Registry;

type
  TfrmSetting = class(TfrmBaseCommon)
    chkStartUp: TRzCheckBox;
    chkCloseMin: TRzCheckBox;
    chkAutoLogin: TRzCheckBox;
    chkDiscountMsg: TRzCheckBox;
    chkMallMsg: TRzCheckBox;
    chkAutoSync: TRzCheckBox;
    chkAutoUpdate: TRzCheckBox;
    chkAtMsg: TRzCheckBox;
    lblSettingSyncTip: TLabel;
    btnOk: TRzBmpButton;
    btnCancel: TRzBmpButton;
    chkCloseTip: TRzCheckBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    PanelSplit1: TPanel;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    procedure btnCancelClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);

  private
    { Private declarations }
    procedure LoadBmpSmallButtonResource();//加载BMP按钮图资源
    procedure FreeBmpSmallButtonResource();//释放
    procedure SetBmpSmallButton(); //动态设置小型按钮
  public
    { Public declarations }
    procedure LoadSetting();//加载设置选项
    procedure SetRunOnWindowStartUp();//设置开机自动启动
    procedure CancelRunOnWindowStartUp();
  end;

var
  frmSetting: TfrmSetting;
  BmpDisabledS, BmpDownS, BmpOnS, BmpOutS: TBitmap;

implementation

  uses FunctionCommon, SystemConfig, FormLogin;

{$R *.dfm}



{*******************************************************************************}
procedure TfrmSetting.btnCancelClick(Sender: TObject);
begin
  inherited;
  Close;
end;
{*******************************************************************************}
procedure TfrmSetting.btnOkClick(Sender: TObject);
begin
  inherited;
  //默认值
  CONF_STARTUP:= 0;
  CONF_CLOSE_MIN:= 0;
  CONF_CLOSE_TIP:= 0;
  CONF_AUTO_LOGIN:= 0;
  CONF_DISCOUNT_MSG:= 0;
  CONF_MALL_MSG:= 0;
  CONF_AUTO_SYNC:= 0;
  CONF_AUTO_UPDATE:= 0;
  CONF_AT_MSG:= 0;


  if chkStartUp.Checked = True then begin
    CONF_STARTUP:= 1;
    SetRunOnWindowStartUp;
  end else begin
    CancelRunOnWindowStartUp;
  end;

  if chkCloseMin.Checked = True then CONF_CLOSE_MIN:= 1;
  if chkCloseTip.Checked = True then CONF_CLOSE_TIP:= 1;
  if chkAutoLogin.Checked = True then CONF_AUTO_LOGIN:= 1;
  if chkDiscountMsg.Checked = True then CONF_DISCOUNT_MSG:= 1;
  if chkMallMsg.Checked = True then CONF_MALL_MSG:= 1;
  if chkAutoSync.Checked = True then CONF_AUTO_SYNC:= 1;
  if chkAutoUpdate.Checked = True then CONF_AUTO_UPDATE:= 1;
  if chkAtMsg.Checked = True then CONF_AT_MSG:= 1;

  //保存配置
  frmLogin.SaveConf(
    CONF_STARTUP,
    CONF_CLOSE_MIN,
    CONF_CLOSE_TIP,
    CONF_AUTO_LOGIN,
    CONF_DISCOUNT_MSG,
    CONF_MALL_MSG,
    CONF_AUTO_SYNC,
    CONF_AUTO_UPDATE,
    CONF_AT_MSG
  );

  btnCancelClick(Self);
end;
{*******************************************************************************}
procedure TfrmSetting.CancelRunOnWindowStartUp;
var
  Reg:TRegistry;
begin
  Reg:=TRegistry.Create;
  Reg.RootKey:=HKEY_LOCAL_MACHINE;
  Reg.OpenKey('SOFTWARE\Microsoft\Windows\CurrentVersion\Run',true);
  Reg.DeleteValue('NetFavorites');

  Reg.CloseKey;
  Reg.Free;

end;

{*******************************************************************************}
procedure TfrmSetting.FormActivate(Sender: TObject);
begin
  inherited;
  OnActivate:=nil;

end;
{*******************************************************************************}
procedure TfrmSetting.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  FreeBmpSmallButtonResource;
end;

{*******************************************************************************}
procedure TfrmSetting.FormShow(Sender: TObject);
begin
  inherited;
  LoadBmpSmallButtonResource;
  SetBmpSmallButton;
  LoadSetting; //加载配置
  Caption:='设置' + GBL_SYS_APPNAME;
  lblTitleBase.Caption:= Caption;
end;
{*******************************************************************************}
procedure TfrmSetting.FreeBmpSmallButtonResource;
begin
  FreeAndNil(BmpDisabledS);
  FreeAndNil(BmpDownS);
  FreeAndNil(BmpOnS);
  FreeAndNil(BmpOutS);
end;

{*******************************************************************************}
procedure TfrmSetting.LoadBmpSmallButtonResource;
begin
  if not Assigned(BmpDisabledS) then BmpDisabledS:= TBitmap.Create;
  if not Assigned(BmpDownS) then BmpDownS:= TBitmap.Create;
  if not Assigned(BmpOnS) then BmpOnS:= TBitmap.Create;
  if not Assigned(BmpOutS) then BmpOutS:= TBitmap.Create;


  try
    BmpDisabledS.LoadFromResourceName(HInstance, 'btnDisabledS');
    BmpDownS.LoadFromResourceName(HInstance, 'btnDownS');
    BmpOnS.LoadFromResourceName(HInstance, 'btnOnS');
    BmpOutS.LoadFromResourceName(HInstance, 'btnOutS');

  except on E: Exception do begin
      FunctionCommon.Log(E.Message);
    end;

  end;
end;
{*******************************************************************************}
procedure TfrmSetting.LoadSetting;
begin
  chkStartUp.Checked := False;
  chkCloseMin.Checked := False;
  chkCloseTip.Checked:= False;
  chkAutoLogin.Checked := False;
  chkDiscountMsg.Checked := False;
  chkMallMsg.Checked := False;
  chkAutoSync.Checked := False;
  chkAutoUpdate.Checked := False;
  chkAtMsg.Checked := False;


  if CONF_STARTUP = 1 then chkStartUp.Checked := True;
  if CONF_CLOSE_MIN =  1 then chkCloseMin.Checked := True;
  if CONF_CLOSE_TIP =  1 then chkCloseTip.Checked := True;
  if CONF_AUTO_LOGIN = 1 then chkAutoLogin.Checked := True;
  if CONF_DISCOUNT_MSG =1 then chkDiscountMsg.Checked := True;
  if CONF_MALL_MSG = 1 then chkMallMsg.Checked := True;
  if CONF_AUTO_SYNC = 1 then chkAutoSync.Checked := True;
  if CONF_AUTO_UPDATE = 1 then chkAutoUpdate.Checked := True;
  if CONF_AT_MSG = 1 then chkAtMsg.Checked := True;
end;

{*******************************************************************************}
procedure TfrmSetting.SetBmpSmallButton;
begin
  btnOk.Bitmaps.Disabled:= BmpDisabledS;
  btnOk.Bitmaps.Down:= BmpDownS;
  btnOk.Bitmaps.StayDown:= BmpDownS;
  btnOk.Bitmaps.Hot:= BmpOnS;
  btnOk.Bitmaps.Up:= BmpOutS;

  btnCancel.Bitmaps.Disabled:= BmpDisabledS;
  btnCancel.Bitmaps.Down:= BmpDownS;
  btnCancel.Bitmaps.StayDown:= BmpDownS;
  btnCancel.Bitmaps.Hot:= BmpOnS;
  btnCancel.Bitmaps.Up:= BmpOutS;

end;
{*******************************************************************************}
procedure TfrmSetting.SetRunOnWindowStartUp;
var
  Reg:TRegistry;
begin
  Reg:=TRegistry.Create; //创建一个新键
  Reg.RootKey:=HKEY_LOCAL_MACHINE;
  Reg.OpenKey('SOFTWARE\Microsoft\Windows\CurrentVersion\Run',true);//打开
  Reg.WriteString('Tao', '"' + ExtractFilePath(ParamStr(0))+'Tao.exe" -static'); //在Reg这个键中写入数据名称和数据数值
  Reg.CloseKey;
  Reg.Free;
end;

{*******************************************************************************}
end.
