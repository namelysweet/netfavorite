unit FormAbout;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseFormCommon, StdCtrls, ExtCtrls, RzPanel, RzBmpBtn, pngimage, jpeg;

type
  TfrmAbout = class(TfrmBaseCommon)
    btnOk: TRzBmpButton;
    imgLogo: TImage;
    lblAppName: TLabel;
    lblAppDescInfo: TLabel;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnOkClick(Sender: TObject);

  private
    { Private declarations }
    procedure SetBmpSmallButton(); //动态设置小型按钮
    procedure LoadBmpSmallButtonResource();//加载BMP按钮图资源
    procedure FreeBmpSmallButtonResource();//释放
  public
    { Public declarations }
  end;

var
  frmAbout: TfrmAbout;
  BmpDisabledS, BmpDownS, BmpOnS, BmpOutS: TBitmap;

implementation

  uses FormMain, FunctionCommon, SystemConfig;

{$R *.dfm}

{ TfrmAbout }

procedure TfrmAbout.btnOkClick(Sender: TObject);
begin
  inherited;
  Close;
end;
{*******************************************************************************}
procedure TfrmAbout.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  FreeBmpSmallButtonResource;
end;
{*******************************************************************************}
procedure TfrmAbout.FormShow(Sender: TObject);
begin
  inherited;
  LoadBmpSmallButtonResource;
  SetBmpSmallButton;
  lblAppName.Caption:= GBL_SYS_APPNAME + ' v'
            + frmMain.VersionInfoMain.FileVersion + ' 版';
  lblTitleBase.Caption:= '关于' + GBL_SYS_APPNAME;
end;
{*******************************************************************************}
procedure TfrmAbout.FreeBmpSmallButtonResource;
begin
  FreeAndNil(BmpDisabledS);
  FreeAndNil(BmpDownS);
  FreeAndNil(BmpOnS);
  FreeAndNil(BmpOutS);
end;

{*******************************************************************************}
procedure TfrmAbout.LoadBmpSmallButtonResource;
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
procedure TfrmAbout.SetBmpSmallButton;
begin
  btnOk.Bitmaps.Disabled:= BmpDisabledS;
  btnOk.Bitmaps.Down:= BmpDownS;
  btnOk.Bitmaps.StayDown:= BmpDownS;
  btnOk.Bitmaps.Hot:= BmpOnS;
  btnOk.Bitmaps.Up:= BmpOutS;
end;
{*******************************************************************************}
end.
