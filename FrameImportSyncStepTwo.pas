unit FrameImportSyncStepTwo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, RzPrgres, ComCtrls, jpeg, ExtCtrls;

type
  TFrameSync2 = class(TFrame)
    PageControlStepSync: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    lblProcess: TLabel;
    imgDone: TImage;
    TabSheet3: TTabSheet;
    Label1: TLabel;
    lblImportTip: TLabel;
    ProgressBarSync: TRzProgressBar;
    lblLast1: TLabel;
    lblRet1: TLabel;
    imgNotFound: TImage;
    lblNotFoundTitle: TLabel;
    lblNotFoundTip: TLabel;
    lblPercent: TLabel;
    procedure FrameResize(Sender: TObject);
    procedure TabSheet1Show(Sender: TObject);
    procedure TabSheet2Show(Sender: TObject);
    procedure TabSheet3Show(Sender: TObject);
    procedure ProgressBarSyncChange(Sender: TObject; Percent: Integer);

  private
    { Private declarations }
    procedure InitVar();
  public
    { Public declarations }
    procedure SetLastLabelPostion();
  end;

implementation

  uses FunctionCommon, FormImportSync;

{$R *.dfm}

{*******************************************************************************}
procedure TFrameSync2.FrameResize(Sender: TObject);
begin
  FontSmoothing(lblProcess);
  FontSmoothing(lblImportTip);
  FontSmoothing(ProgressBarSync);
  FontSmoothing(lblNotFoundTitle);
  FontSmoothing(lblNotFoundTip);
  FontSmoothing(lblPercent);

  InitVar;
  SetLastLabelPostion;
end;
{*******************************************************************************}
procedure TFrameSync2.InitVar;
begin
  TabSheet1.TabVisible:= False;
  TabSheet2.TabVisible:= False;
  TabSheet3.TabVisible:= False;

  lblProcess.Caption:= '0';
  ProgressBarSync.Percent := 0;
end;

procedure TFrameSync2.ProgressBarSyncChange(Sender: TObject; Percent: Integer);
begin
  lblPercent.Caption:= IntToStr(Percent)+'%';
end;

{*******************************************************************************}
procedure TFrameSync2.SetLastLabelPostion;
begin
  lblProcess.Left:= (TabSheet1.Width - lblProcess.Width ) div 2;
  lblLast1.Left:= lblRet1.Left + lblRet1.Width + 5;

end;
{*******************************************************************************}
procedure TFrameSync2.TabSheet1Show(Sender: TObject);
begin
  lblImportTip.Caption:='正在从浏览器中导入...';
  frmImportSync.btnOk.Visible:=False;
end;
{*******************************************************************************}
procedure TFrameSync2.TabSheet2Show(Sender: TObject);
begin
  SetLastLabelPostion;
  lblImportTip.Caption:='导入已完成';
  ProgressBarSync.Percent:=100;
  frmImportSync.btnOk.Visible:=False;
end;
{*******************************************************************************}
procedure TFrameSync2.TabSheet3Show(Sender: TObject);
begin
  lblImportTip.Caption:='导入已完成';
  ProgressBarSync.Percent:=100;
  frmImportSync.btnOk.Visible:=False;
end;

{*******************************************************************************}
end.

