unit BaseFormMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, RzPanel, OleCtrls, SHDocVw, StdCtrls, Menus, PngImage,
  AppEvnts, GIFImg, UExternalContainer, SystemConfig, ImgList, RzLabel;

type

  TfrmBaseMain = class(TForm)
    pnlBase: TRzPanel;
    pnlWebBase: TRzPanel;
    lblTitleBase: TLabel;
    imgSetting: TImage;
    imgMin: TImage;
    imgClose: TImage;
    pmBase: TPopupMenu;
    menuSetting: TMenuItem;
    menuFeedBack: TMenuItem;
    menuCheckUpdate: TMenuItem;
    menuLogout: TMenuItem;
    ApplicationEventsBase: TApplicationEvents;
    pnlWeb: TPanel;
    wbBase: TWebBrowser;
    imgTitleBackground: TImage;
    pnlWebPageLoadTip: TPanel;
    imgLoading: TImage;
    lblLoading: TLabel;
    popXiayijian: TMenuItem;
    ImageAbout: TImage;
    MenuSep1: TMenuItem;
    MenuSep2: TMenuItem;
    imgListBase: TImageList;
    popAbout: TMenuItem;
    procedure pnlBaseMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure imgCloseClick(Sender: TObject);
    procedure imgMinClick(Sender: TObject);
    procedure imgSettingClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure imgSettingMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure imgSettingMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure imgSettingMouseLeave(Sender: TObject);
    procedure imgMinMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure imgMinMouseLeave(Sender: TObject);
    procedure imgMinMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure imgCloseMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure imgCloseMouseLeave(Sender: TObject);
    procedure imgCloseMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormResize(Sender: TObject);
    procedure ApplicationEventsBaseMessage(var Msg: tagMSG;
      var Handled: Boolean);
    procedure wbBaseDocumentComplete(ASender: TObject; const pDisp: IDispatch;
      var URL: OleVariant);
    procedure menuSettingClick(Sender: TObject);

    procedure FormDestroy(Sender: TObject);
    procedure imgSettingMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure imgMinMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure imgCloseMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure popXiayijianAdvancedDrawItem(Sender: TObject; ACanvas: TCanvas;
      ARect: TRect; State: TOwnerDrawState);
    procedure popXiayijianMeasureItem(Sender: TObject; ACanvas: TCanvas; var Width,
      Height: Integer);
    procedure popXiayijianClick(Sender: TObject);
    procedure menuLogoutClick(Sender: TObject);

    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure menuFeedBackClick(Sender: TObject);
    procedure wbBaseNavigateError(ASender: TObject; const pDisp: IDispatch;
      var URL, Frame, StatusCode: OleVariant; var Cancel: WordBool);
    procedure lblTitleBaseMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure imgTitleBackgroundMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure popAboutClick(Sender: TObject);

  private
    { Private declarations }
    fContainer: TExternalContainer;
  public
    { Public declarations }
    procedure CreateParams(var Params: TCreateParams); override;
    procedure MoveWindow(); //移动窗体
    procedure LoadResource();
    procedure FreeResource();
    procedure SetPosition();//设置位置调整


  end;

var
  frmBaseMain: TfrmBaseMain;
  IsMouseDown: Boolean = False;
  OldWBWndProc: TWndMethod;

implementation

  uses ActiveX, ShellAPI, FunctionCommon;

{$R *.dfm}

{*******************************************************************************}
procedure TfrmBaseMain.ApplicationEventsBaseMessage(var Msg: tagMSG;
  var Handled: Boolean);
begin
 with Msg do
  begin
    if not IsChild(wbBase.Handle, Hwnd) then
      Exit;
    Handled := (message = WM_RBUTTONDOWN) or (message = WM_RBUTTONUP) or
      (message = WM_CONTEXTMENU);
  end;
end;

{*******************************************************************************}
procedure TfrmBaseMain.CreateParams(var Params: TCreateParams);
const
  CS_DROPSHADOW = $00020000;
begin
  inherited CreateParams(Params);
  Params.Style := WS_POPUP or WS_SYSMENU or WS_MINIMIZEBOX;
  Params.WindowClass.Style := Params.WindowClass.Style or CS_DROPSHADOW;
  Params.WndParent := 0; //GetDesktopWindow()
  //Params.ExStyle := Params.ExStyle or WS_EX_APPWINDOW;
end;

{*******************************************************************************}
procedure TfrmBaseMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  AnimateWindow(self.Handle, 100, AW_HIDE or AW_BLEND);
end;
{*******************************************************************************}
procedure TfrmBaseMain.FormCreate(Sender: TObject);
begin
  pnlWebPageLoadTip.Visible:=True;
  wbBase.Silent:= True;

  wbBase.HandleNeeded;
  wbBase.RegisterAsDropTarget:=False;
  wbBase.RegisterAsBrowser:=True;
  wbBase.Navigate(DEF_URL_LOGIN);

end;
{*******************************************************************************}
procedure TfrmBaseMain.FormDestroy(Sender: TObject);
begin
  FreeResource;

end;

{*******************************************************************************}
procedure TfrmBaseMain.FormResize(Sender: TObject);
begin
  FixWebBrowser(wbBase);
  SetPosition;
end;
{*******************************************************************************}
procedure TfrmBaseMain.FormShow(Sender: TObject);
begin
  //加载资源文件
  LoadResource;
  SetPosition;

  FixWebBrowser(wbBase);
  fContainer := TExternalContainer.Create(wbBase);
end;
{*******************************************************************************}
procedure TfrmBaseMain.FreeResource;
begin

  FreeAndNil(PngTitle);
  FreeAndNil(PngSettingOff);
  FreeAndNil(PngSettingOn);
  FreeAndNil(PngSettingDown);
  FreeAndNil(PngCloseOn);
  FreeAndNil(PngCloseOff);
  FreeAndNil(PngCloseDown);
  FreeAndNil(PngMinOff);
  FreeAndNil(PngMinOn);
  FreeAndNil(PngMinDown);

  FreeAndNil(fContainer);

end;
{*******************************************************************************}
procedure TfrmBaseMain.imgCloseClick(Sender: TObject);
begin
  Close;
end;
{*******************************************************************************}
procedure TfrmBaseMain.imgCloseMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  IsMouseDown:=True;
  imgClose.Picture.Graphic:=PngCloseDown;
end;
{*******************************************************************************}
procedure TfrmBaseMain.imgCloseMouseLeave(Sender: TObject);
begin
imgClose.Picture.Graphic:=PngCloseOff;
end;
{*******************************************************************************}
procedure TfrmBaseMain.imgCloseMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  if not IsMouseDown then
    imgClose.Picture.Graphic:=PngCloseOn;
end;
{*******************************************************************************}
procedure TfrmBaseMain.imgCloseMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  IsMouseDown:=False;
end;

{*******************************************************************************}
procedure TfrmBaseMain.imgMinClick(Sender: TObject);
begin
Application.Minimize;
end;
{*******************************************************************************}
procedure TfrmBaseMain.imgMinMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  IsMouseDown:=True;
  imgMin.Picture.Graphic:=PngMinDown;
end;
{*******************************************************************************}
procedure TfrmBaseMain.imgMinMouseLeave(Sender: TObject);
begin
  imgMin.Picture.Graphic:=PngMinOff;
end;
{*******************************************************************************}
procedure TfrmBaseMain.imgMinMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  if not IsMouseDown then
    imgMin.Picture.Graphic:=PngMinOn;
end;
{*******************************************************************************}
procedure TfrmBaseMain.imgMinMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  IsMouseDown:=False;
end;

{*******************************************************************************}
procedure TfrmBaseMain.imgSettingClick(Sender: TObject);
var
MenuPos: TPoint;
begin
  MenuPos := imgSetting.ClientToScreen(Point(0, 0));
  MenuPos.Y:=MenuPos.Y + imgSetting.Height;
  imgSetting.PopupMenu.Popup(MenuPos.X, MenuPos.Y);

end;
{*******************************************************************************}
procedure TfrmBaseMain.imgSettingMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  IsMouseDown:=True;
  imgSetting.Picture.Graphic:=PngSettingDown;
end;
{*******************************************************************************}
procedure TfrmBaseMain.imgSettingMouseLeave(Sender: TObject);
begin
  imgSetting.Picture.Graphic:=PngSettingOff;
end;
{*******************************************************************************}
procedure TfrmBaseMain.imgSettingMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  if not IsMouseDown then
    imgSetting.Picture.Graphic:=PngSettingOn;
end;
{*******************************************************************************}
procedure TfrmBaseMain.imgSettingMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  IsMouseDown:=False;
end;

{*******************************************************************************}
procedure TfrmBaseMain.imgTitleBackgroundMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  MoveWindow;
end;

{*******************************************************************************}
procedure TfrmBaseMain.lblTitleBaseMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
MoveWindow;
end;

{*******************************************************************************}
procedure TfrmBaseMain.LoadResource;
begin
  if not Assigned(PngSettingOff) then PngSettingOff:=TPngImage.Create;
  if not Assigned(PngSettingOn) then PngSettingOn:=TPngImage.Create;
  if not Assigned(PngSettingDown) then PngSettingDown:=TPngImage.Create;
  if not Assigned(PngMinOn) then PngMinOn:= TPngImage.Create;
  if not Assigned(PngMinOff) then PngMinOff:= TPngImage.Create;
  if not Assigned(PngMinDown) then PngMinDown:= TPngImage.Create;
  if not Assigned(PngCloseOn) then PngCloseOn:= TPngImage.Create;
  if not Assigned(PngCloseDown) then PngCloseDown:= TPngImage.Create;
  if not Assigned(PngCloseOff) then PngCloseOff:= TPngImage.Create;
  if not Assigned(PngTitle) then  PngTitle:= TPngImage.Create;

  try
      PngSettingOff.LoadFromResourceName(HInstance, 'SettingOff');
      PngSettingDown.LoadFromResourceName(HInstance, 'SettingDown');
      PngSettingOn.LoadFromResourceName(HInstance, 'SettingOn');

      PngMinOn.LoadFromResourceName(HInstance, 'MinOn');
      PngMinOff.LoadFromResourceName(HInstance, 'MinOff');
      PngMinDown.LoadFromResourceName(HInstance, 'MinDown');

      PngCloseOn.LoadFromResourceName(HInstance, 'CloseOn');
      PngCloseOff.LoadFromResourceName(HInstance, 'CloseOff');
      PngCloseDown.LoadFromResourceName(HInstance, 'CloseDown');
      PngTitle.LoadFromResourceName(HInstance, 'PngTitle');

      imgSetting.Picture.Graphic:=PngSettingOff;
      imgMin.Picture.Graphic:=PngMinOff;
      imgClose.Picture.Graphic:=PngCloseOff;
      imgTitleBackground.Picture.Graphic:= PngTitle;
    except on E: Exception do begin
        Log(E.Message);
      end;

  end;
end;
{*******************************************************************************}
procedure TfrmBaseMain.MoveWindow;
begin
  ReleaseCapture; // WINAPI释放鼠标
  SendMessage(Handle, WM_SYSCOMMAND, $F012, 0); // 发送系统消息
end;
{*******************************************************************************}
procedure TfrmBaseMain.pnlBaseMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  MoveWindow;
end;
{*******************************************************************************}
procedure TfrmBaseMain.popAboutClick(Sender: TObject);
begin
  //关于
  ShowFormAbout;
end;
{*******************************************************************************}
procedure TfrmBaseMain.popXiayijianAdvancedDrawItem(Sender: TObject;
  ACanvas: TCanvas; ARect: TRect; State: TOwnerDrawState);
begin
  ACanvas.FillRect(ARect) ;

  //draw text
  ACanvas.Font.Style := [fsBold];
  //ACanvas.TextRect(ARect,24 + ARect.Left, 4 + ARect.Top,'Picture in PopupMenu!') ;

  //shrink rect
  //InflateRect(ARect,-1,-1) ;
  //move it "down"
  //ARect.Top := ARect.Top + 1;
  //draw image
  ACanvas.StretchDraw(ARect, ImageAbout.Picture.Graphic);

end;
{*******************************************************************************}
procedure TfrmBaseMain.popXiayijianClick(Sender: TObject);
begin
  //默认浏览器打开下一件
  //ShellExecute(Handle, 'open', 'IExplore.EXE', 'http://www.xiayijian.com', nil, SW_SHOWNORMAL);
  //ShellExecute(Handle, 'open', 'Explorer.exe', 'http://www.xiayijian.com/?from=pc', nil, SW_SHOWNORMAL);
  ShellExecute(Handle, nil,'http://www.xiayijian.com/?from=pc', nil, nil, SW_SHOWMAXIMIZED);
end;

{*******************************************************************************}
procedure TfrmBaseMain.popXiayijianMeasureItem(Sender: TObject; ACanvas: TCanvas;
  var Width, Height: Integer);
begin
  //set to desired height
  Height := 90;
  Width:=120;
end;

{*******************************************************************************}
procedure TfrmBaseMain.menuFeedBackClick(Sender: TObject);
begin
 ShellExecute(Handle, 'open', 'Explorer.exe', 'http://www.xiayijian.com/topic/3392135', nil, SW_SHOWNORMAL);
end;
{*******************************************************************************}
procedure TfrmBaseMain.menuLogoutClick(Sender: TObject);
begin
  //注销
  GBL_IS_LOGIN:= False;
  wbBase.Navigate(DEF_URL_LOGOUT);
end;
{*******************************************************************************}
procedure TfrmBaseMain.menuSettingClick(Sender: TObject);
begin
  ShowFormSetting;
end;

{*******************************************************************************}
procedure TfrmBaseMain.SetPosition;
begin
  TGIFImage(imgLoading.Picture.Graphic).AnimationSpeed := 200;
  TGIFImage(imgLoading.Picture.Graphic).Animate := True;

  imgLoading.Left:=(Self.Width-imgLoading.Width) div 2;
  lblLoading.Left:=(Self.Width-lblLoading.Width) div 2;

  imgLoading.Top:= (Self.Height-imgLoading.Height) div 2 - 35;
  lblLoading.Top:= (Self.Height-imgLoading.Height) div 2 - 20;
end;
{*******************************************************************************}
procedure TfrmBaseMain.wbBaseDocumentComplete(ASender: TObject;
  const pDisp: IDispatch; var URL: OleVariant);
begin
  if wbBase.Application = pDisp then begin
    pnlWebPageLoadTip.Visible:=False;
    wbBase.Update;
    wbBase.UpdateControlState;
  end;
end;
{*******************************************************************************}
procedure TfrmBaseMain.wbBaseNavigateError(ASender: TObject;
  const pDisp: IDispatch; var URL, Frame, StatusCode: OleVariant;
  var Cancel: WordBool);
var ErrorPage:string;
begin
  //出错
  Log(IntToStr(StatusCode) + ', url=' + URL);
  ErrorPage:=ExtractFilePath(ParamStr(0)) + 'local\index.html?code='+IntToStr(StatusCode);
  ErrorPage:='file:///' + StringReplace(ErrorPage, '\','/', [rfReplaceAll]);
  wbBase.Navigate(ErrorPage);


end;


end.
