inherited frmUpdate: TfrmUpdate
  Left = 320
  Top = 145
  Caption = #36719#20214#21319#32423
  ClientHeight = 383
  ClientWidth = 564
  Position = poDesigned
  OnActivate = FormActivate
  OnShow = FormShow
  ExplicitWidth = 580
  ExplicitHeight = 421
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlBase: TRzPanel
    Width = 564
    Height = 383
    ExplicitWidth = 564
    ExplicitHeight = 383
    object lblAppName: TLabel [0]
      Left = 32
      Top = 53
      Width = 98
      Height = 19
      Caption = #26377#26032#30340#29256#26412#21457#24067
      Color = clWhite
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = #24494#36719#38597#40657
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
    object lblUpdateTip: TLabel [1]
      Left = 32
      Top = 266
      Width = 147
      Height = 20
      Anchors = [akLeft, akBottom]
      Caption = #26159#21542#29616#22312#21319#32423#21040#26368#26032#29256'?'
      Color = clWhite
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -14
      Font.Name = #24494#36719#38597#40657
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    inherited pnlTitleBar: TRzPanel
      Width = 560
      ExplicitWidth = 560
      inherited imgTitleBackground: TImage
        Left = 247
        ExplicitLeft = 196
      end
      inherited lblTitleBase: TLabel
        Width = 64
        Caption = #26377#26032#30340#29256#26412'!'
        ExplicitWidth = 64
      end
      inherited imgMin: TImage
        Left = 503
        Visible = False
        ExplicitLeft = 452
      end
      inherited imgClose: TImage
        Left = 532
        ExplicitLeft = 481
      end
    end
    inherited pnlBottom: TRzPanel
      Top = 332
      Width = 560
      ExplicitTop = 332
      ExplicitWidth = 560
      object btnOk: TRzBmpButton
        Left = 202
        Top = 13
        Width = 166
        Height = 26
        Cursor = crHandPoint
        Bitmaps.TransparentColor = clOlive
        Color = clBtnFace
        ShowFocus = False
        Anchors = [akTop, akRight]
        Caption = #31435#21051#21319#32423'(&U)...'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #24494#36719#38597#40657
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnClick = btnOkClick
      end
      object btnCancel: TRzBmpButton
        Left = 384
        Top = 13
        Width = 166
        Height = 26
        Cursor = crHandPoint
        Bitmaps.TransparentColor = clOlive
        Color = clBtnFace
        ShowFocus = False
        Anchors = [akTop, akRight]
        Caption = #31245#20505#20877#35828'(&C)...'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = #24494#36719#38597#40657
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        OnClick = btnCancelClick
      end
    end
    object memoUpdateInfo: TRzMemo
      Left = 32
      Top = 94
      Width = 502
      Height = 158
      Anchors = [akLeft, akTop, akRight, akBottom]
      Color = clWhite
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = #24494#36719#38597#40657
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 2
      FrameColor = 13465037
      FrameHotColor = 15386346
      FrameHotStyle = fsFlat
      FrameHotTrack = True
      FrameVisible = True
      FramingPreference = fpCustomFraming
      ReadOnlyColor = clWhite
    end
  end
end
