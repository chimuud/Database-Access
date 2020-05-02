object FrmMain: TFrmMain
  Left = 0
  Top = 0
  Caption = 'FrmMain'
  ClientHeight = 231
  ClientWidth = 505
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object btnAffil: TButton
    Left = 24
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Affiliation'
    TabOrder = 0
    OnClick = btnAffilClick
  end
  object btnSpy: TButton
    Left = 24
    Top = 56
    Width = 75
    Height = 25
    Caption = 'Spy'
    TabOrder = 1
    OnClick = btnSpyClick
  end
  object Memo1: TMemo
    Left = 152
    Top = 0
    Width = 353
    Height = 231
    Align = alRight
    Lines.Strings = (
      'Memo1')
    TabOrder = 2
  end
end
