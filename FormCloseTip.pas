unit FormCloseTip;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseFormCommon, StdCtrls, ExtCtrls, RzPanel, RzButton, RzRadChk,
  pngimage, RzBmpBtn;

type
  TfrmCloseTip = class(TfrmBaseCommon)
    lblCloseTip: TLabel;
    rdButtonCloseMin: TRzRadioButton;
    rdButtonCloseExit: TRzRadioButton;
    imgCloseTip: TImage;
    chkCloseTip: TRzCheckBox;
    btnCancel: TRzBmpButton;
    btnOk: TRzBmpButton;
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
    procedure LoadCloseSettingConf();//加载配置
  end;

var
  frmCloseTip: TfrmCloseTip;
  BmpDisabledS, BmpDownS, BmpOnS, BmpOutS: TBitmap;

implementation

  uses FunctionCommon, SystemConfig, FormLogin;

{$R *.dfm}

procedure TfrmCloseTip.btnCancelClick(Sender: TObject);
begin
  inherited;
  //ModalResult:=mrCancel;
  Close;
end;
{*******************************************************************************}
procedure TfrmCloseTip.btnOkClick(Sender: TObject);
begin
  inherited;
  //记住选择

  if chkCloseTip.Checked=True then  begin
    CONF_CLOSE_TIP:=0;
  end else begin
    CONF_CLOSE_TIP:=1;
  end;

  if rdButtonCloseMin.Checked=True then begin
    CONF_CLOSE_MIN:=1;
    //关闭最小化
  end else begin
    CONF_CLOSE_MIN:=0;
  end;

  frmLogin.SaveConfCloseTip(CONF_CLOSE_TIP, CONF_CLOSE_MIN); //保存配置

  //ModalResult := mrOk;
  Close;
end;
{*******************************************************************************}
procedure TfrmCloseTip.FormActivate(Sender: TObject);
begin
  inherited;
  OnActivate:=nil;
end;
{*******************************************************************************}
procedure TfrmCloseTip.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  FreeBmpSmallButtonResource;

end;
{*******************************************************************************}
procedure TfrmCloseTip.FormShow(Sender: TObject);
begin
  inherited;
  LoadBmpSmallButtonResource;
  SetBmpSmallButton;
  //加载部分配置
  LoadCloseSettingConf;
end;
{*******************************************************************************}
procedure TfrmCloseTip.FreeBmpSmallButtonResource;
begin
  FreeAndNil(BmpDisabledS);
  FreeAndNil(BmpDownS);
  FreeAndNil(BmpOnS);
  FreeAndNil(BmpOutS);
end;
{*******************************************************************************}
procedure TfrmCloseTip.LoadBmpSmallButtonResource;
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
procedure TfrmCloseTip.LoadCloseSettingConf;
begin
  rdButtonCloseExit.Checked:=True;
  chkCloseTip.Checked:=False;

  if CONF_CLOSE_MIN=1 then rdButtonCloseMin.Checked:=True;
  if CONF_CLOSE_TIP=1 then chkCloseTip.Checked:=True;


end;

{*******************************************************************************}
procedure TfrmCloseTip.SetBmpSmallButton;
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
end.
