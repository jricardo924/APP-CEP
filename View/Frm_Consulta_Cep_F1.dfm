﻿object Form_Consulta_Cep_F1: TForm_Consulta_Cep_F1
  Left = 329
  Top = 123
  BorderStyle = bsDialog
  Caption = 'App - Consulta Cep - WS'
  ClientHeight = 527
  ClientWidth = 924
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object LblRetornoServico: TLabel
    Left = 657
    Top = 55
    Width = 158
    Height = 13
    Caption = 'Demonstrativo de Execu'#231#227'o'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbldt_logradouro: TLabel
    Left = 13
    Top = 176
    Width = 109
    Height = 13
    Caption = 'Logradouro / Nome'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbled_complemento: TLabel
    Left = 43
    Top = 213
    Width = 79
    Height = 13
    Caption = 'Complemento'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbled_Siafi: TLabel
    Left = 416
    Top = 213
    Width = 31
    Height = 13
    Caption = 'SIAFI'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbled_bairro: TLabel
    Left = 34
    Top = 248
    Width = 88
    Height = 13
    Caption = 'Bairro / Distrito'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbled_ibge: TLabel
    Left = 421
    Top = 248
    Width = 26
    Height = 13
    Caption = 'IBGE'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbled_localidade: TLabel
    Left = 12
    Top = 280
    Width = 110
    Height = 13
    Caption = 'Cidade / Localidade'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbled_uf: TLabel
    Left = 433
    Top = 280
    Width = 14
    Height = 13
    Caption = 'UF'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbled_cep: TLabel
    Left = 427
    Top = 176
    Width = 20
    Height = 13
    Caption = 'CEP'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 924
    Height = 49
    Align = alTop
    BevelOuter = bvNone
    Color = 9783808
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentBackground = False
    ParentFont = False
    TabOrder = 0
    object lblCebecalho: TLabel
      Left = 27
      Top = 9
      Width = 264
      Height = 24
      Caption = 'Consulta - CEP / Endere'#231'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -20
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object PageControl: TPageControl
    Left = 2
    Top = 55
    Width = 649
    Height = 112
    ActivePage = aba_consultaPorEndereco
    TabHeight = 30
    TabOrder = 1
    object aba_consultaPorCEP: TTabSheet
      Caption = '     Consulta por CEP     '
      object lbled_cepConsulta: TLabel
        Left = 21
        Top = 16
        Width = 81
        Height = 16
        Caption = 'Insira o CEP:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object bt_consultarCEP: TButton
        Left = 148
        Top = 33
        Width = 151
        Height = 25
        Caption = 'Consultar CEP'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        OnClick = bt_consultarCEPClick
      end
      object ed_cepConsulta: TEdtFocus
        Left = 21
        Top = 35
        Width = 121
        Height = 21
        TabOrder = 0
        OnExit = ed_cepConsultaExit
        OnKeyPress = ed_cepConsultaKeyPress
        MudarColor = clInfoBk
      end
    end
    object aba_consultaPorEndereco: TTabSheet
      Caption = '    Consulta por Endere'#231'o    '
      ImageIndex = 1
      object Label10: TLabel
        Left = 21
        Top = 16
        Width = 72
        Height = 16
        Caption = 'Insira a UF:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lbled_cidadeConsulta: TLabel
        Left = 114
        Top = 16
        Width = 101
        Height = 16
        Caption = 'Insira a Cidade:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lbled_logradouroConsulta: TLabel
        Left = 260
        Top = 16
        Width = 133
        Height = 16
        Caption = 'Insira o Logradouro:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object bt_consultarEndereco: TButton
        Left = 480
        Top = 33
        Width = 138
        Height = 25
        Caption = 'Consultar Endere'#231'o'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 3
        OnClick = bt_consultarEnderecoClick
      end
      object ed_ufConsulta: TEdtFocus
        Left = 21
        Top = 35
        Width = 83
        Height = 21
        TabOrder = 0
        OnExit = ed_ufConsultaExit
        OnKeyPress = ed_cepConsultaKeyPress
        MudarColor = clInfoBk
      end
      object ed_cidadeConsulta: TEdtFocus
        Left = 114
        Top = 35
        Width = 136
        Height = 21
        TabOrder = 1
        OnExit = ed_cidadeConsultaExit
        OnKeyPress = ed_cepConsultaKeyPress
        MudarColor = clInfoBk
      end
      object ed_logradouroConsulta: TEdtFocus
        Left = 260
        Top = 35
        Width = 214
        Height = 21
        TabOrder = 2
        OnExit = ed_logradouroConsultaExit
        OnKeyPress = ed_cepConsultaKeyPress
        MudarColor = clInfoBk
      end
    end
  end
  object Memo_json: TMemo
    Left = 657
    Top = 70
    Width = 262
    Height = 228
    ScrollBars = ssVertical
    TabOrder = 2
  end
  object ed_logradouro: TDBEdit
    Left = 128
    Top = 173
    Width = 261
    Height = 21
    DataField = 'Logradouro'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
  end
  object ed_complemento: TDBEdit
    Left = 128
    Top = 210
    Width = 261
    Height = 21
    DataField = 'Complemento'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
  end
  object ed_Siafi: TDBEdit
    Left = 457
    Top = 210
    Width = 181
    Height = 21
    DataField = 'Unidade'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
  end
  object ed_bairro: TDBEdit
    Left = 128
    Top = 245
    Width = 261
    Height = 21
    DataField = 'Bairro'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
  end
  object ed_ibge: TDBEdit
    Left = 457
    Top = 245
    Width = 181
    Height = 21
    DataField = 'IBGE'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 7
  end
  object ed_localidade: TDBEdit
    Left = 128
    Top = 277
    Width = 261
    Height = 21
    DataField = 'Localidade'
    TabOrder = 8
  end
  object ed_uf: TDBEdit
    Left = 457
    Top = 277
    Width = 181
    Height = 21
    DataField = 'UF'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 9
  end
  object ed_cep: TDBEdit
    Left = 457
    Top = 173
    Width = 181
    Height = 21
    DataField = 'CEP'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 10
  end
  object PnlRodapé: TPanel
    Left = 0
    Top = 485
    Width = 924
    Height = 42
    Align = alBottom
    BevelOuter = bvNone
    Color = clSilver
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentBackground = False
    ParentFont = False
    TabOrder = 11
    object bt_limparCampos: TButton
      Left = 617
      Top = 6
      Width = 152
      Height = 30
      Caption = 'Limpar Campos'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = bt_limparCamposClick
    end
    object bt_fechar: TButton
      Left = 775
      Top = 6
      Width = 144
      Height = 29
      Caption = 'Fechar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = bt_fecharClick
    end
  end
  object DbGridCEPCadastrado: TDBGrid
    Left = 0
    Top = 320
    Width = 924
    Height = 165
    Align = alBottom
    DataSource = ds_Mongo
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 12
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = [fsBold]
    Columns = <
      item
        Expanded = False
        FieldName = '_id'
        Title.Caption = 'Id'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'cep'
        Title.Caption = 'Cep'
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'logradouro'
        Title.Caption = 'Logradouro'
        Width = 130
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'localidade'
        Title.Caption = 'Cidade'
        Width = 110
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'bairro'
        Title.Caption = 'Bairro'
        Width = 120
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'uf'
        Title.Caption = 'Estado'
        Width = 50
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'complemento'
        Title.Caption = 'Complemento'
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ibge'
        Title.Caption = 'IBGE'
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'siafi'
        Title.Caption = 'SIAFI'
        Width = 80
        Visible = True
      end>
  end
  object ds_Mongo: TDataSource
    DataSet = FMongoQry
    Left = 304
    Top = 360
  end
  object FMongoQry: TFDMongoQuery
    UpdateOptions.KeyFields = '_id'
    Connection = FConMongo
    DatabaseName = 'local'
    CollectionName = 'cadastroceps'
    Left = 1128
    Top = 152
  end
  object FConMongo: TFDConnection
    Params.Strings = (
      'Server=localhost'
      'Database=local'
      'DriverID=Mongo')
    Connected = True
    LoginPrompt = False
    Left = 1064
    Top = 152
  end
end
