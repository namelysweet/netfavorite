unit FrameImportSyncStepOne;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, RzButton, RzRadChk, StdCtrls, pngimage, ExtCtrls;

type
  TFrameSync1 = class(TFrame)
    imgWizard: TImage;
    lblWizard: TLabel;
    chkAutoSync: TRzCheckBox;
    lblSettingSyncTip: TLabel;
    procedure FrameResize(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

  uses FunctionCommon;

{$R *.dfm}

procedure TFrameSync1.FrameResize(Sender: TObject);
begin
  FontSmoothing(lblWizard);
  FontSmoothing(lblSettingSyncTip);
  FontSmoothing(chkAutoSync);
end;
{*******************************************************************************}
end.
