; 该脚本使用 HM VNISEdit 脚本编辑器向导产生

; 安装程序初始定义常量
!define PRODUCT_NAME            "淘管家"
!define PRODUCT_INSNAME         "TaoSetup"
!define PRODUCT_PATH            "Xiayijian\Tao"
!define PRODUCT_VERSION         "1.0.0.1"
!define PRODUCT_WEB_SITE        "http://www.xiayijian.com/"
!define PRODUCT_EXENAME         "Tao.exe"
!define PRODUCT_CHANNELID       "1003"
!define PRODUCT_UNINST_KEY      "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}"
!define PRODUCT_UNINST_ROOT_KEY "HKLM"
!define MUI_FINISHPAGE_RUN	"$INSTDIR\Tao.exe"

SetCompressor /SOLID	lzma
SetCompressorDictSize	32

; ------ MUI 现代界面定义 (1.67 版本以上兼容) ------
!include "MUI.nsh"
!include "LogicLib.nsh"

; MUI 预定义常量
!define MUI_ABORTWARNING
!define MUI_ICON	"Install.ico"
!define MUI_UNICON	"Uninstall.ico"

!define MUI_HEADERIMAGE
!define MUI_HEADERIMAGE_RIGHT
!define MUI_HEADERIMAGE_BITMAP		"smalllogo.bmp"
!define MUI_WELCOMEFINISHPAGE_BITMAP	"biglogo.bmp"


; 欢迎页面
!define MUI_PAGE_CUSTOMFUNCTION_SHOW ChangeFont
!insertmacro MUI_PAGE_WELCOME

!define MUI_PAGE_CUSTOMFUNCTION_SHOW ChangeFontSub
!insertmacro MUI_PAGE_DIRECTORY

; 安装过程页面
!define MUI_PAGE_CUSTOMFUNCTION_SHOW ChangeFontSub
!insertmacro MUI_PAGE_INSTFILES

; 安装完成页面
!define MUI_PAGE_CUSTOMFUNCTION_SHOW ChangeFont
!insertmacro MUI_PAGE_FINISH

; 安装卸载过程页面
!insertmacro MUI_UNPAGE_INSTFILES

; 安装界面包含的语言设置
!insertmacro MUI_LANGUAGE "SimpChinese"

; 安装预释放文件
!insertmacro MUI_RESERVEFILE_INSTALLOPTIONS
; ------ MUI 现代界面定义结束 ------


;-----------------------------------------------------------------------
; 版本信息
;-----------------------------------------------------------------------
VIProductVersion "${PRODUCT_VERSION}"

BrandingText ${PRODUCT_NAME}
VIAddVersionKey /LANG=${LANG_SIMPCHINESE} "ProductName"     "${PRODUCT_NAME}${PRODUCT_VERSION}"
VIAddVersionKey /LANG=${LANG_SIMPCHINESE} "FileDescription" "${PRODUCT_NAME}${PRODUCT_VERSION}"
VIAddVersionKey /LANG=${LANG_SIMPCHINESE} "FileVersion"     "${PRODUCT_VERSION}"
VIAddVersionKey /LANG=${LANG_SIMPCHINESE} "LegalCopyright"  "Copyright (C) 2012 www.xiayijian.com All Rights Reserved"
VIAddVersionKey /LANG=${LANG_SIMPCHINESE} "CompanyName"     "下一件时尚购物分享社区"


!include "nsProcess.nsh"
Name         "${PRODUCT_NAME} ${PRODUCT_VERSION}"
OutFile      "${PRODUCT_INSNAME}-${PRODUCT_VERSION}.exe"
InstallDir   "$PROGRAMFILES\${PRODUCT_PATH}"
ShowInstDetails   show
ShowUnInstDetails show
RequestExecutionLevel admin


!include "WinMessages.nsh"





Function .onInit
	loop:
		FindWindow $0 "TfrmLogin"		;窗口名
		${If} $0 == 0
			Goto done
		${EndIf}
		MessageBox MB_OKCANCEL|MB_ICONINFORMATION "请先关闭正在运行的 [${PRODUCT_NAME}]程序！" IDOK +2
			Abort
		
		${nsProcess::FindProcess} "${PRODUCT_EXENAME}" $R0
		StrCmp $R0 0 0 +2
		${nsProcess::KillProcess} "${PRODUCT_EXENAME}" $R0
		${nsProcess::Unload}

		sleep 500
		Goto loop
	done:
	
	ReadRegStr $0 HKEY_CURRENT_USER "Software\Xiayijian\Tao"  "directory"
	IfFileExists "$0\${PRODUCT_EXENAME}" 0 +3
		StrCpy $INSTDIR $0
FunctionEnd

Section "MainSection" SEC01
	SetShellVarContext all
	; 主文件

	SetOutPath $INSTDIR
	File /r "${PRODUCT_PATH}\*"
	CreateShortCut "$INSTDIR\来到下一件.lnk" "http://www.xiayijian.com/?from=pc" "" "$INSTDIR\Application.ico"

	WriteRegStr HKEY_CURRENT_USER "Software\Xiayijian\Tao" "directory" $INSTDIR
	WriteRegStr HKEY_CURRENT_USER "Software\Xiayijian\Tao" "app_id"    ${PRODUCT_CHANNELID}
	WriteRegStr HKEY_CURRENT_USER "Software\Xiayijian\Tao" "version"   ${PRODUCT_VERSION}
SectionEnd



Section -AdditionalIcons
	SetShellVarContext all
	SetOutPath $INSTDIR
	CreateDirectory "$SMPROGRAMS\淘管家"
	CreateShortCut "$SMPROGRAMS\淘管家\淘管家.lnk" "$INSTDIR\${PRODUCT_EXENAME}"
	CreateShortCut "$SMPROGRAMS\淘管家\卸载.lnk"   "$INSTDIR\uninst.exe"
	WriteINIStr    "$SMPROGRAMS\淘管家\访问下一件购物分享.url" "InternetShortcut" "URL" "http://www.xiayijian.com/"
	CreateShortCut "$DESKTOP\淘管家.lnk" "$INSTDIR\${PRODUCT_EXENAME}"
SectionEnd

Section -Post
  WriteUninstaller "$INSTDIR\uninst.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayName" "$(^Name)"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayIcon" "$INSTDIR\${PRODUCT_EXENAME}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "UninstallString" "$INSTDIR\uninst.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayVersion" "${PRODUCT_VERSION}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "URLInfoAbout" "${PRODUCT_WEB_SITE}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "Publisher" "下一件购物分享社区"
SectionEnd



/******************************
 *  以下是安装程序的卸载部分  *
 ******************************/

Function un.GetWindowsVersion
        Push $R0
        Push $R1

        ClearErrors

        ReadRegStr $R0 HKLM \
        "SOFTWARE\Microsoft\Windows NT\CurrentVersion" CurrentVersion
        IfErrors 0 lbl_winnt

        ; we are not NT
        ReadRegStr $R0 HKLM \
        "SOFTWARE\Microsoft\Windows\CurrentVersion" VersionNumber

        StrCpy $R1 $R0 1
        StrCmp $R1 '4' 0 lbl_error

        StrCpy $R1 $R0 3

        StrCmp $R1 '4.0' lbl_win32_95
        StrCmp $R1 '4.9' lbl_win32_ME lbl_win32_98

        lbl_win32_95:
        StrCpy $R0 '95'
        Goto lbl_done

        lbl_win32_98:
        StrCpy $R0 '98'
        Goto lbl_done

        lbl_win32_ME:
        StrCpy $R0 'ME'
        Goto lbl_done

        lbl_winnt:

        StrCpy $R1 $R0 1

        StrCmp $R1 '3' lbl_winnt_x
        StrCmp $R1 '4' lbl_winnt_x

        StrCpy $R1 $R0 3

        StrCmp $R1 '5.0' lbl_winnt_2000
        StrCmp $R1 '5.1' lbl_winnt_XP
        StrCmp $R1 '5.2' lbl_winnt_2003
        StrCmp $R1 '6.0' lbl_winnt_vista
        StrCmp $R1 '6.1' lbl_winnt_Win7 lbl_error

        lbl_winnt_x:
        StrCpy $R0 "NT $R0" 6
        Goto lbl_done

        lbl_winnt_2000:
        Strcpy $R0 '2000'
        Goto lbl_done

        lbl_winnt_XP:
        Strcpy $R0 'XP'
        Goto lbl_done

        lbl_winnt_2003:
        Strcpy $R0 '2003'
        Goto lbl_done

        lbl_winnt_vista:
        Strcpy $R0 'Vista'
        Goto lbl_done

        lbl_winnt_Win7:
        Strcpy $R0 'Win7'
        Goto lbl_done

        lbl_error:
        Strcpy $R0 ''
        lbl_done:

        Pop $R1
        Exch $R0

FunctionEnd

Section Uninstall

 SetShellVarContext all
  Call un.GetWindowsVersion
  Pop $R0
  ReadRegStr $R1 HKCU "Software\Xiayijian\Tao" "Version"
  ReadRegStr $R2 HKCU "Software\Xiayijian\Tao" "app_id"
  ReadRegStr $R3 HKCU "Software\Xiayijian\Tao" "TaoId"

  Delete "$DESKTOP\淘管家.lnk"
  RMDir /r "$SMPROGRAMS\淘管家"
  RMDir /r "$INSTDIR"

  SetAutoClose true
SectionEnd

#-- 根据 NSIS 脚本编辑规则，所有 Function 区段必须放置在 Section 区段之后编写，以避免安装程序出现未可预知的问题。--#
Function un.onInit
  MessageBox MB_ICONQUESTION|MB_YESNO|MB_DEFBUTTON2 "你确实要完全移除 $(^Name) ，及其所有的组件？" IDYES +2
  Abort
	
	loop:
        FindWindow $0 "TfrmLogin"
        ${If} $0 == 0
              Goto done
        ${EndIf}
    	MessageBox MB_OKCANCEL|MB_ICONINFORMATION "请先关闭正在运行的 淘管家程序！" IDOK +2
		Abort

	${nsProcess::FindProcess} "${PRODUCT_EXENAME}" $R0
	StrCmp $R0 0 0 +2
	${nsProcess::KillProcess} "${PRODUCT_EXENAME}" $R0
	${nsProcess::Unload}

	sleep 500

	Goto loop
    done:
	
FunctionEnd

Function un.onUninstSuccess
  HideWindow
  MessageBox MB_ICONINFORMATION|MB_OK "$(^Name) 已成功地从你的计算机移除。"
  StrCpy $0 "http://api.xiayijian.com/system/stat?operation_type=4&app_id=$R2&device_id=$R3"
  ExecShell "open" "iexplore.exe" $0 SW_SHOWMAXIMIZED
  	
FunctionEnd

Function ChangeFont
	GetDlgItem $0 $MUI_HWND 1201
	createFont $1 "微软雅黑" "11" "700"
	SendMessage $0 ${WM_SETFONT} $1 0
	
	GetDlgItem $0 $MUI_HWND 1202
	createFont $1 "微软雅黑" "9" "100"
	SendMessage $0 ${WM_SETFONT} $1 0	

	GetDlgItem $0 $MUI_HWND 1203
	createFont $1 "微软雅黑" "9" "100"
	SendMessage $0 ${WM_SETFONT} $1 0		

FunctionEnd 

Function ChangeFontSub
	FindWindow $0 "#32770" "" $HWNDPARENT 
	GetDlgItem $0 $0 1001
	createFont $1 "微软雅黑" "9" "100"
	SendMessage $0 ${WM_SETFONT} $1 0	

	FindWindow $0 "#32770" "" $HWNDPARENT
	GetDlgItem $0 $0 1006
	createFont $1 "微软雅黑" "9" "100"
	SendMessage $0 ${WM_SETFONT} $1 0	
	
	FindWindow $0 "#32770" "" $HWNDPARENT
	GetDlgItem $0 $0 1008
	createFont $1 "微软雅黑" "9" "100"
	SendMessage $0 ${WM_SETFONT} $1 0		
	
	FindWindow $0 "#32770" "" $HWNDPARENT
	GetDlgItem $0 $0 1019
	createFont $1 "微软雅黑" "8" "100"
	SendMessage $0 ${WM_SETFONT} $1 0
	
	FindWindow $0 "#32770" "" $HWNDPARENT
	GetDlgItem $0 $0 1020
	createFont $1 "微软雅黑" "9" "100"
	SendMessage $0 ${WM_SETFONT} $1 0		
	
	FindWindow $0 "#32770" "" $HWNDPARENT
	GetDlgItem $0 $0 1023
	createFont $1 "微软雅黑" "9" "100"
	SendMessage $0 ${WM_SETFONT} $1 0		
	
	FindWindow $0 "#32770" "" $HWNDPARENT
	GetDlgItem $0 $0 1024
	createFont $1 "微软雅黑" "9" "100"
	SendMessage $0 ${WM_SETFONT} $1 0			
	
	FindWindow $0 "#32770" "" $HWNDPARENT
	GetDlgItem $0 $0 1004
	createFont $1 "微软雅黑" "9" "100"
	SendMessage $0 ${WM_SETFONT} $1 0					
	
	FindWindow $0 "#32770" "" $HWNDPARENT
	GetDlgItem $0 $0 1027
	createFont $1 "微软雅黑" "9" "100"
	SendMessage $0 ${WM_SETFONT} $1 0		
	
	FindWindow $0 "#32770" "" $HWNDPARENT
	GetDlgItem $0 $0 1016
	createFont $1 "微软雅黑" "9" "100"
	SendMessage $0 ${WM_SETFONT} $1 0				
	
FunctionEnd 