unit uSQLUtils;

interface

uses
  Classes, ADODB, IOUtils,
  uDatabase, System.SysUtils;

type
  TSQLHelper = class(TAdoQuery)
  public
    constructor Create(aDatabaseName: string);
    destructor Destroy; override;

    procedure Open(aSql: string); overload;
    function SaveToExcel(IncludeHeader: Boolean): string;
  private
    FDatabaseName: string;
    FSQLDataModule: TSqlDataModule;
  end;

implementation


{ TSQLHelper }

constructor TSQLHelper.Create(aDatabaseName: string);
begin
  inherited Create(nil);
  FDatabaseName := aDatabaseName;
  FSQLDataModule := TSqlDataModule.Create(nil);
  FSQLDataModule.Connect(aDatabaseName);
  Connection := FSQLDataModule.AdoSqlConnection;
end;

destructor TSQLHelper.Destroy;
begin
  Close;
  FSQLDataModule.Free;
  inherited;
end;

procedure TSQLHelper.Open(aSql: string);
begin
  SQL.Text := aSql;
  try
    Open;
  except
    on e: Exception do
      raise Exception.Create(e.Message);
  end;
end;

function TSQLHelper.SaveToExcel(IncludeHeader: Boolean): string;
var
  aRecno: Integer;
  sw: TStreamWriter;
  S: string;
  I: Integer;

  procedure WriteHeader;
  var
    I: Integer;
  begin
    for I := 0 to Fields.Count - 1 do
      S := S + Fields[I].FieldName + ',';

    S := S.Remove(S.Length - 1) + #13#10;
    TFile.AppendAllText(Result, S);
  end;

begin
  Result := IncludeTrailingBackslash(ExtractFilePath(ParamStr(0))) + FDatabaseName + '.csv';
  if IncludeHeader then
    WriteHeader;

  aRecno := RecNo;
  First;
  while not Eof do begin
    S := '';
    for I := 0 to FieldCount - 1 do
      S := S + Fields[I].AsString + ',';
    S := S.Remove(S.Length - 1) + #13#10;
    TFile.AppendAllText(Result, S);

    Next;
  end;
  Recno := aRecno;
end;

end.
