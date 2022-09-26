unit DAO.Usuario;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Models.Entity.Usuario, Factory.Query, DB;

type

  { iUsuarioDAO }

  iUsuarioDAO = interface
    function Save(aValue: iUsuario; aDados: TDataSource): iUsuarioDAO;
    function Delete(aValue: integer; aDados: TDataSource): iUsuarioDAO;
    function FindById(aValue: integer; aDados: TDataSource): iUsuarioDAO;
    function FindAll(aValue: string; aDados: TDataSource): iUsuarioDAO; overload;
    function FindAll(aDados: TDataSource): iUsuarioDAO; overload;
  end;

  { TDAOUsuario }

  TDAOUsuario = class(TInterfacedObject, iUsuarioDAO)
  private
    FDAO: iUsuarioDAO;
    FQuery: iFactoryQuery;
  public
    constructor Create;
    destructor Destroy; override;
    class function New: iUsuarioDAO;

    function Save(aValue: iUsuario; aDados: TDataSource): iUsuarioDAO;
    function Delete(aValue: integer; aDados: TDataSource): iUsuarioDAO;
    function FindById(aValue: integer; aDados: TDataSource): iUsuarioDAO;
    function FindAll(aValue: string; aDados: TDataSource): iUsuarioDAO; overload;
    function FindAll(aDados: TDataSource): iUsuarioDAO; overload;

  end;

implementation

{ TDAOUsuario }

constructor TDAOUsuario.Create;
begin
  FQuery := TQueryFactory.New;
end;

destructor TDAOUsuario.Destroy;
begin
  inherited Destroy;
end;

class function TDAOUsuario.New: iUsuarioDAO;
begin
  Result := self.Create;
end;

function TDAOUsuario.Save(aValue: iUsuario; aDados: TDataSource): iUsuarioDAO;
begin
  if (aValue.Id = 0) then
  begin
    FQuery
      .Query
      .Close(aDados)
      .Clear
      .SQLAdd('INSERT INTO USUARIOS (NOME, LOGIN, SENHA, ATIVO) ')
      .SQLAdd('VALUES ')
      .SQLAdd('(:NOME, :LOGIN, :SENHA, :ATIVO) ')
      .ParamByName('NOME', aValue.Nome)
      .ParamByName('LOGIN', aValue.Login)
      .ParamByName('SENHA', aValue.Senha)
      .ParamByName('ATIVO', aValue.Ativo)
      .ExecSQL
      .Close(aDados)
      .Clear
      .SQLAdd('SELECT * FROM USUARIOS ORDER BY ID_USUARIO')
      .Open(aDados);
  end
  else
  begin
    FQuery
      .Query
      .Close(aDados)
      .Clear
      .SQLAdd('UPDATE USUARIOS SET')
      .SQLAdd('NOME = :NOME, LOGIN = :LOGIN, SENHA = :SENHA, ATIVO = :ATIVO ')
      .SQLAdd('WHERE ID_USUARIO = :ID')
      .ParamByName('ID', aValue.Id)
      .ParamByName('NOME', aValue.Nome)
      .ParamByName('LOGIN', aValue.Login)
      .ParamByName('SENHA', aValue.Senha)
      .ParamByName('ATIVO', aValue.Ativo)
      .ExecSQL
      .Close(aDados)
      .Clear
      .SQLAdd('SELECT * FROM USUARIOS ORDER BY ID_USUARIO')
      .Open(aDados);
  end;
end;

function TDAOUsuario.Delete(aValue: integer; aDados: TDataSource): iUsuarioDAO;
begin
  FQuery
    .Query
    .Close(aDados)
    .Clear
    .SQLAdd('DELETE FROM USUARIOS WHERE ID_USUARIO = :ID')
    .ParamByName('ID', aValue)
    .ExecSQL
    .Close(aDados)
    .Clear
    .SQLAdd('SELECT * FROM USUARIOS ORDER BY ID_USUARIO')
    .Open(aDados);
end;

function TDAOUsuario.FindById(aValue: integer; aDados: TDataSource): iUsuarioDAO;
begin
   showmessa
end;

function TDAOUsuario.FindAll(aValue: string; aDados: TDataSource): iUsuarioDAO;
begin
  Result := self;
  FQuery
    .Query
    .Close(aDados)
    .Clear
    .SQLAdd('SELECT * FROM USUARIOS WHERE NOME LIKE :NOME ORDER BY ID_USUARIO')
    .ParamByName('NOME', '%' + aValue + '%')
    .Open(aDados);

end;

function TDAOUsuario.FindAll(aDados: TDataSource): iUsuarioDAO;
begin
  Result := self;
  FQuery
    .Query
    .Close(aDados)
    .Clear
    .SQLAdd('SELECT * FROM USUARIOS ORDER BY ID_USUARIO')
    .Open(aDados);
end;

end.
