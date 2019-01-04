unit NetFavorites_TLB;

// ************************************************************************ //
// WARNING
// -------
// The types declared in this file were generated from data read from a
// Type Library. If this type library is explicitly or indirectly (via
// another type library referring to this type library) re-imported, or the
// 'Refresh' command of the Type Library Editor activated while editing the
// Type Library, the contents of this file will be regenerated and all
// manual modifications will be lost.
// ************************************************************************ //

// $Rev: 17244 $
// File generated on 2012-11-06 14:44:16 from Type Library described below.

// ************************************************************************  //
// Type Lib: D:\下一件_网络收藏夹\NetFavorites (1)
// LIBID: {1AA202AD-71F5-41EB-A0E3-0D0FDDA04B80}
// LCID: 0
// Helpfile:
// HelpString:
// DepndLst:
//   (1) v2.0 stdole, (C:\Windows\system32\stdole2.tlb)
// ************************************************************************ //
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers.
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}
{$VARPROPSETTER ON}
{$ALIGN 4}
interface

uses Windows, ActiveX, Classes, Graphics, StdVCL, Variants;


// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:
//   Type Libraries     : LIBID_xxxx
//   CoClasses          : CLASS_xxxx
//   DISPInterfaces     : DIID_xxxx
//   Non-DISP interfaces: IID_xxxx
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  NetFavoritesMajorVersion = 1;
  NetFavoritesMinorVersion = 0;

  LIBID_NetFavorites: TGUID = '{1AA202AD-71F5-41EB-A0E3-0D0FDDA04B80}';

  IID_IMyExternal: TGUID = '{BE537F44-B372-43DA-83F4-377DF7E45986}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary
// *********************************************************************//
  IMyExternal = interface;
  IMyExternalDisp = dispinterface;

// *********************************************************************//
// Interface: IMyExternal
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {BE537F44-B372-43DA-83F4-377DF7E45986}
// *********************************************************************//
  IMyExternal = interface(IDispatch)
    ['{BE537F44-B372-43DA-83F4-377DF7E45986}']
    procedure OpenSyncFrame; safecall;
    procedure OpenFrame(const URL: WideString; Target: SYSINT; Width: SYSINT; Height: SYSINT;
                        const Title: WideString); safecall;
    procedure UserLoginSuccess(const URL: WideString; Weight: SYSINT; Height: SYSINT); safecall;
    procedure ToLoginPage(const URL: WideString; Weight: SYSINT; Height: SYSINT); safecall;
    procedure OpenMessageFrame(const URL: WideString; Weight: SYSINT; Height: SYSINT;
                               const Title: WideString); safecall;
    procedure Logouted; safecall;
    procedure Redirect(const ToUrl: WideString); safecall;
  end;

// *********************************************************************//
// DispIntf:  IMyExternalDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {BE537F44-B372-43DA-83F4-377DF7E45986}
// *********************************************************************//
  IMyExternalDisp = dispinterface
    ['{BE537F44-B372-43DA-83F4-377DF7E45986}']
    procedure OpenSyncFrame; dispid 201;
    procedure OpenFrame(const URL: WideString; Target: SYSINT; Width: SYSINT; Height: SYSINT;
                        const Title: WideString); dispid 202;
    procedure UserLoginSuccess(const URL: WideString; Weight: SYSINT; Height: SYSINT); dispid 203;
    procedure ToLoginPage(const URL: WideString; Weight: SYSINT; Height: SYSINT); dispid 204;
    procedure OpenMessageFrame(const URL: WideString; Weight: SYSINT; Height: SYSINT;
                               const Title: WideString); dispid 205;
    procedure Logouted; dispid 206;
    procedure Redirect(const ToUrl: WideString); dispid 208;
  end;

implementation

uses ComObj;

end.

