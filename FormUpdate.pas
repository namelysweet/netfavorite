unit FormUpdate;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseFormCommon, StdCtrls, ExtCtrls, RzPanel, RzBmpBtn, ShellAPI,
  RzEdit;

type
  TfrmUpdate = class(TfrmBaseCommon)
    btnOk: TRzBmpButton;
    btnCancel: TRzBmpButton;
    lblAppName: TLabel;
    memoUpdateInfo: TRzMemo;
    lblUpdateTip: TLabel;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCancelClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    procedure LoadBmpBigButtonResource();//加载BMP按钮图资源
    procedure FreeBmpBigButtonResource();//释放
    procedure SetBmpBigButton(); //动态设置按钮
  public
    { Public declarations }
  end;

var
  frmUpdate: TfrmUpdate;
  BmpDisabledL, BmpDownL, BmpOnL, BmpOutL: TBitmap;

implementation
  uses FunctionCommon, SystemConfig;


{$R *.dfm}

{ TfrmUpdate }

procedure TfrmUpdate.btnCancelClick(Sender: TObject);
begin
  inherited;
  Close;
end;
{*******************************************************************************}
procedure TfrmUpdate.btnOkClick(Sender: TObject);
begin
  inherited;

  ShellExecute(Handle, 'open', 'Explorer.exe', PChar(UPDATE_APP_URL), nil, SW_SHOWNORMAL);

  btnCancelClick(Self);
end;
{*******************************************************************************}
procedure TfrmUpdate.FormActivate(Sender: TObject);
begin
  inherited;
  OnActivate:=nil;

end;
{*******************************************************************************}
procedure TfrmUpdate.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  FreeBmpBigButtonResource;
end;
{*******************************************************************************}
procedure TfrmUpdate.FormShow(Sender: TObject);
begin
  inherited;
  LoadBmpBigButtonResource;
  SetBmpBigButton;

  memoUpdateInfo.Lines.Clear;
  lblAppName.Caption:= GBL_SYS_APPNAME + '有新的版本发布啦 - v' + UPDATE_APP_VER;
  memoUpdateInfo.Text:= UPDATE_APP_INFO;

  Caption:=  GBL_SYS_APPNAME + '有新的版本！';
  lblTitleBase.Caption := Caption;
end;
{*******************************************************************************}
procedure TfrmUpdate.FreeBmpBigButtonResource;
begin
  FreeAndNil(BmpDisabledL);
  FreeAndNil(BmpDownL);
  FreeAndNil(BmpOnL);
  FreeAndNil(BmpOutL);
end;
{*******************************************************************************}
procedure TfrmUpdate.LoadBmpBigButtonResource;
begin
  if not Assigned(BmpDisabledL) then BmpDisabledL:= TBitmap.Create;
  if not Assigned(BmpDownL) then BmpDownL:= TBitmap.Create;
  if not Assigned(BmpOnL) then BmpOnL:= TBitmap.Create;
  if not Assigned(BmpOutL) then BmpOutL:= TBitmap.Create;


  try
    BmpDisabledL.LoadFromResourceName(HInstance, 'btnDisabledL');
    BmpDownL.LoadFromResourceName(HInstance, 'btnDownL');
    BmpOnL.LoadFromResourceName(HInstance, 'btnOnL');
    BmpOutL.LoadFromResourceName(HInstance, 'btnOutL');


  except on E: Exception do begin
      FunctionCommon.Log(E.Message);
    end;

  end;
end;
{*******************************************************************************}
procedure TfrmUpdate.SetBmpBigButton;
begin
  btnOk.Bitmaps.Disabled:= BmpDisabledL;
  btnOk.Bitmaps.Down:= BmpDownL;
  btnOk.Bitmaps.StayDown:= BmpDownL;
  btnOk.Bitmaps.Hot:= BmpOnL;
  btnOk.Bitmaps.Up:= BmpOutL;

  btnCancel.Bitmaps.Disabled:= BmpDisabledL;
  btnCancel.Bitmaps.Down:= BmpDownL;
  btnCancel.Bitmaps.StayDown:= BmpDownL;
  btnCancel.Bitmaps.Hot:= BmpOnL;
  btnCancel.Bitmaps.Up:= BmpOutL;

end;
{*******************************************************************************}
end.
