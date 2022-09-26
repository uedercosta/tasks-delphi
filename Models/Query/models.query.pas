unit Models.Query;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Factory.Conexao, ZDataset, ZConnection, DB, Dialogs;

type

  { iQuery }

  iQuery = interface
    function Close(aValue: TDataSource): iQuery;
    function Open(aValue: TDataSource): iQuery;
    function Clear: iQuery;
    function SQLAdd(aValue: string): iQuery;
    function ParamByName(aName: string; aValue: variant): iQuery;
    function ExecSQL: iQuery;
    function DataSet: TDataSet;
  end;

  { TQuery }

  TQuery = class(TInterfacedObject, iQuery)
  private
    FQuery: TZQuery;
    FFactoryCon: iFactoryConexao;
    FDataSet: TDataSet;
  public
    constructor Create(aValue: iFactoryConexao);
    destructor Destroy; override;
    class function New(aValue: iFactoryConexao): iQuery;

    function Close(aValue: TDataSource): iQuery;
    function Open(aValue: TDataSource): iQuery;
    function Clear: iQuery;
    function SQLAdd(aValue: string): iQuery;
    function ParamByName(aName: string; aValue: Variant): iQuery;
    function ExecSQL: iQuery;
    function DataSet: TDataSet;
  end;

implementation

{ TQuery }

constructor TQuery.Create(aValue: iFactoryConexao);
begin
  if aValue = nil then
     FFactoryCon:= TConexaoFactory.New
  else
     FFactoryCon:= aValue;

  FQuery := TZQuery.Create(nil);
  FQuery.Connection := TZConnection(FFactoryCon.Conexao.EndConexao);
end;

destructor TQuery.Destroy;
begin
  FreeAndNil(FQuery);
  inherited Destroy;
end;

class function TQuery.New(aValue: iFactoryConexao): iQuery;
begin
  Result := self.Create(aValue);
end;

function TQuery.Close(aValue: TDataSource): iQuery;
begin
  Result := Self;
  FQuery.Close;
  aValue.DataSet:= FQuery;
end;

function TQuery.Open(aValue: TDataSource): iQuery;
begin
  Result := Self;
  FQuery.Open;
  aValue.DataSet:= FQuery;
end;

function TQuery.Clear: iQuery;
begin
  Result := Self;
  FQuery.SQL.Clear;
end;

function TQuery.SQLAdd(aValue: string): iQuery;
begin
  Result := Self;
  FQuery.SQL.Add(aValue);
end;

function TQuery.ParamByName(aName: string; aValue: Variant): iQuery;
begin
  Result:= Self;
  FQuery.ParamByName(aName).Value:= aValue;
end;

function TQuery.ExecSQL: iQuery;
begin
  Result:= Self;
  FQuery.ExecSQL;
end;

function TQuery.DataSet: TDataSet;
begin
  Result:= FDataSet;
end;


end.
