unit Views.Cadastros.Usuario;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, DBGrids, StdCtrls,
  Buttons, EditBtn, Models.Entity.Usuario, ZDataSet;

type

  { TFrmCadUsuarios }

  TFrmCadUsuarios = class(TForm)
    btPesquisa: TBitBtn;
    btNovo: TBitBtn;
    btEdita: TBitBtn;
    btSalva: TBitBtn;
    btCancela: TBitBtn;
    btExclui: TBitBtn;
    btSair: TBitBtn;
    checkAtivo: TCheckBox;
    edCriacao: TDateEdit;
    dsDados: TDataSource;
    DBGrid1: TDBGrid;
    edPesquisa: TEdit;
    edNome: TEdit;
    edLogin: TEdit;
    edSenha: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    lblCodigo: TLabel;
    procedure btCancelaClick(Sender: TObject);
    procedure btExcluiClick(Sender: TObject);
    procedure btNovoClick(Sender: TObject);
    procedure btEditaClick(Sender: TObject);
    procedure btPesquisaClick(Sender: TObject);
    procedure btSairClick(Sender: TObject);
    procedure btSalvaClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure dsDadosDataChange(Sender: TObject; Field: TField);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    procedure Limpar;
    procedure HabilitaBotoes(b1, b2: boolean);
    procedure Inserir(aValue: iUsuario);
    procedure Editar(aValue: iUsuario);
    procedure Excluir(aValue: integer);
    function
    procedure ConverteParaView(aValue: TDataSet);

  public
    FUsuario: iUsuario;
    FDataSet: TZQuery;
    FId: integer;
  end;

var
  FrmCadUsuarios: TFrmCadUsuarios;

implementation

{$R *.lfm}

{ TFrmCadUsuarios }

uses Views.MenuPrincipal;

procedure TFrmCadUsuarios.btNovoClick(Sender: TObject);
begin
  Limpar;
  HabilitaBotoes(False, True);
  edNome.SetFocus;
  checkAtivo.Checked := True;
  edCriacao.Date := Date;
  FDataSet.close;
end;

procedure TFrmCadUsuarios.btExcluiClick(Sender: TObject);
begin
  if (dsDados.DataSet.IsEmpty) then
  begin
    MessageDlg('Nenhum registro foi encontrado...', mtInformation, [mbOK], 0);
    btEdita.SetFocus;
    Exit;
  end
  else
  begin
    Excluir(dsDados.DataSet.Fields[0].Value);
    HabilitaBotoes(True, False);
  end;
end;

procedure TFrmCadUsuarios.btCancelaClick(Sender: TObject);
begin
  Limpar;
  HabilitaBotoes(True, False);
end;

procedure TFrmCadUsuarios.btEditaClick(Sender: TObject);
begin
  if (dsDados.DataSet.IsEmpty) then
  begin
    MessageDlg('Nenhum registro foi encontrado...', mtInformation, [mbOK], 0);
    btEdita.SetFocus;
    Exit;
  end
  else
  begin
    HabilitaBotoes(false, true);
    ConverteParaView(dsdados.DataSet);
  end;
end;

procedure TFrmCadUsuarios.btPesquisaClick(Sender: TObject);
begin
  FDataSet.Close;
  FDataSet.SQL.Clear;
  FDataSet.SQL.Add('SELECT * FROM USUARIOS');
  FDataSet.SQL.Add('WHERE 1 = 1 ');
  if edPesquisa.Text <> '' then
     FDataSet.SQL.Add('AND UPPER(NOME) LIKE ' + QuotedStr('%' + edPesquisa.Text + '%') );

  FDataSet.SQL.Add('ORDER BY ID_USUARIO');

  FDataSet.Open;
  dsDados.DataSet := FDataSet;
end;

procedure TFrmCadUsuarios.btSairClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmCadUsuarios.btSalvaClick(Sender: TObject);
begin
  if (FId = 0) then
  begin
    FUsuario
      .DataCriacao(edCriacao.Date)
      .Ativo(checkAtivo.Checked)
      .Login(edLogin.Text)
      .Senha(edSenha.Text)
      .Nome(edNome.Text);
    Inserir(FUsuario);
    HabilitaBotoes(True, False);
  end
  else
  begin
    FUsuario
      .Id(FId)
      .DataCriacao(edCriacao.Date)
      .Ativo(checkAtivo.Checked)
      .Login(edLogin.Text)
      .Senha(edSenha.Text)
      .Nome(edNome.Text);
    Editar(FUsuario);
    HabilitaBotoes(True, False);
  end;
end;

procedure TFrmCadUsuarios.DBGrid1DblClick(Sender: TObject);
begin
  btEdita.Click;
end;

procedure TFrmCadUsuarios.dsDadosDataChange(Sender: TObject; Field: TField);
begin
  if not Dsdados.DataSet.IsEmpty then
    FId := dsDados.DataSet.Fields[0].Value;
end;

procedure TFrmCadUsuarios.FormCreate(Sender: TObject);
begin
  FUsuario := TUsuario.New;
  FDataSet := Form1.ZQuery1;
  dsDados.DataSet := FDataSet;
  FId := 0;
end;

procedure TFrmCadUsuarios.FormShow(Sender: TObject);
begin
  Limpar;
  HabilitaBotoes(True, False);
end;

procedure TFrmCadUsuarios.Limpar;
begin
  edLogin.Clear;
  edNome.Clear;
  edPesquisa.Clear;
  edSenha.Clear;
  checkAtivo.Checked := False;
  edCriacao.Clear;
  lblCodigo.Caption := '000000';
end;

procedure TFrmCadUsuarios.HabilitaBotoes(b1, b2: boolean);
begin
  btNovo.Enabled := b1;
  btEdita.Enabled := b1;
  btCancela.Enabled := b2;
  btExclui.Enabled := b1;
  btSalva.Enabled := b2;
  btPesquisa.Enabled := b1;
end;

procedure TFrmCadUsuarios.Inserir(aValue: iUsuario);
begin
  FDataSet.Close;
  FDataSet.SQL.Clear;
  FDataSet.SQL.Add('INSERT INTO USUARIOS (NOME, LOGIN, SENHA, ATIVO) ');
  FDataSet.SQL.Add('VALUES ');
  FDataSet.SQL.Add('(:NOME, :LOGIN, :SENHA, :ATIVO) ');

  FDataSet.ParamByName('NOME').Value := aValue.Nome;
  FDataSet.ParamByName('LOGIN').Value := aValue.Login;
  FDataSet.ParamByName('SENHA').Value := aValue.Senha;
  FDataSet.ParamByName('ATIVO').Value := aValue.Ativo;
  FDataSet.ExecSQL;

  FDataSet.Close;
  FDataSet.SQL.Clear;
  FDataSet.SQL.Add('SELECT * FROM USUARIOS ORDER BY ID_USUARIO');
  FDataSet.Open;
  dsDados.DataSet := FDataSet;
end;

procedure TFrmCadUsuarios.Editar(aValue: iUsuario);
begin
  FDataSet.Close;
  FDataSet.SQL.Clear;
  FDataSet.SQL.Add('UPDATE USUARIOS SET');
  FDataSet.SQL.Add('NOME = :NOME, LOGIN = :LOGIN, SENHA = :SENHA, ATIVO = :ATIVO ');
  FDataSet.SQL.Add('WHERE ID_USUARIO = :ID');

  FDataSet.ParamByName('ID').Value := aValue.Id;
  FDataSet.ParamByName('NOME').Value := aValue.Nome;
  FDataSet.ParamByName('LOGIN').Value := aValue.Login;
  FDataSet.ParamByName('SENHA').Value := aValue.Senha;
  FDataSet.ParamByName('ATIVO').Value := aValue.Ativo;
  FDataSet.ExecSQL;

  FDataSet.Close;
  FDataSet.SQL.Clear;
  FDataSet.SQL.Add('SELECT * FROM USUARIOS ORDER BY ID_USUARIO');
  FDataSet.Open;
  dsDados.DataSet := FDataSet;

end;

procedure TFrmCadUsuarios.Excluir(aValue: integer);
begin
  if (aValue < 1) then
  begin
    ShowMessage('Codigo invalido...');
    btEdita.SetFocus;
  end
  else
  begin
    FDataSet.Close;
    FDataSet.SQL.Clear;
    FDataSet.SQL.Add('DELETE FROM USUARIOS WHERE ID_USUARIO = :ID');
    FDataSet.ParamByName('ID').Value := aValue;
    FDataSet.ExecSQL;

    FDataSet.Close;
    FDataSet.SQL.Clear;
    FDataSet.SQL.Add('SELECT * FROM USUARIOS ORDER BY ID_USUARIO');
    FDataSet.Open;
    dsDados.DataSet := FDataSet;
  end;
end;

procedure TFrmCadUsuarios.ConverteParaView(aValue: TDataSet);
begin
  FUsuario
    .Ativo(aValue.FieldByName('ATIVO').AsInteger)
    .DataCriacao(aValue.FieldByName('DATA_CRIACAO').AsDateTime)
    .Id(aValue.FieldByName('ID_USUARIO').Value)
    .Login(aValue.FieldByName('LOGIN').Value)
    .Nome(aValue.FieldByName('NOME').Value)
    .Senha(aValue.FieldByName('SENHA').Value);
  edLogin.text:= FUsuario.Login;
  edNome.text:= FUsuario.Nome;
  edSenha.text:= FUsuario.Senha;
  if Fusuario.Ativo = 0 then checkAtivo.Checked := false else checkAtivo.Checked:=true;
  edCriacao.Date:= FUsuario.DataCriacao;
  lblCodigo.Caption := FUsuario.Id.ToString;
end;

end.
