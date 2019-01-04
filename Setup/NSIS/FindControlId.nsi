name 'Find Control IDs'
outfile 'findctlID_MUI.exe'
showinstdetails show
InstallDir '$EXEDIR'

var header

!include mui.nsh
; 许可协议页面
!define MUI_PAGE_CUSTOMFUNCTION_PRE lic_pre
!define MUI_PAGE_CUSTOMFUNCTION_SHOW lic_show
!insertmacro MUI_PAGE_LICENSE 'License.txt'
; 组件选择页面
!define MUI_PAGE_CUSTOMFUNCTION_SHOW comp_show
!insertmacro MUI_PAGE_COMPONENTS
; 安装目录选择页面
!define MUI_PAGE_CUSTOMFUNCTION_SHOW dir_show
!insertmacro MUI_PAGE_DIRECTORY
;开始菜单页面
!define MUI_PAGE_CUSTOMFUNCTION_SHOW smn_show
!insertmacro MUI_PAGE_STARTMENU app $R9
; 安装过程页面
!define MUI_PAGE_CUSTOMFUNCTION_SHOW inst_show
!insertmacro MUI_PAGE_INSTFILES

!insertmacro MUI_LANGUAGE "English"

section
sectionend
;协议页面ID
function lic_show
strcpy $header "LICENSE PAGE CONTROLS"
call findIDs
functionend
;选择页面ID
function comp_show
strcpy $header "COMPONENTS PAGE CONTROLS"
call findIDs
functionend
;安装页面ID
function dir_show
strcpy $header "DIRECTORY PAGE CONTROLS"
call findIDs
functionend
;开始页面ID
function smn_show
strcpy $header "START MENU PAGE CONTROLS"
call findIDs
functionend
;过程页面ID
function inst_show
strcpy $header "INSTALL FILES PAGE CONTROLS"
call findIDs
functionend

function lic_pre
fileopen $5 '$EXEDIR\ids.txt' a
fileseek $5 '' END
filewrite $5 "PARENT DIALOG CONTROLS$\r$\n"
strcpy $0 0
loop:
strcmp $0 '2000' end
GetDlgItem $R0 $HWNDPARENT $0
strcmp $R0 0 +3
fileseek $5 '' END
filewrite $5 "Control ID == $0$\r$\n"
intop $0 $0 + 1
goto loop
end:
filewrite $5 "$\r$\n"
fileclose $5
functionend

function findIDs
fileopen $5 '$EXEDIR\ids.txt' a
fileseek $5 '' END
filewrite $5 "$header$\r$\n"
strcpy $0 0
loop:
strcmp $0 '2000' end
FindWindow $R5 "#32770" "" $HWNDPARENT
GetDlgItem $R0 $R5 $0
strcmp $R0 0 +3
fileseek $5 '' END
filewrite $5 "Control ID == $0$\r$\n"
intop $0 $0 + 1
goto loop
end:
filewrite $5 "$\r$\n"
fileclose $5
functionend

function .onInit
IfFileExists '$EXEDIR\ids.txt' 0 +2
delete '$EXEDIR\ids.txt'
functionend