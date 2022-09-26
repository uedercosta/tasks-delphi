program MyTasks;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  {$IFDEF HASAMIGA}
  athreads,
  {$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, zcomponent, Views.MenuPrincipal, Interfaces.iConexao,
  Models.Conexao.ModelConexao, Views.Cadastros.Tarefa, Views.Cadastros.Usuario,
  Models.Entity.Usuario, Models.Query, Utils.Util, Factory.Conexao, 
Factory.Query, DAO.Usuario
  { you can add units after this };

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

