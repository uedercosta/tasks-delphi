unit Models.Conexao.ModelConexao;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Interfaces.iConexao, ZConnection;

type

  { TConexao }

  TConexao = class(TInterfacedObject, iConexao, iConexaoConfig)
  private
    FConexao: TZConnection;
    FCatalog: string;
    FDataBase: string;
    FHostName: string;
    FPassWord: string;
    FPort: integer;
    FProtocol: string;
    FUser: string;
  public
    constructor Create;
    destructor Destroy; override;
    class function New: iConexao;

    function Close: iConexao;
    function Open: iConexao;
    function Commit: iConexao;
    function RollBack: iConexao;
    function AddParams: iConexaoConfig;
    function EndConexao: TComponent;

    function Catalog(aValue: string): iConexaoConfig; overload;
    function Catalog: string; overload;
    function DataBase(aValue: string): iConexaoConfig; overload;
    function DataBase: string; overload;
    function HostName(aValue: string): iConexaoConfig; overload;
    function HostName: string; overload;
    function PassWord(aValue: string): iConexaoConfig; overload;
    function PassWord: string; overload;
    function Port(aValue: integer): iConexaoConfig; overload;
    function Port: integer; overload;
    function Protocol(aValue: string): iConexaoConfig; overload;
    function Protocol: string; overload;
    function User(aValue: string): iConexaoConfig; overload;
    function User: string; overload;
    function EndParams: iConexao;
  end;

implementation

{ TConexao }

constructor TConexao.Create;
begin
  FConexao := TZConnection.Create(nil);
end;

destructor TConexao.Destroy;
begin
  FreeAndNil(FConexao);
  inherited Destroy;
end;

class function TConexao.New: iConexao;
begin
  Result := Self.Create;
end;

function TConexao.Close: iConexao;
begin
  Result := self;
  FConexao.Disconnect;
end;

function TConexao.Open: iConexao;
begin
  Result := self;
  FConexao.Connect;
end;

function TConexao.Commit: iConexao;
begin
  Result := self;
  FConexao.Commit;
end;

function TConexao.RollBack: iConexao;
begin
  Result := self;
  FConexao.Rollback;
end;

function TConexao.AddParams: iConexaoConfig;
begin
  Result := self;
end;

function TConexao.EndConexao: TComponent;
begin
  Result := FConexao;
end;

function TConexao.Catalog(aValue: string): iConexaoConfig;
begin
  Result := self;
  FCatalog := aValue;
end;

function TConexao.Catalog: string;
begin
  Result := FCatalog;
end;

function TConexao.DataBase(aValue: string): iConexaoConfig;
begin
  Result := self;
  FDataBase := aValue;
end;

function TConexao.DataBase: string;
begin
  Result := FDataBase;
end;

function TConexao.HostName(aValue: string): iConexaoConfig;
begin
  Result := self;
  FHostName := aValue;
end;

function TConexao.HostName: string;
begin
  Result := FHostName;
end;

function TConexao.PassWord(aValue: string): iConexaoConfig;
begin
  Result := self;
  FPassWord := aValue;
end;

function TConexao.PassWord: string;
begin
  Result := FPassWord;
end;

function TConexao.Port(aValue: integer): iConexaoConfig;
begin
  Result := self;
  FPort := aValue;
end;

function TConexao.Port: integer;
begin
  Result := FPort;
end;

function TConexao.Protocol(aValue: string): iConexaoConfig;
begin
  Result := self;
  FProtocol := aValue;
end;

function TConexao.Protocol: string;
begin
  Result := FProtocol;
end;

function TConexao.User(aValue: string): iConexaoConfig;
begin
  Result := self;
  FUser := aValue;
end;

function TConexao.User: string;
begin
  Result := FUser;
end;

function TConexao.EndParams: iConexao;
begin
  Result := self;
  FConexao.Catalog := FCatalog;
  FConexao.Database := FDataBase;
  FConexao.HostName := FHostName;
  FConexao.Password := FPassWord;
  FConexao.Port := FPort;
  FConexao.Protocol := FProtocol;
  FConexao.User := FUser;
end;

end.
