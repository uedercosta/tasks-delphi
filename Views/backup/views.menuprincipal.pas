unit Views.MenuPrincipal;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Menus,
  ActnList, DBGrids, ZConnection, ZDataset, Factory.Conexao, Factory.Query, DB;

type

  { TForm1 }

  TForm1 = class(TForm)
    acTarefas: TAction;
    acUsuarios: TAction;
    acSair: TAction;
    ActionList1: TActionList;
    Button1: TButton;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    Separator1: TMenuItem;
    MenuItem5: TMenuItem;
    ZQuery1: TZQuery;
    procedure acUsuariosExecute(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure LeParams(aValue: TZConnection);
  public
    FConexao: iFactoryConexao;
    FQuery: iFactoryQuery;
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

uses Views.Cadastros.Usuario;


procedure TForm1.FormCreate(Sender: TObject);
begin
  FConexao:= TConexaoFactory.New;
  ZQuery1.Connection:= TZConnection(FConexao.Conexao.EndConexao);
end;

procedure TForm1.acUsuariosExecute(Sender: TObject);
begin
  try
    Application.CreateForm(TFrmCadUsuarios, FrmCadUsuarios);
    FrmCadUsuarios.ShowModal;
  finally
    FreeAndNil(FrmCadUsuarios);
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
     TQueryFactory
      .New
         .Query
         .Close(DataSource1)
         .Clear
         .SQLAdd('SELECT * FROM USUARIOS')
         .Open(DataSource1);
end;

procedure TForm1.LeParams(aValue: TZConnection);
begin
  aValue.Disconnect;
  aValue.Catalog  := 'public';
  aValue.Database := 'db_tasks';
  aValue.HostName := 'localhost';
  aValue.Password := '1234';
  aValue.Port     := 5432;
  aValue.Protocol := 'postgresql';
  aValue.User     := 'postgres';
  aValue.Connect;
end;

end.

