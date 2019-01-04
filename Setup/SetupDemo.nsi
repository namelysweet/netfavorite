; ��װ�����ʼ���峣��
!define PROJECT_NAME "Ĵָ��"
!define PRODUCT_NAME "Ĵָ�氲׿��Ϸ��װ��"
!define KEY_NAME "MzwInstaller"
!define PACKAGE_NAME "MzwInstaller.exe"
!define PACKAGE_NAME_BETA "MzwInstaller_2.3.1_build1025.exe"
!define GUIDE_NAME "MzwGuide.exe"
!define UPDATE_NAME "MzwUpdate.exe"
!define DOWNLOAD_NAME "MzwDownload.exe"
!define ADB_NAME "adb.exe"
!define PRODUCT_VERSION "2.3.1 Beta"
!define PRODUCT_PUBLISHER "Ĵָ�氲׿��Ϸ��װ��"
!define PRODUCT_WEB_SITE "http://www.muzhiwan.com/"
!define PRODUCT_DIR_REGKEY "Software\Microsoft\Windows\CurrentVersion\App Paths\${PACKAGE_NAME}"
!define PRODUCT_UNINST_KEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}"
!define PRODUCT_UNINST_ROOT_KEY "HKLM"
!define FILE_DIRECTORY "..\bin\*"
!define COMPANY_NAME "��������չ��Ƽ����޹�˾"
!define COM_DIR_NAME "$LOCALAPPDATA\${KEY_NAME}\com"

!define Project Ĵָ�氲׿��Ϸ��װ��        ;�������ʶ��ǰ׺���Ա����ļ���������
!define StrongAssoc                 ;�Ƿ�ʹ��ǿ��������ʹ��ǿ���������ڶദ��������ļ������ѱ���ռ��
!define Count_Of_InstType 0         ;InstType����
!define Backup                      ;ָ���ָ�����

SetCompressor /SOLID lzma
RequestExecutionLevel admin
CRCCheck on

; ------ MUI �ִ����涨�� (1.67 �汾���ϼ���) ------
!include "MUI.nsh"
!include "x64.nsh"
!include "Assoc.nsh"

; MUI Ԥ���峣��
!define MUI_ABORTWARNING

!define MUI_ICON "mzwinstaller.ico"
!define MUI_WELCOMEFINISHPAGE_BITMAP "flibpoto.bmp"
!define MUI_WELCOMEPAGE_TITLE "\r\n${PRODUCT_NAME}${PRODUCT_VERSION}��װ��"
!define MUI_WELCOMEPAGE_TITLE_3LINES
!define MUI_WELCOMEPAGE_TEXT "\r\n����װ�򵼽�ָ������ɡ�${PRODUCT_NAME}${PRODUCT_VERSION}���İ�װ���̡�\r\n\r\n�ڿ�ʼ��װ֮ǰ�������ȹر���������Ӧ�ó����⽫������װ���򡱸���ָ����ϵͳ�ļ���������Ҫ����������ļ������\r\n\r\n$_CLICK"

; ��ӭҳ��
!insertmacro MUI_PAGE_WELCOME
; ��װĿ¼ѡ��ҳ��
!insertmacro MUI_PAGE_DIRECTORY

; ��װ����ҳ��
!insertmacro MUI_PAGE_INSTFILES
; ��װ�������
!define MUI_FINISHPAGE_RUN "$INSTDIR\${PACKAGE_NAME}"
; ��װ���ҳ��
!insertmacro MUI_PAGE_FINISH

; ��װж�ع���ҳ��
!insertmacro MUI_UNPAGE_INSTFILES

; ��װ�����������������
!insertmacro MUI_LANGUAGE "SimpChinese"

; ��װԤ�ͷ��ļ�
!insertmacro MUI_RESERVEFILE_INSTALLOPTIONS
; ------ MUI �ִ����涨����� ------

VIProductVersion "2.3.1.1025"
VIAddVersionKey /LANG=2052 "ProductName" "${PRODUCT_NAME}"
VIAddVersionKey /LANG=2052 "LegalCopyright" "${COMPANY_NAME}"
VIAddVersionKey /LANG=2052 "CompanyName" "MUZHIWAN"
VIAddVersionKey /LANG=2052 "FileDescription" "${PRODUCT_NAME}"
VIAddVersionKey /LANG=2052 "FileVersion" "${PRODUCT_VERSION}"
VIAddVersionKey /LANG=2052 "ProductVersion" "${PRODUCT_VERSION}"

Name "${PRODUCT_NAME}"
OutFile "${PACKAGE_NAME_BETA}"
InstallDir "$PROGRAMFILES\${KEY_NAME}\"
InstallDirRegKey HKLM "${PRODUCT_UNINST_KEY}" "UninstallString"
BrandingText "��${PROJECT_NAME} ${PRODUCT_WEB_SITE}"

; ��װģ��
Section "Mainsection" SEC_INSTALL
  SetOutPath "$INSTDIR"
  SetOverwrite on
  File /r "${FILE_DIRECTORY}"
  CreateDirectory "$SMPROGRAMS\${PRODUCT_NAME}"
  CreateDirectory "$LOCALAPPDATA\${KEY_NAME}"
  CreateDirectory "${COM_DIR_NAME}"
  
	${If} ${RunningX64}
	 IfFileExists "${COM_DIR_NAME}\MzwIconOverlay_x64.dll" 0 +3
	  ExecWait 'regsvr32.exe /u /s "${COM_DIR_NAME}\MzwIconOverlay_x64.dll"'
	  Rename "${COM_DIR_NAME}\MzwIconOverlay_x64.dll" "${COM_DIR_NAME}\MzwIconOverlay_x64_old.dll"
	 IfFileExists "${COM_DIR_NAME}\MzwIconShell_x64.dll" 0 +3
    ExecWait 'regsvr32.exe /u /s "${COM_DIR_NAME}\MzwIconShell_x64.dll"'
	  Rename "${COM_DIR_NAME}\MzwIconShell_x64.dll" "${COM_DIR_NAME}\MzwIconShell_x64_old.dll"
   IfFileExists "${COM_DIR_NAME}\MzwNet_x64.dll" 0 +2
	  Rename "${COM_DIR_NAME}\MzwNet_x64.dll" "${COM_DIR_NAME}\MzwNet_x64_old.dll"
   IfFileExists "${COM_DIR_NAME}\MzwGpk_x64.dll" 0 +2
	  Rename "${COM_DIR_NAME}\MzwGpk_x64.dll" "${COM_DIR_NAME}\MzwGpk_x64_old.dll"
   IfFileExists "${COM_DIR_NAME}\MzwUtils_x64.dll" 0 +2
	  Rename "${COM_DIR_NAME}\MzwUtils_x64.dll" "${COM_DIR_NAME}\MzwUtils_x64_old.dll"
   IfFileExists "${COM_DIR_NAME}\System.Data.SQLite.DLL" 0 +2
	  Rename "${COM_DIR_NAME}\System.Data.SQLite.DLL" "${COM_DIR_NAME}\System.Data.SQLite_old.DLL"
	 CopyFiles /SILENT "$INSTDIR\com\x64\MzwIconOverlay_x64.dll" "${COM_DIR_NAME}"
	 CopyFiles /SILENT "$INSTDIR\com\x64\MzwIconShell_x64.dll" "${COM_DIR_NAME}"
	 CopyFiles /SILENT "$INSTDIR\com\x64\MzwNet_x64.dll" "${COM_DIR_NAME}"
	 CopyFiles /SILENT "$INSTDIR\com\x64\MzwGpk_x64.dll" "${COM_DIR_NAME}"
	 CopyFiles /SILENT "$INSTDIR\com\x64\MzwUtils_x64.dll" "${COM_DIR_NAME}"
	 CopyFiles /SILENT "$INSTDIR\com\x64\System.Data.SQLite.DLL" "${COM_DIR_NAME}"
	 RMDir /r "$INSTDIR\com\x86"
	 ExecWait 'regsvr32.exe /s "${COM_DIR_NAME}\MzwIconShell_x64.dll"'
	 ExecWait 'regsvr32.exe /s "${COM_DIR_NAME}\MzwIconOverlay_x64.dll"'
	${Else}
	 IfFileExists "${COM_DIR_NAME}\MzwIconOverlay.dll" 0 +3
    ExecWait 'regsvr32.exe /u /s "${COM_DIR_NAME}\MzwIconOverlay.dll"'
	  Rename "${COM_DIR_NAME}\MzwIconOverlay.dll" "${COM_DIR_NAME}\MzwIconOverlay_old.dll"
	 IfFileExists "${COM_DIR_NAME}\MzwIconShell.dll" 0 +3
    ExecWait 'regsvr32.exe /u /s "${COM_DIR_NAME}\MzwIconShell.dll"'
	  Rename "${COM_DIR_NAME}\MzwIconShell.dll" "${COM_DIR_NAME}\MzwIconShell_old.dll"
   IfFileExists "${COM_DIR_NAME}\MzwNetm.dll" 0 +2
	  Rename "${COM_DIR_NAME}\MzwNetm.dll" "${COM_DIR_NAME}\MzwNetm_old.dll"
   IfFileExists "${COM_DIR_NAME}\MzwGpkm.dll" 0 +2
	  Rename "${COM_DIR_NAME}\MzwGpkm.dll" "${COM_DIR_NAME}\MzwGpkm_old.dll"
   IfFileExists "${COM_DIR_NAME}\MzwUtils.dll" 0 +2
	  Rename "${COM_DIR_NAME}\MzwUtils.dll" "${COM_DIR_NAME}\MzwUtils_old.dll"
   IfFileExists "${COM_DIR_NAME}\sqlite3.dll" 0 +2
	  Rename "${COM_DIR_NAME}\sqlite3.dll" "${COM_DIR_NAME}\sqlite3_old.dll"
   CopyFiles /SILENT "$INSTDIR\com\x86\MzwIconOverlay.dll" "${COM_DIR_NAME}"
   CopyFiles /SILENT "$INSTDIR\com\x86\MzwIconShell.dll" "${COM_DIR_NAME}"
   CopyFiles /SILENT "$INSTDIR\com\x86\MzwNetm.dll" "${COM_DIR_NAME}"
   CopyFiles /SILENT "$INSTDIR\com\x86\MzwGpkm.dll" "${COM_DIR_NAME}"
   CopyFiles /SILENT "$INSTDIR\MzwUtils.dll" "${COM_DIR_NAME}"
	 CopyFiles /SILENT "$INSTDIR\com\x86\sqlite3.dll" "${COM_DIR_NAME}"
   RMDir /r "$INSTDIR\com\x64"
   ExecWait 'regsvr32.exe /s "${COM_DIR_NAME}\MzwIconShell.dll"'
	 ExecWait 'regsvr32.exe /s "${COM_DIR_NAME}\MzwIconOverlay.dll"'
	${EndIf}
	
	MessageBox MB_ICONQUESTION|MB_YESNO|MB_DEFBUTTON1 "�Ƿ�����������Դ��������Explorer������ʹĴָ�������Ч��" IDNO Restart
	${If} ${RunningX64}
   ExecWait "$INSTDIR\RestartExplorer_x64.exe"
	${Else}
   ExecWait "$INSTDIR\RestartExplorer_x86.exe"
	${EndIf}
	${If} ${RunningX64}
   Delete "${COM_DIR_NAME}\MzwIconOverlay_x64_old.dll"
   Delete "${COM_DIR_NAME}\MzwIconShell_x64_old.dll"
   Delete "${COM_DIR_NAME}\MzwNet_x64_old.dll"
   Delete "${COM_DIR_NAME}\MzwGpk_x64_old.dll"
   Delete "${COM_DIR_NAME}\MzwUtils_x64_old.dll"
   Delete "${COM_DIR_NAME}\System.Data.SQLite_old.DLL"
  ${Else}
   Delete "${COM_DIR_NAME}\MzwIconOverlay_old.dll"
   Delete "${COM_DIR_NAME}\MzwIconShell_old.dll"
   Delete "${COM_DIR_NAME}\MzwNetm_old.dll"
   Delete "${COM_DIR_NAME}\MzwGpkm_old.dll"
   Delete "${COM_DIR_NAME}\MzwUtils_old.dll"
   Delete "${COM_DIR_NAME}\sqlite3_old.dll"
  ${EndIf}
  IfFileExists "$LOCALAPPDATA\${KEY_NAME}\MzwIconCache.db" 0 +2
   Delete "$LOCALAPPDATA\${KEY_NAME}\MzwIconCache.db"
	Goto Done
Restart:
  ${If} ${RunningX64}
   Delete /REBOOTOK "${COM_DIR_NAME}\MzwIconOverlay_x64_old.dll"
   Delete /REBOOTOK "${COM_DIR_NAME}\MzwIconShell_x64_old.dll"
   Delete /REBOOTOK "${COM_DIR_NAME}\MzwNet_x64_old.dll"
   Delete /REBOOTOK "${COM_DIR_NAME}\MzwGpk_x64_old.dll"
   Delete /REBOOTOK "${COM_DIR_NAME}\MzwUtils_x64_old.dll"
   Delete /REBOOTOK "${COM_DIR_NAME}\System.Data.SQLite_old.DLL"
  ${Else}
   Delete /REBOOTOK "${COM_DIR_NAME}\MzwIconOverlay_old.dll"
   Delete /REBOOTOK "${COM_DIR_NAME}\MzwIconShell_old.dll"
   Delete /REBOOTOK "${COM_DIR_NAME}\MzwNetm_old.dll"
   Delete /REBOOTOK "${COM_DIR_NAME}\MzwGpkm_old.dll"
   Delete /REBOOTOK "${COM_DIR_NAME}\MzwUtils_old.dll"
   Delete /REBOOTOK "${COM_DIR_NAME}\sqlite3_old.dll"
  ${EndIf}
  IfFileExists "$LOCALAPPDATA\${KEY_NAME}\MzwIconCache.db" 0 +2
   Delete /REBOOTOK "$LOCALAPPDATA\${KEY_NAME}\MzwIconCache.db"

Done:
	CreateDirectory "${COM_DIR_NAME}\icon"
	CopyFiles /SILENT "$INSTDIR\icon\*.*" "${COM_DIR_NAME}\icon"
  CopyFiles /SILENT "$INSTDIR\*.dat" "$LOCALAPPDATA\${KEY_NAME}"
  IfFileExists "$LOCALAPPDATA\${KEY_NAME}\MzwConfig.ini" 0 +2
   Delete /REBOOTOK "$LOCALAPPDATA\${KEY_NAME}\MzwConfig.ini"
  Delete "$INSTDIR\*.dat"
  Delete "$INSTDIR\RestartExplorer_x86.exe"
  Delete "$INSTDIR\RestartExplorer_x64.exe"
  CreateShortCut "$SMPROGRAMS\${PRODUCT_NAME}\${PRODUCT_NAME}.lnk" "$INSTDIR\${PACKAGE_NAME}"
  CreateShortCut "$SMPROGRAMS\${PRODUCT_NAME}\ж��${PRODUCT_NAME}.lnk" "$INSTDIR\uninst.exe"
  CreateShortCut "$DESKTOP\${PRODUCT_NAME}.lnk" "$INSTDIR\${PACKAGE_NAME}"
  ${Assoc} apk "apkfile" "APK�ļ�" "$INSTDIR\${PACKAGE_NAME}" "$INSTDIR\${PACKAGE_NAME}"
  ${Assoc} gpk "gpkfile" "GPK�ļ�" "$INSTDIR\${PACKAGE_NAME}" "$INSTDIR\${PACKAGE_NAME}"
  
  WriteRegStr HKCR "muzhiwan" "" "URL:MZW Protocol"
  WriteRegStr HKCR "muzhiwan" "URL Protocol" ""
  WriteRegStr HKCR "muzhiwan\DefaultIcon" "" "$INSTDIR\${DOWNLOAD_NAME}"
  WriteRegStr HKCR "muzhiwan\shell\open\command" "" '"$INSTDIR\${DOWNLOAD_NAME}" /d "%1"'
  ExecWait 'regsvr32.exe /s "$INSTDIR\MzwActivXForOneKeyInstall.ocx"'
SectionEnd

Section -AdditionalIcons
  WriteIniStr "$INSTDIR\${PRODUCT_NAME}.url" "InternetShortcut" "URL" "${PRODUCT_WEB_SITE}"
  CreateShortCut "$SMPROGRAMS\${PRODUCT_NAME}\${PROJECT_NAME}�ٷ���վ.lnk" "$INSTDIR\${PRODUCT_NAME}.url"
SectionEnd

Section -RefreshIcon
System::Call 'Shell32::SHChangeNotify(i 0x8000000, i 0, i 0, i 0)'
SectionEnd

Section -Post
  WriteUninstaller "$INSTDIR\uninst.exe"
  WriteRegStr HKLM "${PRODUCT_DIR_REGKEY}" "" "$INSTDIR\${PACKAGE_NAME}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayName" "$(^Name)"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "UninstallString" "$INSTDIR\uninst.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayIcon" "$INSTDIR\${PACKAGE_NAME}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayVersion" "${PRODUCT_VERSION}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "URLInfoAbout" "${PRODUCT_WEB_SITE}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "Publisher" "${PRODUCT_PUBLISHER}"
SectionEnd

; ж��ģ��
Section Uninstall
	Delete "$SMPROGRAMS\${PRODUCT_NAME}\*.*"
	Delete "$DESKTOP\${PRODUCT_NAME}.lnk"
	RMDir /r "$SMPROGRAMS\${PRODUCT_NAME}"
	RMDir /r "$INSTDIR\skin"
	;���ע��
	${If} ${RunningX64}
   ExecWait 'regsvr32.exe /u /s "${COM_DIR_NAME}\MzwIconShell_x64.dll"'
	 ExecWait 'regsvr32.exe /u /s "${COM_DIR_NAME}\MzwIconOverlay_x64.dll"'
	${Else}
   ExecWait 'regsvr32.exe /u /s "${COM_DIR_NAME}\MzwIconShell.dll"'
	 ExecWait 'regsvr32.exe /u /s "${COM_DIR_NAME}\MzwIconOverlay.dll"'
	${EndIf}
	ExecWait 'regsvr32.exe /u /s "$INSTDIR\MzwActivXForOneKeyInstall.ocx"'
	;ɾ���ļ�
	Delete /REBOOTOK "$INSTDIR\${ADB_NAME}"
	Delete /REBOOTOK "$INSTDIR\${GUIDE_NAME}"
	Delete /REBOOTOK "$INSTDIR\${DOWNLOAD_NAME}"
	Delete /REBOOTOK "$INSTDIR\${PACKAGE_NAME}"
	Delete /REBOOTOK "$INSTDIR\${UPDATE_NAME}"
	Delete /REBOOTOK "$INSTDIR\dpinst32.exe"
	Delete /REBOOTOK "$INSTDIR\dpinst64.exe"
	Delete /REBOOTOK "$INSTDIR\uninst.exe"
	Delete /REBOOTOK "$INSTDIR\AqxCustom.dat"
	Delete /REBOOTOK "$INSTDIR\AqxConfig.dat"
	Delete /REBOOTOK "$INSTDIR\Ĵָ�氲׿��Ϸ��װ��.url"
  Delete /REBOOTOK "$INSTDIR\AdbWinApi.dll"
  Delete /REBOOTOK "$INSTDIR\AdbWinUsbApi.dll"
  Delete /REBOOTOK "$INSTDIR\AqxUtils.dll"
  Delete /REBOOTOK "$INSTDIR\msvcr71.dll"
  Delete /REBOOTOK "$INSTDIR\MzwDriver.dll"
  Delete /REBOOTOK "$INSTDIR\MzwDriverW.dll"
  Delete /REBOOTOK "$INSTDIR\MzwGpk.dll"
  Delete /REBOOTOK "$INSTDIR\MzwNet.dll"
  Delete /REBOOTOK "$INSTDIR\MzwUtils.dll"
  Delete /REBOOTOK "$INSTDIR\XLDownload.dll"
  Delete /REBOOTOK "$INSTDIR\zlib1.dll"
  Delete /REBOOTOK "$INSTDIR\MzwLogcat.txt"
  Delete /REBOOTOK "$INSTDIR\HelpInfo.xml"
  Delete /REBOOTOK "$INSTDIR\HelpInfo1.xml"
  Delete /REBOOTOK "$INSTDIR\defaulterror.html"
  Delete /REBOOTOK "$INSTDIR\404.html"
  Delete /REBOOTOK "$INSTDIR\MzwFileRelation.exe"
  Delete /REBOOTOK "$INSTDIR\MzwHelper.exe"
  Delete /REBOOTOK "$INSTDIR\MzwActivXForOneKeyInstall.ocx"
  RMDir /r /REBOOTOK "$INSTDIR\com"
  RMDir /r /REBOOTOK "$INSTDIR\icon"
  RMDir /r /REBOOTOK "$LOCALAPPDATA\${KEY_NAME}"
	RMDir "$INSTDIR"
	;����ע���
	${UnAssoc} apk
	${UnAssoc} gpk
	DeleteRegValue HKCR "Back.${Project}" ""
	DeleteRegKey HKCR "${KEY_NAME}"
	DeleteRegKey HKCR ".apk"
	DeleteRegKey HKCR ".gpk"
	DeleteRegKey HKCR "apkfile"
	DeleteRegKey HKCR "gpkfile"
	DeleteRegKey HKCR "Applications\${PACKAGE_NAME}"
	DeleteRegKey HKLM "SOFTWARE\Classes\apkfile"
	DeleteRegKey HKLM "SOFTWARE\Classes\gpkfile"
	DeleteRegKey HKLM "SOFTWARE\Classes\Applications\${PACKAGE_NAME}"
	DeleteRegKey HKCU "Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.apk"
	DeleteRegKey HKCU "Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.gpk"
	DeleteRegKey ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}"
	DeleteRegKey HKLM "${PRODUCT_DIR_REGKEY}"
	
	DeleteRegKey HKCR "muzhiwan"
	System::Call 'Shell32::SHChangeNotify(i 0x8000000, i 0, i 0, i 0)'
	SetAutoClose true
SectionEnd

;��װʱִ�к���
Function .onInit
	Push $R0
;CheckInstaller:
	ProcessWork::existsprocess ${PACKAGE_NAME}
	Pop $R0
	IntCmp $R0 0 CheckGuide
	MessageBox MB_OKCANCEL|MB_ICONINFORMATION "��⵽��Ĵָ�氲װ�����������У���װ�޷�������$\r$\n�����ȷ���������������̣������ȡ�����˳���װ��" IDCANCEL Exit
	Processwork::KillProcess ${PACKAGE_NAME}
	Processwork::KillProcess ${GUIDE_NAME}
	Processwork::KillProcess ${DOWNLOAD_NAME}
	Processwork::KillProcess ${UPDATE_NAME}
	Sleep 100
	Goto CheckAdb
CheckGuide:
  ProcessWork::existsprocess ${GUIDE_NAME}
	Pop $R0
	IntCmp $R0 0 CheckDownload
	MessageBox MB_OKCANCEL|MB_ICONINFORMATION "��⵽��Ĵָ�������򵼡��������У���װ�޷�������$\r$\n�����ȷ���������������̣������ȡ�����˳���װ��" IDCANCEL Exit
	Processwork::KillProcess ${GUIDE_NAME}
	Processwork::KillProcess ${DOWNLOAD_NAME}
	Processwork::KillProcess ${UPDATE_NAME}
	Sleep 100
	Goto CheckAdb
CheckDownload:
  ProcessWork::existsprocess ${DOWNLOAD_NAME}
	Pop $R0
	IntCmp $R0 0 CheckUpdate
	MessageBox MB_OKCANCEL|MB_ICONINFORMATION "��⵽��Ĵָ�����������������У���װ�޷�������$\r$\n�����ȷ���������������̣������ȡ�����˳���װ��" IDCANCEL Exit
	Processwork::KillProcess ${DOWNLOAD_NAME}
	Processwork::KillProcess ${UPDATE_NAME}
	Sleep 100
	Goto CheckAdb
CheckUpdate:
  ProcessWork::existsprocess ${UPDATE_NAME}
	Pop $R0
	IntCmp $R0 0 CheckAdb
	MessageBox MB_OKCANCEL|MB_ICONINFORMATION "��⵽��Ĵָ�������������������У���װ�޷�������$\r$\n�����ȷ���������������̣������ȡ�����˳���װ��" IDCANCEL Exit
	Processwork::KillProcess ${UPDATE_NAME}
	Sleep 100
CheckAdb:
	Push $R1
Loop:
	ProcessWork::existsprocess ${ADB_NAME}
	Pop $R1
	IntCmp $R1 0 AdbEnd
	Processwork::KillProcess ${ADB_NAME}
	Sleep 100
	Goto Loop
AdbEnd:
	Pop $R1
	Goto Done
Exit:
	Abort
Done:
	Pop $R0
FunctionEnd

; ж��ʱִ�к���
Function un.onInit
	MessageBox MB_ICONQUESTION|MB_YESNO|MB_DEFBUTTON2 "��ȷʵҪ��ȫ�Ƴ� $(^Name) ���������е������" IDNO Exit
	Processwork::KillProcess ${PACKAGE_NAME}
	Processwork::KillProcess ${GUIDE_NAME}
	Processwork::KillProcess ${DOWNLOAD_NAME}
	Processwork::KillProcess ${UPDATE_NAME}
	Push $R0
Loop:
	Push ${ADB_NAME}
	ProcessWork::existsprocess
	Pop $R0
	IntCmp $R0 0 Done
	Push ${ADB_NAME}
	Processwork::KillProcess
	Sleep 100
	Goto Loop
Exit:
	Abort
Done:
	Pop $R0
FunctionEnd

; ж�سɹ���ִ�к���
Function un.onUninstSuccess
  HideWindow
  MessageBox MB_ICONINFORMATION|MB_OK "$(^Name) �ѳɹ��ش���ļ�����Ƴ���"
  ExecShell open "http://app.muzhiwan.com/mzwinstaller/uninstall.html"
FunctionEnd
