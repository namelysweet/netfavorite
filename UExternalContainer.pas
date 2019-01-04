
{$A8,B-,C+,D+,E-,F-,G+,H+,I+,J-,K-,L+,M-,N+,O+,P+,Q-,R-,S-,T-,U-,V+,W-,X+,Y+,Z1}


unit UExternalContainer;

interface

uses
  // Delphi
  ActiveX, SHDocVw, SysUtils,
  // Project
  IntfDocHostUIHandler, UNulContainer, UMyExternal;

type

  {
  TExternalContainer:
    UI handler that extends browser's external object.
  }
  TExternalContainer = class(TNulWBContainer, IDocHostUIHandler, IOleClientSite)
  private
    fExternalObj: IDispatch;  // external object implementation
  protected
    { Re-implemented IDocHostUIHandler method }
    function GetExternal(out ppDispatch: IDispatch): HResult; stdcall;
  public
    constructor Create(const HostedBrowser: TWebBrowser);
  end;


implementation
   uses FunctionCommon;

{ TExternalContainer }

constructor TExternalContainer.Create(const HostedBrowser: TWebBrowser);
begin
  inherited;
  try
    fExternalObj := TMyExternal.Create;
  except on E: Exception do Log(E.Message);
  end;

end;
{*******************************************************************************}
function TExternalContainer.GetExternal(out ppDispatch: IDispatch): HResult;
begin
  ppDispatch := fExternalObj;
  Result := S_OK; // indicates we've provided script
end;
{*******************************************************************************}
end.

