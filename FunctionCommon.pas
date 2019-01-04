unit FunctionCommon;

{ *******************************************************************************}
interface

uses
  Windows, WinSock, SysUtils, StrUtils, Variants, Classes, Controls, Forms,
  Dialogs, Messages, Graphics, StdCtrls, RzLabel, Tlhelp32, DateUtils,
  RzBmpBtn, ExtCtrls, RzPanel, RzButton, RzLstBox, RzPrgres, DB, ShellApi,
  ADODB, Registry, ShlObj, OleCtrls, SHDocVw, WinInet, HardwareInfo;
{ *******************************************************************************}
//函数
function GetCurrenPCUniqId : string;//生成机器唯一ID
function GetCurrenPCIECookie(URL: string; CookieName: string): string;

function GetSpecialFolder(const CSIDL: integer) : string; //获取WIN下特殊文件夹

function GetMacAddress: string; //获取MAC地址
function GetCookiesFolder:string; //获取COOKIE的路径
function ShellDeleteFile(sFileName: string): Boolean;

function GetDaysFromBirthday(Birthday: TDateTime):integer; //获取距离生日多少天
function GetConstellationFromBirthday(Birthday: TDateTime):string;
function GetWindowsVersion(): double;  //读取操作系统版本
function isNum(Str: string): Boolean;
function KillTask(ExeFileName: string): integer;
function ExeTSQL(query: string; command: TADOQuery): integer;
function GetFileCount(DirName,FileType:   string):   Integer;
function GetInternetStatus():Boolean;
//function IsOnline():Boolean;

//窗体
function CloseFormLogin(): Boolean;
function CloseFormMain(): Boolean;
function ShowFormOpenFrame(): Boolean;
function ShowFormSetting(): Boolean;
function ShowFormSyncImport(): Boolean;
function ShowFormLogin(): Boolean;
function ShowFormMessageBox(): Boolean;
function ShowFormAlertMessage(): Boolean;
function GetExeByExtension(sExt: string): string; // 注册关联
function ShowFormCloseTip(): Boolean;
function ShowFormUpdate(): Boolean;
function ShowFormAbout(): Boolean;

function GetIEFavourites(const favpath: string): TStrings;//获取收藏夹

//过程
procedure DelCookie(Domain:string);//清除COOKIE
procedure RegisterFileType(ExtName: String; AppName: String);
procedure FontSmoothing(Control: TControl); // 平滑LCD显示器下的字体过渡
procedure Log(LogInfo: string); // 记录日志功能
procedure DebugTrace(TraceName:string; TraceInfo: string);

//WebControl
procedure FixWebBrowser(WebBrowser: TWebBrowser);//修正WEB-BROWSER边框问题

// 注册过程
{*******************************************************************************}
implementation

  uses FormMain, FormLogin, FormSetting, FormMessageBox, FormImportSync,
       FormOpenFrame, FormAlertMessage, FormCloseTip, SystemConfig, MD5,
       FormAbout, FormUpdate;

{*******************************************************************************}
function GetSpecialFolder(const CSIDL: integer) : string;
var
  RecPath : PWideChar;
begin
  RecPath := StrAlloc(MAX_PATH);
    try
    FillChar(RecPath^, MAX_PATH, 0);
    if SHGetSpecialFolderPath(0, RecPath, CSIDL, false)
      then result := RecPath
      else result := '';
    finally
      StrDispose(RecPath); //APPDATA-26
    end;
end;
{*******************************************************************************}
function ShowFormCloseTip(): Boolean;
begin
  Result := False;
  if frmCloseTip = nil then begin
    frmCloseTip := TfrmCloseTip.Create(Application);
    try
      try
        frmCloseTip.ShowModal;
        frmCloseTip.Update;
      except on E: Exception do begin
          Log(E.Message);
        end;
      end;
    finally
      FreeAndNil(frmCloseTip);
    end;
  end else begin
    frmCloseTip.BringToFront;
  end;

end;
{*******************************************************************************}
function GetCurrenPCIECookie(URL: string; CookieName: string): string;
var
  lpvBuffer: array [0 .. 1000] of byte;
  lpdwBufferLength: cardinal;
begin
  lpdwBufferLength := sizeof(lpvBuffer);

  if (InternetGetCookie(PChar(URL), PWideChar(CookieName), @lpvBuffer, lpdwBufferLength)) then
    Result := StringReplace(PChar(@lpvBuffer), CookieName+'=', '', [])
  else
    Result:='';
end;
{*******************************************************************************}
function GetIEFavourites(const favpath: string): TStrings;
var
  searchrec: TSearchRec;
  str: TStrings;
  path, dir, FileName: string;
  Buffer: array[0..2047] of Char;
  found: Integer;
begin
  str := TStringList.Create;
  // Get all file names in the favourites path
  path  := FavPath + '\*.url';
  dir   := ExtractFilepath(path);
  found := FindFirst(path, faAnyFile, searchrec);
  while found = 0 do begin
    // Get now URLs from files in variable files
    SetString(FileName, Buffer, GetPrivateProfilestring('InternetShortcut',
      PChar('URL'), nil, Buffer, SizeOf(Buffer), PChar(dir + searchrec.Name)));
    str.Add(FileName);
    found := FindNext(searchrec);
  end;
  // find Subfolders
  found := FindFirst(dir + '\*.*', faAnyFile, searchrec);
  while found = 0 do
  begin
    if ((searchrec.Attr and faDirectory) > 0) and (searchrec.Name[1] <> '.') then
      str.Addstrings(GetIEFavourites(dir + '\' + searchrec.Name));
    found := FindNext(searchrec);
  end;
  FindClose(searchrec);
  Result := str;
end;

{*******************************************************************************}
function GetCurrenPCUniqId : string;
var UniqId: string;
    Info:THardwareInfo;
begin
  Info:=THardwareInfo.Create;
  //MAC+硬盘物理序列号+CPU 序列号
  UniqId:= Info.GetMACAddress() + Info.GetIDEDiskSerialNumber + Info.GetCPUInfo(1);

  Result:= StrToMD5(UniqId,9);
end;
{*******************************************************************************}
function GetMacAddress: string;
var
  lib: Cardinal;
  Func: function(GUID: PGUID): Longint;
stdcall;
GUID1, GUID2: TGUID;
begin
  Result := '';
  lib := Loadlibrary('rpcrt4.dll');
  if lib <> 0 then
  begin
    if Win32Platform <> VER_PLATFORM_WIN32_NT then
      @Func := GetProcAddress(lib, 'UuidCreate')
    else
      @Func := GetProcAddress(lib, 'UuidCreateSequential');
    if Assigned(Func) then
    begin
      if (Func(@GUID1) = 0) and (Func(@GUID2) = 0) and
        (GUID1.D4[2] = GUID2.D4[2]) and (GUID1.D4[3] = GUID2.D4[3]) and
        (GUID1.D4[4] = GUID2.D4[4]) and (GUID1.D4[5] = GUID2.D4[5]) and
        (GUID1.D4[6] = GUID2.D4[6]) and (GUID1.D4[7] = GUID2.D4[7]) then
      begin
        Result := IntToHex(GUID1.D4[2], 2) + IntToHex(GUID1.D4[3], 2) + IntToHex
          (GUID1.D4[4], 2) + IntToHex(GUID1.D4[5], 2) + IntToHex(GUID1.D4[6],
          2) + IntToHex(GUID1.D4[7], 2);
      end;
    end;
    FreeLibrary(lib);
  end;
end;
{*******************************************************************************}
function GetCookiesFolder:string;
var
  pidl:pItemIDList;
  buffer:array [ 0..255 ] of char;
begin
  SHGetSpecialFolderLocation(Application.Handle , CSIDL_COOKIES, pidl);
  SHGetPathFromIDList(pidl, buffer);
  Result:=StrPas(buffer);
end;
{*******************************************************************************}
function ShellDeleteFile(sFileName: string): Boolean;
var
  FOS: TSHFileOpStruct;
begin
  FillChar(FOS, SizeOf(FOS), 0); {记录清零}
  with FOS do
  begin
     wFunc := FO_DELETE;//删除
     pFrom := PChar(sFileName);
     fFlags := FOF_NOCONFIRMATION;
  end;
  Result := (SHFileOperation(FOS) = 0);
end;
{*******************************************************************************}
procedure DelCookie(Domain:string);
var CookiePath: string;
begin
  try
   InternetSetOption(nil, INTERNET_OPTION_END_BROWSER_SESSION, nil, 0);
   CookiePath:=GetCookiesFolder;
   ShellDeleteFile(CookiePath+'\*'+Domain+'.txt'+#0);//需#0
  except
   Abort;
  end;
end;
{*******************************************************************************}
function CloseFormMain(): Boolean;
begin
  Result := False;

  frmLogin := TfrmLogin.Create(Application);
  try
    try
      frmMain.Hide;
      frmMain.TrayIconMain.Enabled:= False;
      frmLogin.ShowModal;
      frmLogin.Update;
    except on E: Exception do begin
        Log(E.Message);
      end;
    end;
  finally
    frmLogin.Close;
    frmMain.wbBase.Navigate(DEF_URL_MAIN);
    frmMain.Show;
    frmMain.TrayIconMain.Enabled:= True;
  end;

end;
{*******************************************************************************}
function CloseFormLogin(): Boolean;
begin
  Result := False;
  if frmLogin <> nil then
  begin
    frmLogin.Close;
  end;
end;
{*******************************************************************************}
function ShowFormSyncImport(): Boolean;
begin
  Result := False;
  if frmImportSync = nil then begin
    frmImportSync := TfrmImportSync.Create(Application);
    try
      try
        frmImportSync.ShowModal;
        frmImportSync.Update;
      except on E: Exception do begin
          Log(E.Message);
        end;
      end;
    finally
      FreeAndNil(frmImportSync);
    end;
  end;

end;
{*******************************************************************************}
function ShowFormUpdate(): Boolean;
begin
  Result := False;
  if frmUpdate = nil then begin
    frmUpdate := TfrmUpdate.Create(Application);
    try
      try
        frmUpdate.ShowModal;
        frmUpdate.Update;
      except on E: Exception do begin
          Log(E.Message);
        end;
      end;
    finally
      FreeAndNil(frmUpdate);
    end;
  end;
end;
{*******************************************************************************}
function ShowFormAbout(): Boolean;
begin
  Result := False;
  if frmAbout = nil then begin
    frmAbout := TfrmAbout.Create(Application);
    try
      try
        frmAbout.ShowModal;
        frmAbout.Update;
      except on E: Exception do begin
          Log(E.Message);
        end;
      end;
    finally
      FreeAndNil(frmAbout);
    end;
  end;
end;
{*******************************************************************************}
function ShowFormSetting(): Boolean;
begin
  Result := False;
  if frmSetting = nil then begin
    frmSetting := TfrmSetting.Create(Application);
    try
      try
        frmSetting.ShowModal;
        frmSetting.Update;
      except on E: Exception do begin
          Log(E.Message);
        end;
      end;
    finally
      FreeAndNil(frmSetting);
    end;
  end else begin
    frmSetting.BringToFront;
  end;
end;

{*******************************************************************************}
function ShowFormLogin(): Boolean;
begin
  Result := False;

  if frmLogin = nil then begin
    frmLogin := TfrmLogin.Create(Application);
    try
      try
        frmLogin.ShowModal;
        frmLogin.Update;
      except on E: Exception do begin
          Log(E.Message);
        end;
      end;
    finally
      FreeAndNil(frmLogin);
    end;
  end else begin
    frmLogin.BringToFront;
  end;
end;
{*******************************************************************************}
function ShowFormMessageBox(): Boolean;
begin
  Result := False;
  if not Assigned(frmMessageBox) then begin
    frmMessageBox := TfrmMessageBox.Create(Application);
    try
      frmMessageBox.Show;
      frmMessageBox.Update;
    except on E: Exception do begin
        Log(E.Message);
      end;
    end;

  end else begin
    frmMessageBox.Show; //frmMessageBox.WindowState:= wsNormal;
  end;
end;

{*******************************************************************************}
function ShowFormAlertMessage(): Boolean;
begin
  Result := False;
  if not Assigned(frmAlertMessage) then begin
    frmAlertMessage := TfrmAlertMessage.Create(Application);
    try
      frmAlertMessage.Show;
      frmAlertMessage.Update;
    except on E: Exception do begin
        Log(E.Message);
      end;
    end;

  end else begin
    frmAlertMessage.Show; //frmMessageBox.WindowState:= wsNormal;
  end;
end;

{*******************************************************************************}
function ShowFormOpenFrame(): Boolean;
begin
  Result := False;

  frmOpenFrame := TfrmOpenFrame.Create(Application);
  try
    frmOpenFrame.Show;
    frmOpenFrame.Update;
  except on E: Exception do begin
      Log(E.Message);
    end;
  end;

end;

{*******************************************************************************}
{function IsOnline():Boolean;
var IdIPWatch1: TIdIPWatch; 
begin
IdIPWatch1:=TIdIPWatch.Create(nil);
IdIPWatch1.HistoryEnabled:=false;
IdIpWatch1.Active:=True; 
if IdIpWatch1.ForceCheck=True  then begin 
  IdIPWatch1.Free;
  Result:=true;
end else begin
  IdIPWatch1.Free;
  Result:=false;
end;

end; }

{*******************************************************************************}
function GetInternetStatus():Boolean;
var Flags: DWORD;
begin 
Result := InternetGetConnectedState(@Flags, 0); 
if Result then begin 
if (Flags and INTERNET_CONNECTION_MODEM) = INTERNET_CONNECTION_MODEM then begin
//拨号                                                                            
end;
if (Flags and INTERNET_CONNECTION_LAN) = INTERNET_CONNECTION_LAN then begin
//局域网                                                                        
end;
if (Flags and INTERNET_CONNECTION_PROXY) = INTERNET_CONNECTION_PROXY then begin
//代理

end;
if (Flags and INTERNET_CONNECTION_MODEM_BUSY)=INTERNET_CONNECTION_MODEM_BUSY then begin
//MODEM被其他非INTERNET连接占用                                                                                    
end;
end; 
end;
{*******************************************************************************}
procedure FixWebBrowser(WebBrowser: TWebBrowser);
begin
  //调整无边框WEBBROWSER效果-配合CSS更佳 
  WebBrowser.Width := TControl(WebBrowser)
    .Parent.ClientWidth + 3;
  WebBrowser.Height := TControl(WebBrowser)
    .Parent.ClientHeight + 3;
  WebBrowser.Left := -2;
  WebBrowser.Top := -2;
end;

{ *******************************************************************************}
function GetConstellationFromBirthday(Birthday: TDateTime):string;
var sYear,sMonth,sDay:Word;   
    cCons:String;
begin
  DecodeDate(Birthday,sYear,sMonth,sDay);
  case (sMonth) of
    1:if (sDay > 20) then cCons := '水瓶座' else cCons := '摩羯座';
    2:if (sDay > 19) then cCons := '双鱼座' else cCons := '双鱼座';
    3:if (sDay > 20) then cCons := '牡羊座' else cCons := '双鱼座';
    4:if (sDay > 20) then cCons := '金牛座' else cCons := '牡羊座';
    5:if (sDay > 21) then cCons := '双子座' else cCons := '金牛座';
    6:if (sDay > 21) then cCons := '巨蟹座' else cCons := '双子座';
    7:if (sDay > 23) then cCons := '狮子座' else cCons := '巨蟹座';
    8:if (sDay > 23) then cCons := '处女座' else cCons := '狮子座';
    9:if (sDay > 23) then cCons := '天秤座' else cCons := '处女座';
    10:if (sDay > 23) then cCons := '天蝎座' else cCons := '天秤座';
    11:if (sDay > 22) then cCons := '射手座' else cCons := '天蝎座';
    12:if (sDay > 21) then cCons := '摩羯座' else cCons := '射手座';
  end;


  Result:=cCons;     

end;
 
{ *******************************************************************************}
function GetDaysFromBirthday(Birthday: TDateTime):integer;
begin
Birthday:=StrToDate(FormatDateTime('yyyy-mm-dd', Birthday));
Result:=DaysBetween(Now(), Birthday);
end;


{ *******************************************************************************} 
function   GetFileCount(DirName,FileType:   string):   Integer;
var DirInfo:   TSearchRec;
    DosError:   Integer;
begin
      Result   :=   0;   
      DosError   :=   FindFirst(DirName+'\*.*',   FaAnyfile,   DirInfo);   
      while   DosError=0   do   
      begin   
          if   ((DirInfo.Attr   and   FaDirectory)=faDirectory)   and   (DirInfo.Name<>'.')   and   (DirInfo.Name<>'..')
          then   Result   :=   Result   +   GetFileCount(DirName   +   '\'   +   DirInfo.Name,   FileType);
          {$IF   DEFINED(WIN32)   AND   DECLARED(UsingVCL)}   
          if   ((DirInfo.Attr   and   FaDirectory)<>FaDirectory)   and   ((DirInfo.Attr   and   FaVolumeID)<>FaVolumeID)   
          {$ELSE}   
          if   ((DirInfo.Attr   and   FaDirectory)<>FaDirectory)   
          {$IFEND}   
          then   if   Trim(FileType)='*.*'   
                    then   Inc(Result)   
                    else   if   Pos(UpperCase(Copy(FileType,Pos('*',FileType)+1,Length(FileType)-1)),UpperCase(DirInfo.Name))>0
                              then   Inc(Result);   
          DosError   :=   FindNext(DirInfo);   
      end;   
      SysUtils.FindClose(DirInfo);
end;
{ *******************************************************************************} 
function GetWindowsVersion(): double;  //读取操作系统版本
var
  AWin32Version: Extended;
begin
  AWin32Version := StrToFloat(format('%d.%d' ,[Win32MajorVersion, Win32MinorVersion]));

  Result:=  AWin32Version;
  {if Win32Platform=VER_PLATFORM_WIN32s then
    Result := os + '32'
  else if Win32Platform=VER_PLATFORM_WIN32_WINDOWS then
  begin
    if AWin32Version=4.0 then
      Result := os + '95'
    else if AWin32Version=4.1 then
      Result := os + '98'
    else if AWin32Version=4.9 then
      Result := os + 'Me'
    else
      Result := os + '9x'
  end
  else if Win32Platform = VER_PLATFORM_WIN32_NT then
  begin
    if AWin32Version=3.51 then
      Result := os + 'NT 3.51'
    else if AWin32Version=4.0 then
      Result := os + 'NT 4.0'
    else if AWin32Version=5.0 then
      Result := os + '2000'
    else if AWin32Version=5.1 then
      Result := os + 'XP'
    else if AWin32Version=5.2 then
      Result := os + '2003'
    else if AWin32Version=6.0 then
      Result := os + 'Vista'
    else if AWin32Version=6.1 then
      Result := os + '7'
    else
      Result := os ;
  end
  else
    Result := os + '??';
    Result:=Result + '  '+GetWIndowsVersionString;  }
end;

{ *******************************************************************************}
  
{$REGION '关联涉及注册表一些操作公用函数+过程'}
{ ******************************************************************************* }
procedure RegisterFileType(ExtName: String; AppName: String);
var
  reg: TRegistry;
begin
  reg := TRegistry.Create;
  try
    try
      reg.RootKey := HKEY_CLASSES_ROOT;
      reg.OpenKey('.' + ExtName, True);
      reg.WriteString('', ExtName + 'file');
      reg.CloseKey;
      reg.CreateKey(ExtName + 'file');
      reg.OpenKey(ExtName + 'file\DefaultIcon', True);
      reg.WriteString('', AppName + ',0');
      reg.CloseKey;
      reg.OpenKey(ExtName + 'file\shell\open\command', True);
      reg.WriteString('', AppName + ' "%1"');
      reg.CloseKey;
    except
      on E: Exception do
      begin
        Log(E.Message);
      end;
    end;
  finally
    reg.Free;
  end;

  SHChangeNotify(SHCNE_ASSOCCHANGED, SHCNF_IDLIST, nil, nil);
end;

{ ******************************************************************************* }
function GetExeByExtension(sExt: string): string;
var
  sExtDesc: string;
begin
  with TRegistry.Create do
  begin
    try
      RootKey := HKEY_CLASSES_ROOT;
      if OpenKeyReadOnly(sExt) then
      begin
        sExtDesc := ReadString('');
        CloseKey;
      end;
      if sExtDesc <> '' then
      begin
        if OpenKeyReadOnly(sExtDesc + '\Shell\Open\Command') then
        begin
          Result := ReadString('');
        end
      end;
    finally
      Free;
    end;
  end;

  if Result <> '' then
  begin
    if Result[1] = '"' then
    begin
      Result := Copy(Result, 2, -1 + Pos('"', Copy(Result, 2, MaxINt)));
    end
  end;
end;
{$ENDREGION}

{ ******************************************************************************* }
{
function CloseFormBackground(): Boolean;
begin
  Result := False;
  if frmBackground <> nil then
  begin
    frmBackground.Close;
  end;

end;  }


{******************************************************************************* }
function ExeTSQL(query: string; command: TADOQuery): integer;
  var
    i: integer;
  begin
    i:=9999;
    With command do
    begin
      if Active then
        Close;
      With SQL do
      begin
        Clear;
        Add(query);
      end;
      try
        i := ExecSQL;
      except
        on E: Exception do
          Log(E.Message);
      end;
    end;
    Result:=i;
  end;

{******************************************************************************* }
procedure DebugTrace(TraceName:string; TraceInfo: string);
  var
    Path: String;
    PathFile: TextFile;
  begin
    {$IFDEF DEBUG}
    Path := ExtractFileDir(Application.ExeName) + '\log\trace_' + DateToStr(Date)
      + '.txt';
    Try
      AssignFile(PathFile, Path);
      If NOT FileExists(Path) Then
      Begin
        ReWrite(PathFile);
      End;
      Append(PathFile);
      WriteLn(PathFile, TraceName + #13#10 + TraceInfo + #13#10 +
          '____________________________________________________________________________________');
      CloseFile(PathFile);
    Except
    End;
    {$ENDIF}
  end;
{******************************************************************************* }
procedure Log(LogInfo: string);
  var
    Path: String;
    PathFile: TextFile;
  begin
    Path := ExtractFileDir(Application.ExeName) + '\log\log_' + DateToStr(Date)
      + '.txt';
    Try
      AssignFile(PathFile, Path);
      If NOT FileExists(Path) Then
      Begin
        ReWrite(PathFile);
      End;
      Append(PathFile);
      WriteLn(PathFile, DateTimeToStr(Now) + #13#10 + LogInfo + #13#10 +
          '--------------------------------------------------------');
      CloseFile(PathFile);
    Except
    End;
  end;
{******************************************************************************* }
{$REGION '平滑LCD显示器下的ClearType显示美化'}

  procedure FontSmoothing(Control: TControl); // 平滑LCD显示器下的字体过渡 
  var
    tagLOGFONT: TLogFont;
    fOsId:double;
  begin
    fOsId:=GetWindowsVersion();
    if fOsId>=6 then
    begin
      Exit;
    end;

    if Control is TEdit then
    begin // Edit 
      GetObject(TEdit(Control).Font.Handle, SizeOf(TLogFont), @tagLOGFONT);
      tagLOGFONT.lfQuality := ANTIALIASED_QUALITY;
      TEdit(Control).Font.Handle := CreateFontIndirect(tagLOGFONT);
      Exit;
    end;

    if Control is TPanel then
    begin // Panel 
      GetObject(TPanel(Control).Font.Handle, SizeOf(TLogFont), @tagLOGFONT);
      tagLOGFONT.lfQuality := ANTIALIASED_QUALITY;
      TPanel(Control).Font.Handle := CreateFontIndirect(tagLOGFONT);
      Exit;
    end;

    if Control is TLabel then
    begin // Label 
      GetObject(TLabel(Control).Font.Handle, SizeOf(TLogFont), @tagLOGFONT);
      tagLOGFONT.lfQuality := ANTIALIASED_QUALITY;
      TLabel(Control).Font.Handle := CreateFontIndirect(tagLOGFONT);
      Exit;
    end;

    if Control is TMemo then
    begin // Label 
      GetObject(TMemo(Control).Font.Handle, SizeOf(TLogFont), @tagLOGFONT);
      tagLOGFONT.lfQuality := ANTIALIASED_QUALITY;
      TMemo(Control).Font.Handle := CreateFontIndirect(tagLOGFONT);
      Exit;
    end;

    if Control is TRzLabel then
    begin // RzLabel 
      GetObject(TRzLabel(Control).Font.Handle, SizeOf(TLogFont), @tagLOGFONT);
      tagLOGFONT.lfQuality := ANTIALIASED_QUALITY;
      TRzLabel(Control).Font.Handle := CreateFontIndirect(tagLOGFONT);
      Exit;
    end;

    if Control is TButton then
    begin // Button 
      GetObject(TButton(Control).Font.Handle, SizeOf(TLogFont), @tagLOGFONT);
      tagLOGFONT.lfQuality := ANTIALIASED_QUALITY;
      TButton(Control).Font.Handle := CreateFontIndirect(tagLOGFONT);
      Exit;
    end;
    if Control is TRzBmpButton then
    begin // RzBmpButton 
      GetObject(TRzBmpButton(Control).Font.Handle, SizeOf(TLogFont),
        @tagLOGFONT);
      tagLOGFONT.lfQuality := ANTIALIASED_QUALITY;
      TRzBmpButton(Control).Font.Handle := CreateFontIndirect(tagLOGFONT);
      Exit;
    end;
    if Control is TRzPanel then
    begin // RzPanel 
      GetObject(TRzPanel(Control).Font.Handle, SizeOf(TLogFont), @tagLOGFONT);
      tagLOGFONT.lfQuality := ANTIALIASED_QUALITY;
      TRzPanel(Control).Font.Handle := CreateFontIndirect(tagLOGFONT);
      Exit;
    end;

    if Control is TRzButton then
    begin // RzButton 
      GetObject(TRzButton(Control).Font.Handle, SizeOf(TLogFont), @tagLOGFONT);
      tagLOGFONT.lfQuality := ANTIALIASED_QUALITY;
      TRzButton(Control).Font.Handle := CreateFontIndirect(tagLOGFONT);
      Exit;
    end;

    if Control is TRzListBox then
    begin // RzListBox 
      GetObject(TRzListBox(Control).Font.Handle, SizeOf(TLogFont), @tagLOGFONT);
      tagLOGFONT.lfQuality := ANTIALIASED_QUALITY;
      TRzListBox(Control).Font.Handle := CreateFontIndirect(tagLOGFONT);
      Exit;
    end;

    if Control is TRzProgressBar then
    begin // RzProgressBar 
      GetObject(TRzProgressBar(Control).Font.Handle, SizeOf(TLogFont),
        @tagLOGFONT);
      tagLOGFONT.lfQuality := ANTIALIASED_QUALITY;
      TRzProgressBar(Control).Font.Handle := CreateFontIndirect(tagLOGFONT);
      Exit;
    end;

  end;
{$ENDREGION}
{$REGION '杀掉系统某个进程函数'}

  function KillTask(ExeFileName: string): integer;
  const
    PROCESS_TERMINATE = $0001;
  var
    ContinueLoop: BOOL;
    FSnapshotHandle: THandle;
    FProcessEntry32: TProcessEntry32;
  begin
    Result := 0;

    FSnapshotHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
    FProcessEntry32.dwSize := SizeOf(FProcessEntry32);
    ContinueLoop := Process32First(FSnapshotHandle, FProcessEntry32);

    while integer(ContinueLoop) <> 0 do
    begin
      if ((UpperCase(ExtractFileName(FProcessEntry32.szExeFile)) = UpperCase
            (ExeFileName)) or (UpperCase(FProcessEntry32.szExeFile) = UpperCase
            (ExeFileName))) then
        Result := integer(TerminateProcess(OpenProcess(PROCESS_TERMINATE,
              BOOL(0), FProcessEntry32.th32ProcessID), 0));
      ContinueLoop := Process32Next(FSnapshotHandle, FProcessEntry32);
    end;

    CloseHandle(FSnapshotHandle);
  end;
{$ENDREGION}
{******************************************************************************* }
{$REGION '字符串判断是否为数字'}

  function isNum(Str: string): Boolean;
  var
    i: integer;
  Begin
    For i := 1 To Length(Str) Do
      If not(Str[i] in ['0' .. '9']) Then
      Begin
        Result := False;
        Exit;
      End;
    Result := True;
  end;
{$ENDREGION}

{******************************************************************************* }
end.
