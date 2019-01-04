; 安装程序初始定义常量
!define PROJECT_NAME "拇指玩"
!define PRODUCT_NAME "拇指玩安卓游戏安装器"
!define KEY_NAME "MzwInstaller"
!define PACKAGE_NAME "MzwInstaller.exe"
!define PACKAGE_NAME_BETA "MzwInstaller_2.3.1_build1025.exe"
!define GUIDE_NAME "MzwGuide.exe"
!define UPDATE_NAME "MzwUpdate.exe"
!define DOWNLOAD_NAME "MzwDownload.exe"
!define ADB_NAME "adb.exe"
!define PRODUCT_VERSION "2.3.1 Beta"
!define PRODUCT_PUBLISHER "拇指玩安卓游戏安装器"
!define PRODUCT_WEB_SITE "http://www.muzhiwan.com/"
!define PRODUCT_DIR_REGKEY "Software\Microsoft\Windows\CurrentVersion\App Paths\${PACKAGE_NAME}"
!define PRODUCT_UNINST_KEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}"
!define PRODUCT_UNINST_ROOT_KEY "HKLM"
!define FILE_DIRECTORY "..\bin\*"
!define COMPANY_NAME "北京富邦展瑞科技有限公司"
!define COM_DIR_NAME "$LOCALAPPDATA\${KEY_NAME}\com"

!define Project 拇指玩安卓游戏安装器        ;定义关联识别前缀，以便标记文件归属程序
!define StrongAssoc                 ;是否使用强力关联，使用强力关联能在多处关联相关文件，较难被抢占。
!define Count_Of_InstType 0         ;InstType总数
!define Backup                      ;指定恢复备份

SetCompressor /SOLID lzma
RequestExecutionLevel admin
CRCCheck on

; ------ MUI 现代界面定义 (1.67 版本以上兼容) ------
!include "MUI.nsh"
!include "x64.nsh"
!include "Assoc.nsh"

; MUI 预定义常量
!define MUI_ABORTWARNING

!define MUI_ICON "mzwinstaller.ico"
!define MUI_WELCOMEFINISHPAGE_BITMAP "flibpoto.bmp"
!define MUI_WELCOMEPAGE_TITLE "\r\n${PRODUCT_NAME}${PRODUCT_VERSION}安装向导"
!define MUI_WELCOMEPAGE_TITLE_3LINES
!define MUI_WELCOMEPAGE_TEXT "\r\n本安装向导将指引你完成“${PRODUCT_NAME}${PRODUCT_VERSION}”的安装进程。\r\n\r\n在开始安装之前，建议先关闭其他所有应用程序。这将允许“安装程序”更新指定的系统文件，而不需要重新启动你的计算机。\r\n\r\n$_CLICK"

; 欢迎页面
!insertmacro MUI_PAGE_WELCOME
; 安装目录选择页面
!insertmacro MUI_PAGE_DIRECTORY

; 安装过程页面
!insertmacro MUI_PAGE_INSTFILES
; 安装完后运行
!define MUI_FINISHPAGE_RUN "$INSTDIR\${PACKAGE_NAME}"
; 安装完成页面
!insertmacro MUI_PAGE_FINISH

; 安装卸载过程页面
!insertmacro MUI_UNPAGE_INSTFILES

; 安装界面包含的语言设置
!insertmacro MUI_LANGUAGE "SimpChinese"

; 安装预释放文件
!insertmacro MUI_RESERVEFILE_INSTALLOPTIONS
; ------ MUI 现代界面定义结束 ------

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
BrandingText "　${PROJECT_NAME} ${PRODUCT_WEB_SITE}"

; 安装模块
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
	
	MessageBox MB_ICONQUESTION|MB_YESNO|MB_DEFBUTTON1 "是否立即重启资源管理器（Explorer）进程使拇指玩组件生效？" IDNO Restart
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
  CreateShortCut "$SMPROGRAMS\${PRODUCT_NAME}\卸载${PRODUCT_NAME}.lnk" "$INSTDIR\uninst.exe"
  CreateShortCut "$DESKTOP\${PRODUCT_NAME}.lnk" "$INSTDIR\${PACKAGE_NAME}"
  ${Assoc} apk "apkfile" "APK文件" "$INSTDIR\${PACKAGE_NAME}" "$INSTDIR\${PACKAGE_NAME}"
  ${Assoc} gpk "gpkfile" "GPK文件" "$INSTDIR\${PACKAGE_NAME}" "$INSTDIR\${PACKAGE_NAME}"
  
  WriteRegStr HKCR "muzhiwan" "" "URL:MZW Protocol"
  WriteRegStr HKCR "muzhiwan" "URL Protocol" ""
  WriteRegStr HKCR "muzhiwan\DefaultIcon" "" "$INSTDIR\${DOWNLOAD_NAME}"
  WriteRegStr HKCR "muzhiwan\shell\open\command" "" '"$INSTDIR\${DOWNLOAD_NAME}" /d "%1"'
  ExecWait 'regsvr32.exe /s "$INSTDIR\MzwActivXForOneKeyInstall.ocx"'
SectionEnd

Section -AdditionalIcons
  WriteIniStr "$INSTDIR\${PRODUCT_NAME}.url" "InternetShortcut" "URL" "${PRODUCT_WEB_SITE}"
  CreateShortCut "$SMPROGRAMS\${PRODUCT_NAME}\${PROJECT_NAME}官方网站.lnk" "$INSTDIR\${PRODUCT_NAME}.url"
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

; 卸载模块
Section Uninstall
	Delete "$SMPROGRAMS\${PRODUCT_NAME}\*.*"
	Delete "$DESKTOP\${PRODUCT_NAME}.lnk"
	RMDir /r "$SMPROGRAMS\${PRODUCT_NAME}"
	RMDir /r "$INSTDIR\skin"
	;解除注册
	${If} ${RunningX64}
   ExecWait 'regsvr32.exe /u /s "${COM_DIR_NAME}\MzwIconShell_x64.dll"'
	 ExecWait 'regsvr32.exe /u /s "${COM_DIR_NAME}\MzwIconOverlay_x64.dll"'
	${Else}
   ExecWait 'regsvr32.exe /u /s "${COM_DIR_NAME}\MzwIconShell.dll"'
	 ExecWait 'regsvr32.exe /u /s "${COM_DIR_NAME}\MzwIconOverlay.dll"'
	${EndIf}
	ExecWait 'regsvr32.exe /u /s "$INSTDIR\MzwActivXForOneKeyInstall.ocx"'
	;删除文件
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
	Delete /REBOOTOK "$INSTDIR\拇指玩安卓游戏安装器.url"
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
	;清理注册表
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

;安装时执行函数
Function .onInit
	Push $R0
;CheckInstaller:
	ProcessWork::existsprocess ${PACKAGE_NAME}
	Pop $R0
	IntCmp $R0 0 CheckGuide
	MessageBox MB_OKCANCEL|MB_ICONINFORMATION "检测到“拇指玩安装器”正在运行，安装无法继续。$\r$\n点击“确定”立即结束进程，点击“取消”退出安装。" IDCANCEL Exit
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
	MessageBox MB_OKCANCEL|MB_ICONINFORMATION "检测到“拇指玩连接向导”正在运行，安装无法继续。$\r$\n点击“确定”立即结束进程，点击“取消”退出安装。" IDCANCEL Exit
	Processwork::KillProcess ${GUIDE_NAME}
	Processwork::KillProcess ${DOWNLOAD_NAME}
	Processwork::KillProcess ${UPDATE_NAME}
	Sleep 100
	Goto CheckAdb
CheckDownload:
  ProcessWork::existsprocess ${DOWNLOAD_NAME}
	Pop $R0
	IntCmp $R0 0 CheckUpdate
	MessageBox MB_OKCANCEL|MB_ICONINFORMATION "检测到“拇指玩下载器”正在运行，安装无法继续。$\r$\n点击“确定”立即结束进程，点击“取消”退出安装。" IDCANCEL Exit
	Processwork::KillProcess ${DOWNLOAD_NAME}
	Processwork::KillProcess ${UPDATE_NAME}
	Sleep 100
	Goto CheckAdb
CheckUpdate:
  ProcessWork::existsprocess ${UPDATE_NAME}
	Pop $R0
	IntCmp $R0 0 CheckAdb
	MessageBox MB_OKCANCEL|MB_ICONINFORMATION "检测到“拇指玩在线升级”正在运行，安装无法继续。$\r$\n点击“确定”立即结束进程，点击“取消”退出安装。" IDCANCEL Exit
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

; 卸载时执行函数
Function un.onInit
	MessageBox MB_ICONQUESTION|MB_YESNO|MB_DEFBUTTON2 "你确实要完全移除 $(^Name) ，及其所有的组件？" IDNO Exit
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

; 卸载成功后执行函数
Function un.onUninstSuccess
  HideWindow
  MessageBox MB_ICONINFORMATION|MB_OK "$(^Name) 已成功地从你的计算机移除。"
  ExecShell open "http://app.muzhiwan.com/mzwinstaller/uninstall.html"
FunctionEnd
