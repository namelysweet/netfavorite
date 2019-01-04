unit BaseFormCommon;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, pngimage, ExtCtrls, StdCtrls, RzPanel, SystemConfig;

type
  TfrmBaseCommon = class(TForm)
    pnlBase: TRzPanel;
    pnlTitleBar: TRzPanel;
    lblTitleBase: TLabel;
    imgTitleBackground: TImage;
    imgMin: TImage;
    imgClose: TImage;
    pnlBottom: TRzPanel;
    procedure FormCreate(Sender: TObject);
    procedure imgCloseClick(Sender: TObject);
    procedure imgMinClick(Sender: TObject);

    procedure imgCloseMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure imgCloseMouseLeave(Sender: TObject);
    procedure imgCloseMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure imgMinMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure imgMinMouseLeave(Sender: TObject);
    procedure imgMinMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure pnlBaseMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure imgTitleBackgroundMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure pnlTitleBarMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure imgMinMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure imgCloseMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure lblTitleBaseMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);

  private
    { Private declarations }
  public
    { Public declarations }
    procedure CreateParams(var Params: TCreateParams); override;
    procedure MoveWindow(); //移动窗体
    procedure LoadResource();

  end;
{*******************************************************************************}
var
  frmBaseCommon: TfrmBaseCommon;
  IsMouseDown: Boolean = False;

implementation

  uses FunctionCommon;

  {$R *.dfm}

{*******************************************************************************}
procedure TfrmBaseCommon.CreateParams(var Params: TCreateParams);
const
  CS_DROPSHADOW = $00020000;
begin
  inherited CreateParams(Params);
  Params.Style := WS_POPUP or WS_SYSMENU or WS_MINIMIZEBOX;
  Params.WindowClass.Style := Params.WindowClass.Style or CS_DROPSHADOW;
  Params.WndParent := 0;
end;
{*******************************************************************************}
procedure TfrmBaseCommon.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  AnimateWindow(self.Handle, 200, AW_HIDE or AW_BLEND);
end;
{*******************************************************************************}
procedure TfrmBaseCommon.FormCreate(Sender: TObject);
begin
  LoadResource;
end;

{*******************************************************************************}
procedure TfrmBaseCommon.imgCloseClick(Sender: TObject);
begin
  Close;
end;
{*******************************************************************************}
procedure TfrmBaseCommon.imgCloseMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  IsMouseDown:=True;
  imgClose.Picture.Graphic:=PngCloseDown;
end;
{*******************************************************************************}
procedure TfrmBaseCommon.imgCloseMouseLeave(Sender: TObject);
begin
  imgClose.Picture.Graphic:=PngCloseOff;
end;
{*******************************************************************************}
procedure TfrmBaseCommon.imgCloseMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  if not IsMouseDown then
    imgClose.Picture.Graphic:=PngCloseOn;
end;
{*******************************************************************************}
procedure TfrmBaseCommon.imgCloseMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  IsMouseDown:=False;
end;

{*******************************************************************************}
procedure TfrmBaseCommon.imgMinClick(Sender: TObject);
begin
  Application.Minimize;
end;
{*******************************************************************************}
procedure TfrmBaseCommon.imgMinMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  IsMouseDown:=True;
  imgMin.Picture.Graphic:= PngMinDown;
end;
{*******************************************************************************}
procedure TfrmBaseCommon.imgMinMouseLeave(Sender: TObject);
begin
  imgMin.Picture.Graphic:= PngMinOff;
end;
{*******************************************************************************}
procedure TfrmBaseCommon.imgMinMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  if not IsMouseDown then
    imgMin.Picture.Graphic:= PngMinOn;
end;
{*******************************************************************************}
procedure TfrmBaseCommon.imgMinMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  IsMouseDown:=False;
end;

{*******************************************************************************}
procedure TfrmBaseCommon.imgTitleBackgroundMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  MoveWindow;
end;
{*******************************************************************************}
procedure TfrmBaseCommon.lblTitleBaseMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  MoveWindow;
end;

{*******************************************************************************}
procedure TfrmBaseCommon.LoadResource;
begin

  if not Assigned(PngMinOn) then PngMinOn:= TPngImage.Create;
  if not Assigned(PngMinOff) then PngMinOff:= TPngImage.Create;
  if not Assigned(PngMinDown) then PngMinDown:= TPngImage.Create;
  if not Assigned(PngCloseOn) then PngCloseOn:= TPngImage.Create;
  if not Assigned(PngCloseDown) then PngCloseDown:= TPngImage.Create;
  if not Assigned(PngCloseOff) then PngCloseOff:= TPngImage.Create;
  if not Assigned(PngTitle) then PngTitle:= TPngImage.Create;

  try
    PngMinOn.LoadFromResourceName(HInstance, 'MinOn');
    PngMinOff.LoadFromResourceName(HInstance, 'MinOff');
    PngMinDown.LoadFromResourceName(HInstance, 'MinDown');

    PngCloseOn.LoadFromResourceName(HInstance, 'CloseOn');
    PngCloseOff.LoadFromResourceName(HInstance, 'CloseOff');
    PngCloseDown.LoadFromResourceName(HInstance, 'CloseDown');
    PngTitle.LoadFromResourceName(HInstance, 'PngTitle');

    imgMin.Picture.Graphic:=PngMinOff;
    imgClose.Picture.Graphic:=PngCloseOff;
    imgTitleBackground.Picture.Graphic:= PngTitle;


  except on E: Exception do begin
      FunctionCommon.Log(E.Message);
    end;

  end;

end;
{*******************************************************************************}
procedure TfrmBaseCommon.MoveWindow;
begin
  ReleaseCapture; // WINAPI释放鼠标
  SendMessage(Handle, WM_SYSCOMMAND, $F012, 0); // 发送系统消息
end;
{*******************************************************************************}
procedure TfrmBaseCommon.pnlBaseMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  MoveWindow;
end;
{*******************************************************************************}
procedure TfrmBaseCommon.pnlTitleBarMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  MoveWindow;
end;

{*******************************************************************************}
end.



