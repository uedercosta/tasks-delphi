unit Views.MenuPrincipal;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Menus,
  ActnList, ZConnection, Models.Conexao.ModelConexao;

type

  { TForm1 }

  TForm1 = class(TForm)
    acTarefas: TAction;
    acUsuarios: TAction;
    acSair: TAction;
    ActionList1: TActionList;
    Button1: TButton;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    Separator1: TMenuItem;
    MenuItem5: TMenuItem;
    ZConnection1: TZConnection;
    procedure acUsuariosExecute(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure ZConnection1AfterConnect(Sender: TObject);
  private
    procedure LeParams(aValue: TZConnection);
  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

uses Views.Cadastros.Usuario;

procedure TForm1.Button1Click(Sender: TObject);
begin
  LeParams(ZConnection1);
  ShowMessage('Conectado com sucesso..');
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

procedure TForm1.ZConnection1AfterConnect(Sender: TObject);
begin

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

