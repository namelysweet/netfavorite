inherited frmOpenFrame: TfrmOpenFrame
  Left = 60
  Top = 62
  Caption = #21830#21697#20132#27969#21306
  ClientHeight = 586
  ClientWidth = 1076
  Position = poDesigned
  ExplicitWidth = 1092
  ExplicitHeight = 624
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlBase: TRzPanel
    Width = 1076
    Height = 586
    ExplicitWidth = 1076
    ExplicitHeight = 586
    inherited imgTitleBackground: TImage
      Left = 761
      ExplicitLeft = 761
    end
    inherited imgSetting: TImage
      Left = 992
      Visible = False
      ExplicitLeft = 992
    end
    inherited imgMin: TImage
      Left = 1019
      ExplicitLeft = 1019
    end
    inherited imgClose: TImage
      Left = 1046
      ExplicitLeft = 1046
    end
    object lblUrlAD: TRzURLLabel [5]
      Left = 9
      Top = 563
      Width = 243
      Height = 17
      Hint = #19979#19968#20214' www.xiayijian.com '#36141#29289#28165#21333#20998#20139#31038#21306
      Anchors = [akLeft, akBottom]
      Caption = #19979#19968#20214' www.xiayijian.com '#36141#29289#28165#21333#20998#20139#31038#21306
      Color = clWhite
      Font.Charset = ANSI_CHARSET
      Font.Color = 12419062
      Font.Height = -12
      Font.Name = #24494#36719#38597#40657
      Font.Style = []
      ParentColor = False
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      Transparent = True
      OnMouseMove = lblUrlADMouseMove
      OnMouseLeave = lblUrlADMouseLeave
      BlinkColor = 13805817
      FlyByColor = 11362803
      FlyByEnabled = True
      URL = 'http://www.xiayijian.com/?from=pc'
      UnvisitedColor = 12419062
      VisitedColor = 11097843
    end
    inherited pnlWebBase: TRzPanel
      Width = 1062
      Height = 526
      Margins.Bottom = 25
      ExplicitWidth = 1062
      ExplicitHeight = 526
      inherited pnlWeb: TPanel
        Width = 1058
        Height = 522
        ExplicitWidth = 1058
        ExplicitHeight = 522
        inherited wbBase: TWebBrowser
          ControlData = {
            4C000000021F0000810F00000000000000000000000000000000000000000000
            000000004C000000000000000000000001000000E0D057007335CF11AE690800
            2B2E12620E000000000000004C0000000114020000000000C000000000000046
            8000000000000000000000000000000000000000000000000000000000000000
            00000000000000000100000000000000000000000000000000000000}
        end
        inherited pnlWebPageLoadTip: TPanel
          Width = 1058
          Height = 522
          ExplicitWidth = 1058
          ExplicitHeight = 522
          inherited imgLoading: TImage
            Picture.Data = {
              0954474946496D61676547494638396159000700910200EFA9E1E755CAFFFFFF
              00000021FF0B4E45545343415045322E30030100000021F90405140002002C00
              0000005900070081EFA9E1E755CAFFFFFF000000023D846F82A89BFE60737355
              06C1CD67479A795A484A25679DA9C982EDEAA2D83BC7F05DE39DAC7FFD48DB05
              7D399EE8A82A0A6D4AA20C390432973FA8A3000021F904050A0002002C000000
              000800070081EFA9E1E755CAFFFFFF00000002078C8FA9CBED51000021F90405
              050002002C000000001100070081EFA9E1E755CAFFFFFF0000000215846F12CB
              8BA81A7B27CA40D375D9CA0C780D2832050021F90405040002002C0900000011
              00070081EFA9E1E755CAFFFFFF0000000215846F12CB8BA81A7B27CA40D375D9
              CA0C780D2832050021F90405030002002C120000001100070081EFA9E1E755CA
              FFFFFF0000000215846F12CB8BA81A7B27CA40D375D9CA0C780D2832050021F9
              0405040002002C1B0000001100070081EFA9E1E755CAFFFFFF0000000215846F
              12CB8BA81A7B27CA40D375D9CA0C780D2832050021F90405050002002C240000
              001100070081EFA9E1E755CAFFFFFF0000000215846F12CB8BA81A7B27CA40D3
              75D9CA0C780D2832050021F90405070002002C2D0000001100070081EFA9E1E7
              55CAFFFFFF0000000215846F12CB8BA81A7B27CA40D375D9CA0C780D28320500
              21F904050A0002002C360000001100070081EFA9E1E755CAFFFFFF0000000215
              846F12CB8BA81A7B27CA40D375D9CA0C780D2832050021F904050D0002002C3F
              0000001100070081EFA9E1E755CAFFFFFF0000000215846F12CB8BA81A7B27CA
              40D375D9CA0C780D2832050021F904050F0002002C480000001100070081EFA9
              E1E755CAFFFFFF0000000215846F12CB8BA81A7B27CA40D375D9CA0C780D2832
              050021F90405640002002C510000000800070081EFA9E1E755CAFFFFFF000000
              0207848FA9CBED5000003B}
          end
        end
      end
    end
  end
end
