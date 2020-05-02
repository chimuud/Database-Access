unit uFrmMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  uAffiliation, uSQLUtils;

type
  TFrmMain = class(TForm)
    btnAffil: TButton;
    btnSpy: TButton;
    Memo1: TMemo;
    procedure btnAffilClick(Sender: TObject);
    procedure btnSpyClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    SQLHelper: TSQLHelper;
    SpyHelper: TSQLHelper;
    Affiliation: TAffiliation;
  public
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;

implementation

{$R *.dfm}

procedure TFrmMain.btnAffilClick(Sender: TObject);
var
  sql: string;
  S: string;
begin
  sql :=
    'SELECT [aff_id] '+
    ' ,[title] '+
    ' ,[description] '+
    '  FROM [spy].[dbo].[affiliation] '+
    '  WHERE Description like ''%Russian%'' ';

  Affiliation.Open(sql);
  Affiliation.First;
  while not Affiliation.Eof do
  begin
    S :=
      Affiliation.Aff_Id.ToString + ',' +
      Affiliation.Title + ',' +
      Affiliation.Description;
    Memo1.Lines.Add(S);

    Affiliation.Next;
  end;
end;

procedure TFrmMain.btnSpyClick(Sender: TObject);
var
 sql: string;
  fileName: string;
begin
  sql :=
    'SELECT [aff_id] '+
    ' ,[title] '+
    ' ,[description] '+
    '  FROM [spy].[dbo].[affiliation] '+
    '  WHERE Description like ''%Russian%'' ';

  SpyHelper.Open(sql);
  fileName := SpyHelper.SaveToExcel(True);
  Memo1.Lines.LoadFromFile(fileName);
end;

procedure TFrmMain.FormCreate(Sender: TObject);
begin
  Affiliation := TAffiliation.Create('Spy');
  SpyHelper := TSQLHelper.Create('Spy');
end;

procedure TFrmMain.FormDestroy(Sender: TObject);
begin
  Affiliation.Free;
  SpyHelper.Free;
end;

end.
