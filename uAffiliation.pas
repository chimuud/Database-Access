unit uAffiliation;

interface

uses
  uSQLUtils;

type
  TAffiliation = class(TSQLHelper)
  private
    FAff_Id: Integer;
    FTitle: string;
    FDescription: string;
    function GetAff_Id: Integer;
    function GetTitle: string;
    function GetDescription: string;
  public
    property Aff_Id: Integer read GetAff_Id write FAff_Id;
    property Title: string read GetTitle write FTitle;
    property Description: string read GetDescription write FDescription;
  end;

implementation

uses
  System.SysUtils;

{ TAffiliation }

function TAffiliation.GetAff_Id: Integer;
begin
  Result := FieldByName('Aff_Id').AsInteger;
end;

function TAffiliation.GetDescription: string;
begin
  Result := FieldByName('Description').AsString.TrimRight;
end;

function TAffiliation.GetTitle: string;
begin
  Result := FieldByName('Title').AsString.TrimRight;
end;


end.
