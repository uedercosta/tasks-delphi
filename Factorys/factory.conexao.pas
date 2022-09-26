unit Factory.Conexao;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Interfaces.iConexao, Models.Conexao.ModelConexao;

type

  iFactoryConexao = interface
    function Conexao: iConexao;
  end;

  { TConexaoFactory }

  TConexaoFactory = class(TInterfacedObject, iFactoryConexao)
  private
    FConexao: iConexao;
  public
    constructor Create;
    destructor Destroy; override;
    class function New: iFactoryConexao;

    function Conexao: iConexao;
  end;

implementation

{ TConexaoFactory }

constructor TConexaoFactory.Create;
begin
  FConexao := TConexao
                .New
                   .Close
                   .AddParams
                     .Catalog('public')
                     .DataBase('db_tasks')
                     .HostName('localhost')
                     .PassWord('1234')
                     .Port(5432)
                     .Protocol('postgresql')
                     .User('postgres')
                     .EndParams
                   .Open;
end;

destructor TConexaoFactory.Destroy;
begin
  inherited Destroy;
end;

class function TConexaoFactory.New: iFactoryConexao;
begin
  Result := self.Create;
end;

function TConexaoFactory.Conexao: iConexao;
begin
  Result := FConexao;
end;

end.
