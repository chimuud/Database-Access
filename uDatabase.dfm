object SQLDatabase: TSQLDatabase
  Left = 0
  Top = 0
  ClientHeight = 111
  ClientWidth = 199
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object AdoSqlConnection: TADOConnection
    LoginPrompt = False
    Provider = 'MSOLEDBSQL.1'
    Left = 32
    Top = 24
  end
end
