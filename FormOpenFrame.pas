unit FormOpenFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseFormMain, AppEvnts, Menus, GIFImg, OleCtrls, SHDocVw, ExtCtrls,
  StdCtrls, RzPanel, RzLabel, ImgList;

type
  TfrmOpenFrame = class(TfrmBaseMain)
    lblUrlAD: TRzURLLabel;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure lblUrlADMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure lblUrlADMouseLeave(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmOpenFrame: TfrmOpenFrame;

implementation

  uses SystemConfig, FunctionCommon;

{$R *.dfm}

{*******************************************************************************}
procedure TfrmOpenFrame.FormCreate(Sender: TObject);
begin
  if not GBL_IS_LOGIN then begin
    ShowFormLogin;
  end;
  wbBase.Navigate(DEF_INFO_FRAME[0].Url);
end;
{*******************************************************************************}
procedure TfrmOpenFrame.FormShow(Sender: TObject);
var I, iFrame:integer;
begin
  inherited;
  iFrame:= 0;
  Width:= DEF_INFO_FRAME[0].Width;
  Height:= DEF_INFO_FRAME[0].Height;
  Caption:= DEF_INFO_FRAME[0].Title;
  lblTitleBase.Caption:= Caption;
  //LEFT TOP…Ë÷√Œ Ã‚
  for I := 0 to Screen.FormCount - 1 do begin
    if (Screen.Forms[I] is TfrmOpenFrame) then begin
      Inc(iFrame);
    end;
  end;

  Left:=Left + iFrame * 5;
  Top:= Top + iFrame * 5;
end;
{*******************************************************************************}
procedure TfrmOpenFrame.lblUrlADMouseLeave(Sender: TObject);
begin
  inherited;
  lblUrlAD.Font.Style:=[];
end;
{*******************************************************************************}
procedure TfrmOpenFrame.lblUrlADMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  inherited;
  lblUrlAD.Font.Style:=[fsUnderline];
end;

{*******************************************************************************}
end.
