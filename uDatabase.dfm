object SqlDataModule: TSqlDataModule
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 150
  Width = 215
  object AdoSqlConnection: TADOConnection
    LoginPrompt = False
    Provider = 'MSOLEDBSQL.1'
    Left = 32
    Top = 24
  end
end
