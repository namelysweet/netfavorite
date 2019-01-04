{$A8,B-,C+,D+,E-,F-,G+,H+,I+,J-,K-,L+,M-,N+,O+,P+,Q-,R-,S-,T-,U-,V+,W-,X+,Y+,Z1}
{$WARN UNSAFE_TYPE OFF}


unit UMyExternal;

interface

uses
  Forms, ActiveX, Classes, ComObj, NetFavorites_TLB, Dialogs, ShlObj, HttpApp,
  Controls;

type

  TMyExternal = class(TAutoIntfObject, IMyExternal, IDispatch)
  private

    //fData: TStringList; //info from data file
  protected
    procedure OpenSyncFrame; safecall;
    procedure OpenFrame(const URL: WideString; Target: SYSINT; Width: SYSINT; Height: SYSINT;
                        const Title: WideString); safecall;
    procedure UserLoginSuccess(const URL: WideString; Weight: SYSINT; Height: SYSINT); safecall;
    procedure ToLoginPage(const URL: WideString; Weight: SYSINT; Height: SYSINT); safecall;
    procedure OpenMessageFrame(const URL: WideString; Weight: SYSINT; Height: SYSINT;
                               const Title: WideString); safecall;
    procedure Logouted; safecall;
    procedure Redirect(const ToUrl: WideString); safecall;
  public
    constructor Create;
    destructor Destroy; override;

    { IMyExternal methods }

  end;

implementation

uses
  SysUtils, StdActns, FunctionCommon, FormMain, SystemConfig;

{ TMyExternal }
{*******************************************************************************}
constructor TMyExternal.Create;
var
  TypeLib: ITypeLib;    // type library information
  ExeName: WideString;  // name of our program's exe file
begin
  // Get name of application
  ExeName := ParamStr(0);
  // Load type library from application's resources
  OleCheck(LoadTypeLib(PWideChar(ExeName), TypeLib));
  // Call inherited constructor
  inherited Create(TypeLib, IMyExternal);
  // Create and load string list from file
  //fData := TStringList.Create;
  //fData.LoadFromFile(ChangeFileExt(ExeName, '.dat'));
end;
{*******************************************************************************}
destructor TMyExternal.Destroy;
begin
  //fData.Free;
  inherited;
end;
{*******************************************************************************}
procedure TMyExternal.Logouted;
begin
  //注销External调用
  GBL_IS_LOGIN:= False;
  if GBL_IS_EXIT = False then CloseFormMain;

end;

{*******************************************************************************}
procedure TMyExternal.OpenFrame(const URL: WideString; Target, Width,
  Height: SYSINT; const Title: WideString);
begin
  DebugTrace('External调用','OpenFrame');
  DEF_INFO_FRAME[0].Url:=URL;
  DEF_INFO_FRAME[0].Target:= Target;
  DEF_INFO_FRAME[0].Width:= Width;
  DEF_INFO_FRAME[0].Height:= Height+70;
  DEF_INFO_FRAME[0].Title:= Title;

  ShowFormOpenFrame;
end;
{*******************************************************************************}
procedure TMyExternal.OpenMessageFrame(const URL: WideString; Weight,
  Height: SYSINT; const Title: WideString);
begin
  DebugTrace('External调用','OpenMessageFrame');
  ShowFormMessageBox;
end;

{*******************************************************************************}
procedure TMyExternal.OpenSyncFrame;
begin

  ShowFormSyncImport;
end;

{*******************************************************************************}
procedure TMyExternal.Redirect(const ToUrl: WideString);
begin
  DebugTrace('External调用','Redirect');
  frmMain.wbBase.Navigate(ToUrl);
end;

{*******************************************************************************}
procedure TMyExternal.ToLoginPage(const URL: WideString; Weight,
  Height: SYSINT);
begin
  GBL_IS_LOGIN:=False;

end;
{*******************************************************************************}
procedure TMyExternal.UserLoginSuccess(const URL: WideString; Weight,
  Height: SYSINT);
begin
  //跳转到主窗体
  GBL_IS_LOGIN:=True;

  USER_ID:= StrToInt(GetCurrenPCIECookie(DEF_URL_HOST, 'UserID'));
  USER_NAME:= HTTPDecode(GetCurrenPCIECookie(DEF_URL_HOST, 'UserName'));
  USER_LOGIN_KEY := GetCurrenPCIECookie(DEF_URL_HOST, 'LoginKey');

  CloseFormLogin;
end;

{*******************************************************************************}


end.
