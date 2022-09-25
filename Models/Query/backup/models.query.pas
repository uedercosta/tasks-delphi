unit Models.Query;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Models.Conexao.ModelConexao, ZDataset;

type

  iQuery = interface
    function Close: iQuery;
    function Open: iQuery;
    function Clear: iQuery;
    function SQLAdd(aValue: string): iQuery;
    function ParamByName(aName: string; aValue: variant): iQuery;
    function ExecSQL: iQuery;
  end;

  { TQuery }

  TQuery = class(TInterfacedObject, iQuery)
  private
    //FConexao: iConexao;
    FQuery: TZQuery;
  public
    constructor Create;
    destructor Destroy; override;
    class function New: iQuery;

    function Close: iQuery;
    function Open: iQuery;
    function Clear: iQuery;
    function SQLAdd(aValue: string): iQuery;
    function ParamByName(aName: string; aValue: variant): iQuery;
    function ExecSQL: iQuery;
  end;

implementation

{ TQuery }

constructor TQuery.Create;
begin
  FQuery:= TZQuery.Create(nil);
  FQuery.Connection:= aParent;
end;

destructor TQuery.Destroy;
begin
  inherited Destroy;
end;

class function TQuery.New: iQuery;
begin

end;

function TQuery.Close: iQuery;
begin

end;

function TQuery.Open: iQuery;
begin

end;

function TQuery.Clear: iQuery;
begin

end;

function TQuery.SQLAdd(aValue: string): iQuery;
begin

end;

function TQuery.ParamByName(aName: string; aValue: variant): iQuery;
begin

end;

function TQuery.ExecSQL: iQuery;
begin

end;

end.
