program Tao;


{$R *.dres}

uses
  Forms,
  Windows,
  BaseFormMain in 'BaseFormMain.pas' {frmBaseMain},
  FunctionCommon in 'FunctionCommon.pas',
  FormMain in 'FormMain.pas' {frmMain},
  BaseFormCommon in 'BaseFormCommon.pas' {frmBaseCommon},
  IntfDocHostUIHandler in 'IntfDocHostUIHandler.pas',
  NetFavorites_TLB in 'NetFavorites_TLB.pas',
  UExternalContainer in 'UExternalContainer.pas',
  UNulContainer in 'UNulContainer.pas',
  UMyExternal in 'UMyExternal.pas',
  SystemConfig in 'SystemConfig.pas',
  FormLogin in 'FormLogin.pas' {frmLogin},
  FormSetting in 'FormSetting.pas' {frmSetting},
  FormImportSync in 'FormImportSync.pas' {frmImportSync},
  FormAlertMessage in 'FormAlertMessage.pas' {frmAlertMessage},
  FormMessageBox in 'FormMessageBox.pas' {frmMessageBox},
  FormOpenFrame in 'FormOpenFrame.pas' {frmOpenFrame},
  MD5 in 'MD5.pas',
  FrameImportSyncStepOne in 'FrameImportSyncStepOne.pas' {FrameSync1: TFrame},
  FrameImportSyncStepTwo in 'FrameImportSyncStepTwo.pas' {FrameSync2: TFrame},
  HardwareInfo in 'HardwareInfo.pas',
  ThreadSyncFavorites in 'ThreadSyncFavorites.pas',
  ThreadGetUserToken in 'ThreadGetUserToken.pas',
  CheckPrevious in 'CheckPrevious.pas',
  FormCloseTip in 'FormCloseTip.pas' {frmCloseTip},
  SQLite3 in 'SQLite3.pas',
  SQLiteTable3 in 'SQLiteTable3.pas',
  ThreadCheckVersion in 'ThreadCheckVersion.pas',
  FormAbout in 'FormAbout.pas' {frmAbout},
  FormUpdate in 'FormUpdate.pas' {frmUpdate},
  ThreadStatApp in 'ThreadStatApp.pas';

//var Mutex:THandle;

{$R *.tlb}
{$R *.res}
{*******************************************************************************}
begin
  {$IF CompilerVersion >= 21.0}
  {$WEAKLINKRTTI ON}
  {$RTTI EXPLICIT METHODS([]) PROPERTIES([]) FIELDS([])}
  {$IFEND}

  //只允许1个实例
  if not CheckPrevious.RestoreIfRunning(Application.Handle, 1) then
  begin
    Application.Initialize;
    Application.MainFormOnTaskbar := True;
    Application.Title := '淘管家';

    //Application.HelpFile := 'TaoHelp.hlp';
    frmLogin:= TfrmLogin.Create(Application);
    frmLogin.Update;
    try
      frmLogin.ShowModal;
      if GBL_IS_LOGIN then begin
        Application.CreateForm(TfrmMain, frmMain);
        //通过启动参数限制窗体类型
        if (ParamStr(1)='-static') then begin
          //Application.ShowMainForm:=False;
        end;

        Application.Run;
      end;
    finally
      frmLogin.Free;
    end;
  end;

  {Mutex:=CreateMutex(nil, true, 'NetFavorites');
  if GetLastError <> ERROR_ALREADY_EXISTS then begin
    Application.Initialize;
    Application.MainFormOnTaskbar := True;
    Application.Title := '网络收藏夹';

    frmLogin:= TfrmLogin.Create(Application);
    frmLogin.Update;
    try
      frmLogin.ShowModal;
      if GBL_IS_LOGIN then begin
        Application.CreateForm(TfrmMain, frmMain);
        Application.Run;
      end;
    finally
      frmLogin.Free;
    end;

  end else  begin
    //MessageBox(0, '程序已经运行.','注意', 48);

    ReleaseMutex(Mutex);
  end;  }
{*******************************************************************************}
end.
