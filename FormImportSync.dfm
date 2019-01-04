inherited frmImportSync: TfrmImportSync
  Caption = #23548#20837
  ClientHeight = 332
  ClientWidth = 484
  OnActivate = FormActivate
  OnDestroy = FormDestroy
  OnShow = FormShow
  ExplicitWidth = 500
  ExplicitHeight = 370
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlBase: TRzPanel
    Width = 484
    Height = 332
    ExplicitWidth = 484
    ExplicitHeight = 332
    inherited pnlTitleBar: TRzPanel
      Width = 480
      ExplicitWidth = 480
      inherited imgTitleBackground: TImage
        Left = 167
        ExplicitLeft = 140
      end
      inherited lblTitleBase: TLabel
        Width = 96
        Caption = #21516#27493#21040#32593#32476#25910#34255#22841
        ExplicitWidth = 96
      end
      inherited imgMin: TImage
        Left = 423
        ExplicitLeft = 396
      end
      inherited imgClose: TImage
        Left = 452
        ExplicitLeft = 425
      end
    end
    inherited pnlBottom: TRzPanel
      Top = 281
      Width = 480
      ExplicitTop = 281
      ExplicitWidth = 480
      object btnOk: TRzBmpButton
        Left = 230
        Top = 13
        Width = 166
        Height = 26
        Cursor = crHandPoint
        Bitmaps.TransparentColor = clOlive
        Color = clBtnFace
        ShowFocus = False
        Caption = #21516#27493#21830#21697', '#24320#21551#36141#29289#20043#26053'(&S)'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #24494#36719#38597#40657
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnClick = btnOkClick
      end
      object btnSmall: TRzBmpButton
        Left = 408
        Top = 13
        Width = 60
        Height = 26
        Cursor = crHandPoint
        Bitmaps.TransparentColor = clOlive
        Color = clBtnFace
        ShowFocus = False
        Caption = #21462#28040
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #24494#36719#38597#40657
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        Visible = False
        OnClick = btnSmallClick
      end
    end
    object pnlFrameBase: TPanel
      AlignWithMargins = True
      Left = 5
      Top = 39
      Width = 474
      Height = 239
      Align = alClient
      BevelOuter = bvNone
      Color = 15389669
      ParentBackground = False
      TabOrder = 2
      inline FrameSyncStep1: TFrameSync1
        Left = 22
        Top = 21
        Width = 91
        Height = 73
        Color = clWhite
        ParentBackground = False
        ParentColor = False
        TabOrder = 0
        ExplicitLeft = 22
        ExplicitTop = 21
        ExplicitWidth = 91
        ExplicitHeight = 73
        inherited imgWizard: TImage
          Left = 171
          ExplicitLeft = 171
        end
        inherited lblWizard: TLabel
          Top = 100
          ExplicitTop = 100
        end
        inherited lblSettingSyncTip: TLabel
          Top = 165
          ExplicitTop = 165
        end
        inherited chkAutoSync: TRzCheckBox
          Top = 141
          ExplicitTop = 141
        end
      end
      inline FrameSyncStep2: TFrameSync2
        Left = 136
        Top = 21
        Width = 143
        Height = 73
        Color = clWhite
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #24494#36719#38597#40657
        Font.Style = []
        ParentBackground = False
        ParentColor = False
        ParentFont = False
        TabOrder = 1
        ExplicitLeft = 136
        ExplicitTop = 21
        ExplicitWidth = 143
        ExplicitHeight = 73
        inherited PageControlStepSync: TPageControl
          inherited TabSheet1: TTabSheet
            ExplicitLeft = 4
            ExplicitTop = 31
            ExplicitWidth = 454
            ExplicitHeight = 83
          end
          inherited TabSheet2: TTabSheet
            ExplicitLeft = 4
            ExplicitTop = 31
            ExplicitWidth = 454
            ExplicitHeight = 83
          end
          inherited TabSheet3: TTabSheet
            ExplicitLeft = 4
            ExplicitTop = 31
            ExplicitWidth = 454
            ExplicitHeight = 83
          end
        end
      end
    end
  end
end
