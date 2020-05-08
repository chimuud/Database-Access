unit uDatabase;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Data.Win.ADODB;

type
  TSQLDatabase = class
    AdoSqlConnection: TADOConnection;
    constructor Create(Server: string = ''; UserName: string = ''; Password: string = '');
    destructor Destroy; override;
  public
    class function Connect(DatabaseName: string; Server: string = ''; UserName: string = ''; Password: string = ''): TADOConnection;
  private
    FServerName: string;
    FUserName: string;
    FPassword: string;
  end;

var
  SQLDatabase: TSQLDatabase;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

uses
  IniFiles, VCL.Dialogs;

constructor TSQLDatabase.Create(Server: string = ''; UserName: string = ''; Password: string = '');
var
  ini: TIniFile;
begin
  ini := TIniFile.Create(ChangeFileExt(ParamStr(0), '.ini'));
  if Server <> '' then
    FServerName := Server
  else
    FServerName := ini.ReadString('Database', 'Server', 'DESKTOP-5U1LDH5\sqlexpress');

  if UserName <> '' then
    FUserName := UserName
  else
    FUserName := ini.ReadString('Database', 'UserName', 'sa');

  if Password <> '' then
    FPassword := Password
  else
    FPassword := ini.ReadString('Database', 'Password', 'Password');
end;

destructor TSQLDatabase.Destroy;
begin
  AdoSqlConnection.Connected := False;
end;

class function TSQLDatabase.Connect(DatabaseName: string; Server: string = ''; UserName: string = ''; Password: string = ''): TADOConnection;

  function GetIniFile(ident: string; section: string = 'Database'): string;
  var
    ini: TIniFile;
  begin
    try
      ini := TIniFile.Create(ChangeFileExt(ParamStr(0), '.ini'));
      Result := ini.ReadString(section, ident, '');
    finally
      ini.Free;
    end;
  end;

var
  connStr: string;
begin
  Result := TADOConnection.Create(nil);

  if DataBaseName = '' then
  begin
    ShowMessage('Database name is not defined');
    Exit;
  end;

  connStr := 'Provider=MSOLEDBSQL.1;';

  if Server = '' then
    Server := GetIniFile('Server');

  if UserName = '' then
    UserName := GetIniFile('UserName');

  if Password = '' then
    Password := GetIniFile('Password');

  connStr :=  connStr + 'Password=' + Password + ';';
  connStr :=  connStr + 'Persist Security Info=True;';
  connStr :=  connStr + 'User ID=' + UserName + ';';
  connStr :=  connStr + 'Initial Catalog=' + DataBaseName + ';';
  connStr :=  connStr +
    'Data Source=' + Server + ';' + //DESKTOP-5U1LDH5\sqlexpress;
    'Initial File Name="";' +
    'Server SPN="";' +
    'Authentication=""';// +
//    'Access Token=""';
  Result.Connected := False;
  Result.ConnectionString := connStr;
  try
    Result.Connected := True;
  except
    on e: Exception do
      raise Exception.Create(e.Message);
  end;
end;


end.
