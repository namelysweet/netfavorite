unit FormMessageBox;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseFormMain, AppEvnts, Menus, GIFImg, OleCtrls, SHDocVw, ExtCtrls,
  StdCtrls, RzPanel, ImgList;

type
  TfrmMessageBox = class(TfrmBaseMain)
    procedure FormCreate(Sender: TObject);
    procedure imgMinClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMessageBox: TfrmMessageBox;

implementation

  uses FunctionCommon, SystemConfig;

{$R *.dfm}

{*******************************************************************************}
procedure TfrmMessageBox.FormActivate(Sender: TObject);
begin
  inherited;
  OnActivate:=nil;
  FlashWindow(Handle, True);
end;

procedure TfrmMessageBox.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(frmMessageBox);
end;
{*******************************************************************************}
procedure TfrmMessageBox.FormCreate(Sender: TObject);
begin
  wbBase.Navigate(DEF_URL_MSG);

end;
{*******************************************************************************}
procedure TfrmMessageBox.FormDestroy(Sender: TObject);
begin
 //不继承窗体销毁
end;

{*******************************************************************************}
procedure TfrmMessageBox.FormShow(Sender: TObject);
begin
  inherited;
  Width:= DEF_FORM_MSG_WIDTH;
  Height:= DEF_FORM_MSG_HEIGHT;
  SetPosition;
  Caption:=GBL_SYS_APPNAME + '消息盒子 - '+ USER_NAME;
  lblTitleBase.Caption:=Caption;

end;
{*******************************************************************************}
procedure TfrmMessageBox.imgMinClick(Sender: TObject);
begin
  //WindowState:= wsMinimized;
  Hide;

end;
{*******************************************************************************}
end.

