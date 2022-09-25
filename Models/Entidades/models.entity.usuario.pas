unit Models.Entity.Usuario;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils;

type

  { iUsuario }

  iUsuario = interface
    function Id: integer; overload;
    function Id(const aValue: integer): iUsuario; overload;
    function Nome: string; overload;
    function Nome(const aValue: string): iUsuario; overload;
    function Login: string; overload;
    function Login(const aValue: string): iUsuario; overload;
    function Senha: string; overload;
    function Senha(const aValue: string): iUsuario; overload;
    function DataCriacao: TDate;
    function DataCriacao(aValue : TDate): iUsuario; overload;
    function Ativo: integer; overload;
    function Ativo(const aValue: integer): iUsuario; overload;
    function Ativo(const aValue: boolean): iUsuario; overload;
  end;

  { TUsuario }

  TUsuario = class(TInterfacedObject, iUsuario)
  private
    FId: integer;
    FNome: string;
    FLogin: string;
    FSenha: string;
    FDataCriacao: TDateTime;
    FAtivo: integer;
  public
    constructor Create;
    destructor Destroy; override;
    class function New: iUsuario;

    function Id: integer; overload;
    function Id(const aValue: integer): iUsuario; overload;
    function Nome: string; overload;
    function Nome(const aValue: string): iUsuario; overload;
    function Login: string; overload;
    function Login(const aValue: string): iUsuario; overload;
    function Senha: string; overload;
    function Senha(const aValue: string): iUsuario; overload;
    function DataCriacao: TDate;
    function DataCriacao(aValue : TDate): iUsuario; overload;
    function Ativo: integer; overload;
    function Ativo(const aValue: integer): iUsuario; overload;
    function Ativo(const aValue: boolean): iUsuario; overload;
  end;

implementation

{ TUsuario }

constructor TUsuario.Create;
begin
  FId:= 0;
  FNome:= '';
  FLogin:= '';
  FSenha:= '';
  FDataCriacao:= Now;
  FAtivo:= 1;
end;

destructor TUsuario.Destroy;
begin
  inherited Destroy;
end;

class function TUsuario.New: iUsuario;
begin
  Result:= self.Create;
end;

function TUsuario.Id: integer;
begin
  Result:= FId;
end;

function TUsuario.Id(const aValue: integer): iUsuario;
begin
  Result:= self;
  FId:= aValue;
end;

function TUsuario.Nome: string;
begin
  Result:= FNome;
end;

function TUsuario.Nome(const aValue: string): iUsuario;
begin
  if trim(aValue) = '' then
    raise Exception.Create('Nome não preenchido...');
  Result:= self;
  FNome:= UpperCase(aValue);
end;

function TUsuario.Login: string;
begin
  Result:= FLogin;
end;

function TUsuario.Login(const aValue: string): iUsuario;
begin
  if trim(aValue) = '' then
    raise Exception.Create('Login não preenchido...');
  Result:= self;
  FLogin:=UpperCase(aValue);
end;

function TUsuario.Senha: string;
begin
  Result:= FSenha;
end;

function TUsuario.Senha(const aValue: string): iUsuario;
begin
  if trim(aValue) = '' then
    raise Exception.Create('Senha não preenchido...');
  Result:= self;
  FSenha:=UpperCase(aValue);
end;

function TUsuario.DataCriacao: TDate;
begin
  Result:= FDataCriacao;
end;

function TUsuario.DataCriacao(aValue: TDate): iUsuario;
begin
  Result:= self;
  FDataCriacao:=aValue;
end;

function TUsuario.Ativo: integer;
begin
  Result:= FAtivo;
end;

function TUsuario.Ativo(const aValue: integer): iUsuario;
begin
  if aValue > 1 then
    raise Exception.Create('Valor inválido...');
  Result:= self;
  FAtivo:= aValue;
end;

function TUsuario.Ativo(const aValue: boolean): iUsuario;
begin
  Result:= self;
  if aValue = true then FAtivo:=1 else FAtivo:= 0;
end;

end.
