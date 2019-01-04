unit FormImportSync;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseFormCommon, ExtCtrls, StdCtrls, RzPanel, pngimage, RzButton,
  RzRadChk, RzBmpBtn, FrameImportSyncStepOne, FrameImportSyncStepTwo;

type
  TfrmImportSync = class(TfrmBaseCommon)
    btnOk: TRzBmpButton;
    pnlFrameBase: TPanel;
    FrameSyncStep1: TFrameSync1;
    FrameSyncStep2: TFrameSync2;
    btnSmall: TRzBmpButton;

    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnOkClick(Sender: TObject);
    procedure btnSmallClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    procedure LoadBmpBigButtonResource();//加载BMP按钮图资源
    procedure FreeBmpBigButtonResource();//释放
    procedure SetBmpBigButton(); //动态设置按钮
  public
    { Public declarations }
    procedure HideAllFrame();
    procedure MoveToStep(StepId: integer);
    procedure ShowStepOne(); //默认UI
    procedure ShowStepTwo(); //进度
    procedure BigButtonAction(StepId: integer);

  end;

var
  frmImportSync: TfrmImportSync;
  BmpDisabledL, BmpDownL, BmpOnL, BmpOutL: TBitmap;
  BmpDisabledS, BmpDownS, BmpOnS, BmpOutS: TBitmap;

implementation

  uses FunctionCommon, ThreadSyncFavorites, FormMain, FormLogin, SystemConfig;

  var threadF:ThreadFavoritesSync;

{$R *.dfm}

{*******************************************************************************}
procedure TfrmImportSync.BigButtonAction(StepId: integer);
begin
  case StepId of
    1: begin
      btnOk.Left:= 305;
      btnSmall.Visible:=False;
      btnOk.Caption:='同步商品, 开启购物之旅(&S)';
      btnOk.Enabled:=True;

    end;
    2: begin
      btnOk.Left:= 230;
      btnSmall.Left:= 408;
      btnSmall.Visible:=True;
      btnOk.Caption:='导入中, 请稍候...';
      btnOk.Enabled:=False;
    end;
    else
      ShowStepOne;
  end;
end;
{*******************************************************************************}
procedure TfrmImportSync.btnOkClick(Sender: TObject);
begin
  inherited;
  btnOk.Enabled:= False;
  MoveToStep(2);
end;
{*******************************************************************************}
procedure TfrmImportSync.btnSmallClick(Sender: TObject);
begin
  inherited;
  //frmMain.wbBase.Navigate(DEF_URL_MAIN);
  Close;
end;

{*******************************************************************************}
procedure TfrmImportSync.FormActivate(Sender: TObject);
begin
  inherited;
  OnActivate:=nil;//只启动一次

end;

{*******************************************************************************}
procedure TfrmImportSync.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  FreeBmpBigButtonResource;
end;
{*******************************************************************************}
procedure TfrmImportSync.FormDestroy(Sender: TObject);
begin
  //inherited;

end;
{*******************************************************************************}
procedure TfrmImportSync.FormShow(Sender: TObject);
begin
  inherited;
  LoadBmpBigButtonResource;
  SetBmpBigButton;
  if CONF_IMPORT_COUNT>=1 then begin
    MoveToStep(2);
  end else begin
    MoveToStep(1);
  end;
end;
{*******************************************************************************}
procedure TfrmImportSync.FreeBmpBigButtonResource;
begin
  FreeAndNil(BmpDisabledL);
  FreeAndNil(BmpDownL);
  FreeAndNil(BmpOnL);
  FreeAndNil(BmpOutL);

  FreeAndNil(BmpDisabledS);
  FreeAndNil(BmpDownS);
  FreeAndNil(BmpOnS);
  FreeAndNil(BmpOutS);
end;
{*******************************************************************************}
procedure TfrmImportSync.HideAllFrame;
begin
  pnlFrameBase.Color:= clWhite;
  FrameSyncStep1.Visible:= False;
  FrameSyncStep2.Visible:= False;
end;

{*******************************************************************************}
procedure TfrmImportSync.LoadBmpBigButtonResource;
begin
  if not Assigned(BmpDisabledL) then BmpDisabledL:= TBitmap.Create;
  if not Assigned(BmpDownL) then BmpDownL:= TBitmap.Create;
  if not Assigned(BmpOnL) then BmpOnL:= TBitmap.Create;
  if not Assigned(BmpOutL) then BmpOutL:= TBitmap.Create;

  if not Assigned(BmpDisabledS) then BmpDisabledS:= TBitmap.Create;
  if not Assigned(BmpDownS) then BmpDownS:= TBitmap.Create;
  if not Assigned(BmpOnS) then BmpOnS:= TBitmap.Create;
  if not Assigned(BmpOutS) then BmpOutS:= TBitmap.Create;

  try
    BmpDisabledL.LoadFromResourceName(HInstance, 'btnDisabledL');
    BmpDownL.LoadFromResourceName(HInstance, 'btnDownL');
    BmpOnL.LoadFromResourceName(HInstance, 'btnOnL');
    BmpOutL.LoadFromResourceName(HInstance, 'btnOutL');

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
procedure TfrmImportSync.MoveToStep(StepId: integer);
begin
  case StepId of
    1: ShowStepOne;
    2: ShowStepTwo;
    else
      ShowStepOne;
  end;
end;

{*******************************************************************************}
procedure TfrmImportSync.SetBmpBigButton;
begin
  btnOk.Bitmaps.Disabled:= BmpDisabledL;
  btnOk.Bitmaps.Down:= BmpDownL;
  btnOk.Bitmaps.StayDown:= BmpDownL;
  btnOk.Bitmaps.Hot:= BmpOnL;
  btnOk.Bitmaps.Up:= BmpOutL;

  btnSmall.Bitmaps.Disabled:= BmpDisabledS;
  btnSmall.Bitmaps.Down:= BmpDownS;
  btnSmall.Bitmaps.StayDown:= BmpDownS;
  btnSmall.Bitmaps.Hot:= BmpOnS;
  btnSmall.Bitmaps.Up:= BmpOutS;
end;
{*******************************************************************************}
procedure TfrmImportSync.ShowStepOne;
begin
  Caption:='同步到'+GBL_SYS_APPNAME;
  lblTitleBase.Caption:=Caption;
  HideAllFrame;
  FrameSyncStep1.AutoSize:=True;
  FrameSyncStep1.Left:= (pnlFrameBase.Width - FrameSyncStep1.Width) div 2;
  FrameSyncStep1.Height:= (pnlFrameBase.Height - FrameSyncStep1.Height) div 2;

  FrameSyncStep1.Visible:= True;

  //按钮的变化
  BigButtonAction(1);

end;
{*******************************************************************************}
procedure TfrmImportSync.ShowStepTwo;
begin
  Caption:= '导入中...';
  lblTitleBase.Caption:=Caption;
  HideAllFrame;
  FrameSyncStep2.AutoSize:=True;
  FrameSyncStep2.Left:= (pnlFrameBase.Width - FrameSyncStep2.Width) div 2;
  FrameSyncStep2.Height:= (pnlFrameBase.Height - FrameSyncStep2.Height) div 2;
  FrameSyncStep2.PageControlStepSync.ActivePageIndex := 0;
  FrameSyncStep2.Visible:= True;
  BigButtonAction(2);

  //开启线程
  threadF:= ThreadFavoritesSync.Create(False, True);
  //threadF.OnTerminate:= btnSmallClick;

  frmLogin.UpdateImportCount();

end;

{*******************************************************************************}
end.
