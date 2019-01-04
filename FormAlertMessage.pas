unit FormAlertMessage;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseFormCommon, ExtCtrls, StdCtrls, RzPanel, pngimage;

type
  TfrmAlertMessage = class(TfrmBaseCommon)
    lblMsg: TLabel;
    imgAlertMessage: TImage;
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure lblMsgMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure lblMsgMouseLeave(Sender: TObject);
    procedure lblMsgClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAlertMessage: TfrmAlertMessage;

implementation

  uses FunctionCommon, SystemConfig;

{$R *.dfm}
{*******************************************************************************}
procedure TfrmAlertMessage.FormActivate(Sender: TObject);
begin
  OnActivate:=nil;
  FlashWindow(Application.Handle, True);
end;
{*******************************************************************************}
procedure TfrmAlertMessage.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(frmAlertMessage);
end;

{*******************************************************************************}
procedure TfrmAlertMessage.FormDestroy(Sender: TObject);
begin
  //²»¼Ì³Ð

end;
{*******************************************************************************}
procedure TfrmAlertMessage.FormShow(Sender: TObject);
begin
  inherited;
  Top:= Screen.Height - Self.Height - 70;
  Left:= Screen.Width - Self. Width - 30;
end;

{*******************************************************************************}
procedure TfrmAlertMessage.lblMsgClick(Sender: TObject);
begin
  inherited;
  ShowFormMessageBox;
  Close;
end;
{*******************************************************************************}
procedure TfrmAlertMessage.lblMsgMouseLeave(Sender: TObject);
begin
  inherited;
  lblMsg.Font.Style:=[fsBold];
end;
{*******************************************************************************}
procedure TfrmAlertMessage.lblMsgMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  inherited;
  lblMsg.Font.Style:=[fsBold, fsUnderline];
end;

{*******************************************************************************}
end.
