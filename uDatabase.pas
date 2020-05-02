unit uDatabase;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Data.Win.ADODB;

type
  TSqlDataModule = class(TDataModule)
    AdoSqlConnection: TADOConnection;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  public
    procedure Connect(DatabaseName: string;
      UserName: string = ''; Password: string = '');
  private
    FServerName: string;
    FUserName: string;
    FPassword: string;
  end;

var
  SqlDataModule: TSqlDataModule;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

uses
  IniFiles;

procedure TSqlDataModule.Connect(DatabaseName: string;
  UserName: string = ''; Password: string = '');
var
  connStr: string;
begin
  if FServerName = '' then Exit;

  connStr := 'Provider=MSOLEDBSQL.1;';
  if UserName <> '' then
    connStr :=  connStr + 'Password=' + Password + ';'
  else
    connStr :=  connStr + 'Password=' + FPassword + ';';

  connStr :=  connStr + 'Persist Security Info=True;';

  if UserName <> '' then
    connStr :=  connStr + 'User ID=' + UserName + ';'
  else
    connStr :=  connStr + 'User ID=' + FUserName + ';';

  if DataBaseName <> '' then
    connStr :=  connStr + 'Initial Catalog=' + DataBaseName + ';';

  connStr :=  connStr +
    'Data Source=' + FServerName + ';' + //DESKTOP-5U1LDH5\sqlexpress;
    'Initial File Name="";' +
    'Server SPN="";' +
    'Authentication=""';// +
//    'Access Token=""';
  AdoSqlConnection.Connected := False;
  AdoSqlConnection.ConnectionString := connStr;
  try
    AdoSqlConnection.Connected := True;
  except
    on e: Exception do
      raise Exception.Create(e.Message);
  end;
end;

{ TSqlDataModule }

procedure TSqlDataModule.DataModuleCreate(Sender: TObject);
var
  ini: TIniFile;
begin
  ini := TIniFile.Create(ChangeFileExt(ParamStr(0), '.ini'));
  FServerName := ini.ReadString('Database', 'Server', 'DESKTOP-5U1LDH5\sqlexpress');
  FUserName := ini.ReadString('Database', 'UserName', 'sa');
  FPassword := ini.ReadString('Database', 'Password', 'BatJaki123');
end;

procedure TSqlDataModule.DataModuleDestroy(Sender: TObject);
begin
  AdoSqlConnection.Connected := False;
end;

end.
