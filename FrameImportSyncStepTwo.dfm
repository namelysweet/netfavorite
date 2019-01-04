object FrameSync2: TFrameSync2
  Left = 0
  Top = 0
  Width = 482
  Height = 207
  Color = clWhite
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #24494#36719#38597#40657
  Font.Style = []
  ParentBackground = False
  ParentColor = False
  ParentFont = False
  TabOrder = 0
  OnResize = FrameResize
  object lblImportTip: TLabel
    Left = 40
    Top = 135
    Width = 117
    Height = 17
    Caption = #27491#22312#20174#27983#35272#22120#20013#23548#20837'...'
  end
  object ProgressBarSync: TRzProgressBar
    Left = 40
    Top = 165
    Width = 401
    Height = 34
    BarColor = 373028
    BarColorStop = 10284716
    BarStyle = bsGradient
    BorderColor = clWhite
    BorderOuter = fsFlatRounded
    BorderWidth = 1
    FlatColor = clSilver
    Font.Charset = ANSI_CHARSET
    Font.Color = 373028
    Font.Height = -12
    Font.Name = #24494#36719#38597#40657
    Font.Style = [fsBold]
    InteriorOffset = 0
    NumSegments = 5
    ParentFont = False
    PartsComplete = 0
    Percent = 36
    ThemeAware = False
    TotalParts = 0
    OnChange = ProgressBarSyncChange
  end
  object lblPercent: TLabel
    Left = 423
    Top = 135
    Width = 18
    Height = 17
    BiDiMode = bdRightToLeft
    Caption = '0%'
    ParentBiDiMode = False
  end
  object PageControlStepSync: TPageControl
    AlignWithMargins = True
    Left = 8
    Top = 4
    Width = 462
    Height = 118
    ActivePage = TabSheet2
    Style = tsFlatButtons
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'TabSheet1'
      OnShow = TabSheet1Show
      object lblProcess: TLabel
        Left = 188
        Top = -7
        Width = 68
        Height = 81
        Caption = '95'
        Font.Charset = ANSI_CHARSET
        Font.Color = 2591440
        Font.Height = -64
        Font.Name = 'Trebuchet MS'
        Font.Style = []
        ParentFont = False
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'TabSheet2'
      ImageIndex = 1
      OnShow = TabSheet2Show
      object imgDone: TImage
        Left = 52
        Top = 2
        Width = 60
        Height = 58
        AutoSize = True
        Picture.Data = {
          0A544A504547496D616765920D0000FFD8FFE000104A46494600010200006400
          640000FFEC00114475636B7900010004000000640000FFEE000E41646F626500
          64C000000001FFDB008400010101010101010101010101010101010101010101
          0101010101010101010101010101010101010101010102020202020202020202
          0203030303030303030303010101010101010201010202020102020303030303
          0303030303030303030303030303030303030303030303030303030303030303
          030303030303030303030303FFC0001108003A003C03011100021101031101FF
          C4009500010001050101000000000000000000000009030407080A0105010100
          0202030101000000000000000000000809060701030402051000010401030302
          0502040700000000000201030405060012071113081415213122321623174161
          810971F152823363341100020102060103040104030100000000010203110400
          21120506071331220841141516235152335332738324FFDA000C030100021103
          11003F00EFE34C30D30C34C30D30C34C30D30C453F377F7049D8573645A0C021
          5764BC7F87B92AA3331711B02CAED9C7991B02A3B64175C84DE38AC13319E115
          664BE4F2983ACF60D210F63FCA8B9E3BD8C9B5F168E1BCE2DB7968AEEB41F732
          9235F865CCA0834948DC0D123990B2BC7E261317807C6AB7DFB80BEE3C92496D
          392DF0592D695FFE78C03A3CB1E418CF50CEA4EA441185647F22E2437F74F1FF
          00DAAFDDEF43917E37F86FE6FEDFECB23F24F69F6EF72ECFB475FF00D9D8FE3D
          CF4DD3F53BBD9FD4D4AFFDD76AFD23F7EF15DFE1FF001FF79A3C2DF71E3F1F92
          9E2FEEA7D7578E9EFD7E3F7E2327EA1B97EE3FA4792D7F2BF7DF6BAFCABE0F26
          BF1D7C9FDB5FA535D7DBA3C9ECC64BD65F8C570D30C34C30D30C34C311F9E757
          934BC558B2F1AE1B606D721E675EE7AC9D0DCD92312C5E42B91DF9E0F8AEF8F7
          373B4D887B3A38C368EBFB9B31614E2C7C97EE33C2364FD3F8F4A57966E311D6
          EA68D6B6CD556707D56597348A9EE450F2D518445A4A7C79EA7FDC778FDAF7D8
          83718B09469461517370B460847A18A2C9E5AE4C4A474653205D01F0AFC6F5E6
          4CC4B30CAA02BFC6D84CF8EB3633ED2147CB724116E541C5C7BA2AD3B0596C82
          4D97C1C548CA0D28A7A84308BDF1CBA7CF62722FCF6F71D7876DB203206155B9
          9C5192DF3C8A0043CFEBEC2B1903CC19647F7EF6B0E05B0FE1367929CAF708C8
          420D1ADE135569F2CC3920A43E9EF0CE09F11569F4F4CBE9BB7B87BBD376FD89
          B7774E9B7B7F2ED6DFA76FCB67D3AB47D229A6834D294C56EEA35D553AAB5AE2
          F75CE38C5BC69716601B9124C794DB6FC98AE3919E6DF00950A43B1264633688
          84644496C9B4E82AEE6DC0512445454D75433C370A5E075740CCA4A90406462A
          EA48AFB9581561EAAC083420E3B2586681824E8C8E5558060412ACA195803F46
          52194FA15208C8E2E35DB8EBC34C318679E79A31EE09E3AB6CE2F1065CA04F6F
          C728D1D469FC832292D3A502B5B35EAAD471ED93D25D4425662B46682648205A
          F7B3BB0F6AEB2E253F24DCA8F38F65BC35A34F3B03A2307E8B91691A87446ACC
          03300A73AEBAE07B9F62727878FEDF5484FBE7969510C2A46B723EAD9858D72D
          5232825412C39FBC531CE45F29F9A4A33931DB1CA735B47ADF24BE90D38E41A1
          A867B693AD64877042253D1C016D88CC6F01E82C45695089B15AB2D8F67E5BDD
          BD89E06769B7CDCA732CF3104A4310A6B918568B1429A5234A819470A66C8316
          51BCEEBC5FA7B817995162D9B6F84470C2080F2C86BA23534F7492BD5E47A139
          C933E418E3A27E32E3CC738CB0EA0C3716887128F1E8030A08BDD165CB33327E
          75B58988342EDA5BCC327DF24001DE7B4444511356D9C478AED1C278EDAF18D8
          9346DD6B1E915A6A7639BC8E4000BC8E4BB9000D44D001402AF394F25DD7986F
          D73C8B797D77F7326A34AE951E891A0249088A02A8249A01524D49C87AC8F1F8
          18D2FF002EF9FB2CE34C52D31CE2CC7722BECE24D5489B71915450595AD2F1AE
          3E31DC7A55EDC4F8D1244062E0A2091C665D2418EDA7AA7FA368C8488F3DF3DA
          5BE70ED8E6DA384DA5DDD7247819E5B88A0925876F83492D34AEAAC8B2E904C6
          8C4045FE69688235977BF4A75BECDCAF798774E61756B6DC7D26558E092648E5
          BE9AA02C3123307316AA0919455DBF863AB1768B43FC05F232461F9CC9E2DCC6
          D1E7B1DE46B65974B6160FABC55B9F4C51691644978FBC4CE5C8231DC225717D
          68B0488286F1AC65F8BBDB72EC1C95F85721999B69DDE7D5148E6BE3BD7CBDCC
          4D697592313A8F9844680348D8913F243ABA2DF38F272FD8A155DD36B874CA88
          29E4B35CF250295B6CDD40A0F1190665635C4DFA2F5445FF0034FE4BFCD35641
          8AFF00C585BDB5650D5D95DDCCE8D595151065D9DA58CC74598B06BE0B072664
          B92E92A0B6C4761B23255F9226BC97F7D67B5D94DB96E12243616F1349248E68
          A8880B3331FA0550493FD063D3656577B8DE45B7D8C6D2DECF22C71A28AB3BB9
          0AAAA3EA589000FEB8E73BC9CE79BBF23B9392657B13FF0016AA7DCA1E3DC740
          1D7A59469321B6CAC1D84CA16FBEC964B6D9B80D8A9002331D15CED21954AF72
          F676E3DB9CCBEE2D165FC240C61B180025B4B301ACA0AD66B860A582824011C5
          56F1863685D4DD73B7F56F12F05CB47F989944D7B39202EA55274063E90C0A58
          2924024BC945D6544BCF885E38C7E0EC144EEA2B2E720E54D449F9A4CDCDBEB5
          A809DEAEC3E13EDEF67D3536FDF2CDA52491348BF50DA6DA419F9D05D470F587
          16136E28A797DFAABDD3541F10F54B6422A34C75AC85490F2963A99163D3083B
          BFB4A5EC6E4862B0761C5AC5992D9731E43E8F70C0E75929440C0148C28D2AED
          2577235BE71A4F0D30C507E3B721B369C143070081C6DCFAD975B2454369E68B
          AB6E34E0AA8922A7C457A6BE5D124431C80346C08208A820E44107D41FA8C7D2
          3B230742438350464411E841FA118E75BCBCE057B81F949F0A761D6B05CB4E55
          FE132055CE905B07C3DD31C578910BD4E392DF010FA9C2586EC73235322E9531
          DF5D5F275873664DBD4AF1ABF2D3D9B0AFB0547920AFAEA819805CC9F1344CCC
          58B52CFBA4FB1D3B1B87ABDF303C86C82C374B97BCD0F8E7A7F6CCA093901E45
          9542850B5971F0DFC830E71E33659BB968E72061630E972E13E88ED98134634F
          94008AAA28DDB11C86474DBB6732EF4006C9BDD3BFE3EF6A2F6570D58F717AF2
          ADB8245755F59050F8AE47FDA1487F4A4CB251550A5615F79F5A375EF2C692C1
          29C6AFCB4B6D4F48CD7F92DFFF0022468F5AC4C956660F4D2AFEE07E4C25F584
          8E08C26789D353CB03E44B288F6E0B2BB86E8BB1F156CDA2ED944A292DA39351
          5494A708B4A80B18D1C8E9F29FB8C6E774FD65C725076FB7901BF914D449321A
          ADB0232D30B0D537AD660A9ED30B06DF9F1ABAA0EDD6CBD89BFC645F4E87ECA3
          61FE389850DC1073D52A9D317A52225FDC255D377E0078D8536446E76CCABC15
          961E79AE33AE98DA382ECC8EE1479F9ABEC1A76FB55AE21315BBF7294A437D04
          7B4C3A5ECF8ABD3BF752AF67F24881B78D88DBE3615D4E0957BA2A72A21AA415
          A9D61E5014A44E7C9F25BB5FEDE36EB8D8252277506FA453FF00142032DB03EB
          571479A94F6158C921E55130AD362D02027F0F9AAAAAA92AFC5488955548957E
          2AABF155D4F9C422C54D30C34C30D30C604F23F84EB39DB8C2EB0E91D98D76DF
          4B7C42D5E5211ABCA2134E8D7B8F3800E90D7D8B6E9C497D01C5461E5311EE00
          126B2EDCEB9B3ECEE1771C7A5D29B92FF2DACA72F1DC203A092013A1C131C993
          7B1CB28D6AA46C5EADE7D77D75CBA0DF62D4DB7B7F15CC633F240E46BA0247BD
          08124798F7A804E92C0F3DB86E77C93C0B9A5EC8C6E74CC4B2E851321C2EF187
          5A6C9F8AAEAB902C61C98EE21B5EAEAECA303ED2AEE46E5466CFA120F45AA6E3
          FC9B97F58721B99768924B1DFA349ED2652012B5AA488CA6A35472287539E992
          356CC0A1B31DF38EF15EC6D8ADE2DD634BDD924786EA2209A3528E8CA450E991
          18A37A6A8DD97226A326F8B9C0763E40F23762CD6606138F391EE73CB81574A4
          3F1DF7CD62D14493D7AFBD64B25B36C0C8D15A685E7FEA26D00F34E93EACBDED
          7E5E20BAD638EDA9596F65CEA549256156FF006CE430049AAA0924CCA056C47B
          83B2AD3ACB8A99EDB41DFAE418ACE2CA8180159597FD508209005198A479072C
          BD155354C1A6AF855D5D0E357C1810E2D7D7D7C36418875D5B05918F06BA1B2D
          836DB3121470406C44451113E49D756D567696BB7DA4561631A4565046B1C688
          02AA2200AA8AA320AAA00006400A62AFEEAEAE6FAEA4BDBC91E5BB9A46777624
          B3BB12CCCC4E65989249399271F5B5E8C79F0D30C34C30D30C78A88A8A8BF145
          4E8BFE0BA6188AEF387C4CC833BCBF1BE46E2EA572C6F327B2AAC5334AD8E8A8
          DA497B642A3CCA49201A4784D476D22D93E4A80C834C3BB3A2BCE6A137C93E8B
          DD7936FF0067CBF855B99771BD9A3B6BB8D7D031A24374D97B502811DC393455
          589F4FF91B1303E3EF73EDBC7764BAE2BCBE7115859C525C5AC8DEA5455A5B65
          CFDCE589920502AC5A44AFF8D71BC9C0FC358F709F1FD361346832161294EBBB
          A564597F24C92534DB76776F8211EC6491A166236A46ACC46C014CD7EA5935D6
          7D7DB575A712B7E33B651E45F7CF3528D3CEC0792423E8320B1A924A46A8A4B1
          058C77EC3E75B9F61F279F90EE3548DBD90C55A88615274460FD4E659D801AA4
          666A004019BB59FE307C34C30D30C34C30D30C34C3149EFB4BECFF008DCFBBE5
          F24FBBFEAFF57F4D30C541FB53EDFF006FDBFD34C31EE9861A61869861A618FF
          D9}
        Transparent = True
      end
      object Label1: TLabel
        Left = 168
        Top = 27
        Width = 36
        Height = 17
        Caption = #20849#22788#29702
      end
      object lblLast1: TLabel
        Left = 267
        Top = 27
        Width = 60
        Height = 17
        Caption = #20010#28120#23453#38142#25509
      end
      object lblRet1: TLabel
        Left = 212
        Top = 27
        Width = 7
        Height = 17
        Caption = '0'
        Font.Charset = ANSI_CHARSET
        Font.Color = 2591440
        Font.Height = -12
        Font.Name = #24494#36719#38597#40657
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'TabSheet3'
      ImageIndex = 2
      OnShow = TabSheet3Show
      object imgNotFound: TImage
        Left = 52
        Top = 2
        Width = 80
        Height = 78
        AutoSize = True
        Picture.Data = {
          0A544A504547496D6167650F100000FFD8FFE000104A46494600010200006400
          640000FFEC00114475636B7900010004000000500000FFEE000E41646F626500
          64C000000001FFDB008400020202020202020202020302020203040302020304
          0504040404040506050505050505060607070807070609090A0A09090C0C0C0C
          0C0C0C0C0C0C0C0C0C0C0C01030303050405090606090D0B090B0D0F0E0E0E0E
          0F0F0C0C0C0C0C0F0F0C0C0C0C0C0C0F0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C
          0C0C0C0C0C0C0C0C0C0C0C0CFFC0001108004E005003011100021101031101FF
          C400A00000020301010101010000000000000000050600040703020801090100
          0203010100000000000000000000000304000205010610000202010302040404
          040407000000000102030405001106211231415113612214157132420781A182
          23B1C15272336324342516171100020102040207070304030100000000010200
          110321311204415161718191A1D105F0B1C122321314425282E1723315629223
          25FFDA000C03010002110311003F00FEFE6A4926A4926A492864F274B0F42CE4
          B213082A555EE95CF53E815479924EC0799D5910B9A0CE16CD96BCE11054998B
          65B3F93CB4D33640DAAD0C6AB20C041685086A4121DA393276FC43C80EE2253B
          FF001D3E96D5461DF4AD7FB47C67A0B1B5B7680D3427F711A8B1E22DAF21FBBE
          113DA4828C9F54DC5F1F4EB22FBB0E4ABE42D51B4EBFEAAED6E4491CFC7DB20E
          8F4270D47AA808EDA4D000B8D3F7189E455597F969040EF9A3F1EE7A9456A56C
          BD9B393C5E42233E1F3BED774A91464ACB1DC54EA1A22002C01DC1EE3D3AE95B
          BB6AD4AE04663CBAE646EBD30BD4DB01581A32D70A9C8AD781E5D935D8A58A78
          A39E0916686650F14A8432B2B0DC3291D0823C0E9222930994A9A1CC4E9AE4E4
          9A9249A9249A924FC2400493B01D493A924C1F93F237C8C90E62288DBAE965AA
          F05C5052DF576D7E57BEC9FA9632768C7AFA75D68D9B5A7E5FFB1E43979CF4DB
          3DA0B60DB268695B87F6AF04EB3FAA55E2DC53217E578DEE19EC4361A6CCE69F
          6963AF65BABC7555B7496C0DF6795B709E0BD46BB7AF05E1D43A3A7A3A38CBEF
          77C882B4A0228AB91239B710BC9467C66D18BE3B87C3866A74D4DA93FEE32136
          F2D9949F1324CFBBB6FF008EDE9A45EEB3E67CA79EBDBBB97BEA38721801D432
          98AE5E9D839FB70E225352CD6CF5FB18F950EE3DE6C725892323C3B5DD0061E8
          4F4D3E8C340D5C87BE93D158B8BF641B82A0A283D5ACA83D601C2693C06CAC98
          FBF5221D952B588E7C6C3D7FB55AF578ADA4637EBB2195947C06DE5A53723107
          8F1EB069323D4D28EAC732083D2549527B691F34BCCC9352489F6B2196CD642D
          E2B036131F4F1CE22CAE74A095C4DB06305746F94B2823B99B7037DB6DF470AA
          8016C49C879C7D2D5BB281EE8A93885CB0E6DC69C80CE7B1C2B092215BED7B2E
          EDBFB92DDBB625EEDFC4140EA807C0281AE7DF6E141D404E7FB0BA0FCB45EA50
          3E15F194323FB71C52D50B95AA622B51B33C2E95EE2A926272365703BBAEC757
          5DD5C04126B0B6BD5B70AE0B31201CB9CA189FDBF8A4226E582A65A4AD5E2A58
          CA5023A56AD0423F4863B9663D493AB3EE7F654713097FD508C2C556A4924E64
          9F8087D783F168C76C38BFA75F1EC8269A21BFAEC9228DFE3A17E43F38B1F52D
          C1CDABD601F789E8F0FC48FF0083672B5B71F37B794BA37FC7798EA7DF6E8EE1
          E539F9F738853FC57CA665C7B8966AEDFAF53271647151E2A5C8D9BD98F747BB
          66D5C2215F6A46EF2E3D941BB1F8FC34DDDBCA05450D698740FEB36375BEB488
          590AB6A0A02D300171C4614F98E51EA870BBB84EFF00B2729B95D5D62478AE43
          5ED2B2C1188A353B246C02A8D80561A5DAF87FA9476544CDBBEA0B7BFC96C1CF
          22573353C4CE1272FCCE17275F0FC8702F69ECA3C9532789DE449D63EAE4577F
          9C1453BB28663E6011AE8B0AEBA94F61F3961B1B57AD9B969E94CC3614FE5963
          C328E98CCB63B31585BC65B4B706FDAC5770C8C3C55D0ECCAC3CC30074BBA143
          42267DEB0F65B4B8A1F6EF8138581F6089C8FEF4B72F35A63E2D2FD5CC1C9FE2
          344BFF005F60F7463D43FCDD145A756914863335AF5CC5DEAB8CBBF6EBF3C456
          ADDDB7F6DBD7FCB7F2F1D51080C0915101B7744B819C5541C44C69798F39E112
          256E638C397C677048F2D0EDB9F4DA4002B1E9E0E158FAE9EFB16AF62868794D
          F3B0DA6F4576EDA5B91F2F2A89B1613354790636BE571CECF56CF77677A95605
          4956041F304691B96CA350CC1DC6DDF6EE51F310B6A9013C4922448D24AEB1C6
          80B3C8C4050078924F86A0159D009341331CF7EEB71FC639A98A57E419027B52
          2ADD22EEDF600CBB1DFF00A0369BB7B376C4E026C6DBD12F5C1A9FE45E9CFBBC
          E91CB8CE4B2796C457BD96C5B622E4C5BBA9B6FBF683F2B6CC011B8F23A05D45
          56A29A8886F2CDBB570AA36A1CE0DE5A1567E253AFCB3C79EAE9130F1ED96395
          645FC0AEFBEAF6726EA85D8E22E8E1A0F811495F95D4870D14BCC31EBF4D91C6
          F63E4047F2ADCADDC04914A3C18F692558F5076F2D76C9D7F21C8F8197D939BC
          46DDF156CBFE27811F112EF140D0FF00EC541CFCD4B376CAAEDB6C964ADA4FE5
          36AB7B1D27A0786107BEC7EDB0E283C3E5F8466B32BC15E79A385AC3C31B3A57
          4FCCE5412157E27C0684054C4D1753004D27CFA98ECD73CCA264B9919B0D83AA
          E7E8F0A0323B007A80AC011BFEA72373E0BB79696A5B2B44C4F39EA0DDB5B1B7
          A36F46739B7B780EF9BC6322C7D7A5055C5C51C14ABA848618C6CAA07C3D7D49
          F1D673924D4E73CD5E67662CE6A4C21AAC145EE5186A7C870D6B1176D3548ECF
          6959908DD5D0865241E8C371D468B66E146D4235B2DC36DEE8B8A2B4985F1EB8
          DFB63997A5C8715058A175CFD2F238230F205F0DD1F6DCAFFA93F30F1EBD37D0
          BABF90B5538F29E93756FF00D95AD56988619A93ED8F2394FA3AB59AF72BC36A
          ACC962B5841241321DD59586E083ACB2083433C9BA1425585088A99B3F57CA38
          8E381EE5ACF6B29613D04317B3193FD737F2D1ADE08C7A87B7747B6DF258BAFC
          E8A3B4D4F809DB989F7B1D471817BDB3393A550AFF00CB132CD2F8FA471B6FAE
          58C093C8195D860E5FF6AB1F0A0F12204C55F14FF71B9562A77D865E0A96E97A
          774102C7227C491F37E034475AD953CAB18BF6B5ECADB8FD2483DA6A268FA566
          4C1F6F1956E307954F78E9DC3565722152F32653B55A90D38CC7082013B9DF5C
          2C4CABDC2E6A65AD72520AC8E316FF006B7B86365E9F0D5D5F4C35ABDA2523C6
          F1F669CD43290A646ACE4168251B80478107C411EA356FBA41A8C217F2DD5832
          1A110CD3A75B1F560A54A15AF56B208E0853C154780D0D98B1A98BDCB8D718B3
          1A933237C7B734FDC0CC2CEF21E3D82AF1D1B888CC82C48A4B9849520EC1C92D
          D7F48F869DD5F6AD0FDC719BA2EFE1ECD29F5B124740CABDD97599DF88CB2E57
          2D8EA8D3496E8715FB8CB4ED48C599D249DEAD4EF3E644492EDFC35CBC34A93C
          5A9E67E129BE516ADB3528D734D47500CDE25612CDE1E5C8F2CB6952614B27F6
          BA97F0F7CF50962A4F346CAC07528CB30561E87CF55B6FA6DE388A907B69E505
          B7DC0B7B71A855751561D0C01EFC2A21AAFC9EF56B1529F23C14F8892DCA95E1
          C8C4E9629BCCE7655EF53DC9DE7F2F72E866D0209535F7C59B668C0B5A70D4C6
          99353DC69D06345EB0F4E95BB71D77B6F5A17952AC7B77C85149ED5DFCCEDB0D
          054548113B681D82934A9CE270FDC9E222B51B0F931DD72259648224699EBA9D
          BBBDF1186ECED2763BFF00868FF8B72A4523FF00EA373A88D391EAAF5573856D
          732E2B4A4AF159CFD347B40187B650E3B5BC198AEE141F56D86A82C5C3903029
          E9FB87048438744E71737E2B3E5570B0E66096FB90B1AA12D1B39FD02503B0B7
          C37F878EBA76F702EAA613ADE9DB85B7F70A1D3E3DD9C669A686BC4F34F2A410
          C63BA496460AAA3D493B01A1015CA26AA58D00A989F91E61525FFC7718921E41
          9BB208AF156712410EFD3DDB12A12AAABE9BEE7C068CB608C5F01ED947ED6C18
          7CF7AA8833AE04F428E260DB901E23C65311426FA8E419E99A18ED1E8D35CB3D
          66B2DB7808C6EDBF90006AEA7EEBEA390F70E10D6DBF2EFF00DC6144415A7251
          92F6E52C7EDE6361A9889AFC2BB479397FE89986CDF47594415C9FF784327F5E
          B9B9725A9CBDE73F294F55BC5EE053FA463FDC716EECBB21CCE626E5B9A8E531
          1663AB98C5FBA2B99C3341345301EE43285EA158AA90C3AA91D06876DC0A86C8
          C5F6D7D5014B82A8D4AD330464478E1C62A436B3BCDA2AF5AC62A0C363F1F925
          FBBCA6C89E56968CC18C31A2A2F6EECA3AB1F0F0DF46216CE20D491861CE3AC9
          6B64490C598AFCB85051866719A6E9498F28418BC6561656B63AAD7177737047
          0A2097BBA1F73603BB7DFCF562EC733942B5EB8D4AB134CB1CBAA53A9C6F8FD0
          86CC14F0D4E086E022D46B0A6D229FD2DB8EA3E1E1AB35D76C4932F737779C82
          CE49196394E9F60C27D24344626A2D382559E1ACB12AA2C8877570001D7E3AE7
          DC6AD6A6B39F9577516D46A452B5E102F37AD258C5D3714E4C854A592AB6B274
          625F71A5AD13EEE047FAF6E87B7CF6D136E68C71A606918F4E70B708AD095201
          E44E58F0EB94A3E6BC5A00B57075E6C85D9C168715429C89237681D5BB911540
          F324F4D58D8738B603993087D3B70DF35C2001C588F3301E56965A768EC655D2
          2E4DC989C56131F0B77A636A38EEB4EADD3BA411025DC79EC074D11194603E91
          89E93C23362E5B5C13FC69F3313FADBF48E815C876CD52B5786A5782A578C455
          EB46B14112F82A200AA07E00693249353315DCBB163999DB5C958A590C5E4F1F
          919F39C7824F25B0BF77C24CFD91D92802ACB13F511CA1476F5F9586DBEDB6FA
          32BAB0D2DD8797F48F5ABD6EE20B7770A7D2C387411C57C44E75B9D71E7B0F47
          2364E0B2711027C7E487B0CA48DC6CE498D81F221BAEBA76EF4A8C4744EBFA6D
          E03520D4BCD71FEBE11A20BB4ED00D56DC3655BAA98A45707CFF00493A095233
          89B5B65FA8112CEB92926A4907E4F2B8EC35592EE4EE474EB4609324876DFE0A
          3C58FC075D5910B9A010B66C3DE6D282A666384E534F2395C87214AF632D92B6
          8B4F0D86A51995EB5356DC34F2748A2695FE66EE6E8001E5A6EE592AA1721992
          79F4754D8DCEC9ADDB5B4485518B31C2ADD03334180A0C63A62319919B252F20
          CEA4515F687E9F1D8E89CC894E027B9C17D80691C81DCC079003A680EE00D2B9
          7BE67DFBC8105AB55D35A9270D47AB801C2356831293524935248859FA98FB39
          867AF97AF8CCB45497EE51DBAFF51525AACEDED7BC1CA20756EE287BC36DBF42
          3C18B6C42E22A2B873ACD3DABBADAC54B2D70A1A306E34CCD294AE14CB8C55C6
          55FDADA92E423C8E4F1395C99911AF599A28A180310765AE8A0441475DFB0B1D
          FF0031276D1DCDF34A0207B671DBCFBF60A515957800493FCB8F7D3A042A7FF9
          4EFF00DAFB776F9FD2F7F66FF1F6BE5DFF009EA9FF00BF4C0FFF00438EAEDA7C
          650BB1FEDACB14B1579EE559248D963B34064996362080DB441A32C3C7E61E9B
          F4D594DE19D3B69096CEF8104807A1B47C7189466E3A69DAC54F4F18B7DA131C
          9CAEFCB3EEB16C77952ADC533FBBDBE08836EEF06DB6D1E8F5AD4D390F318526
          8E9BDA8382DA6BF40033E5A97E5D35E278709F43E2C5118EA431851B1E214FA4
          31FE531F68EDFE5ACC7AD4D739E56F6BD675FD55C65FD560A4D4927FFFD9}
        Transparent = True
      end
      object lblNotFoundTitle: TLabel
        Left = 176
        Top = 21
        Width = 64
        Height = 22
        Caption = #23545#19981#36215#65281
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = #24494#36719#38597#40657
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblNotFoundTip: TLabel
        Left = 176
        Top = 49
        Width = 208
        Height = 17
        Caption = #22312#24744#30340#27983#35272#22120#25910#34255#22841#37324#27809#26377#26816#27979#21040#21830#21697'!'
        Font.Charset = ANSI_CHARSET
        Font.Color = clGray
        Font.Height = -12
        Font.Name = #24494#36719#38597#40657
        Font.Style = []
        ParentFont = False
      end
    end
  end
end
