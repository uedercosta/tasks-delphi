unit Views.Cadastros.Usuario;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, DBGrids, StdCtrls,
  Buttons, EditBtn, Models.Entity.Usuario, Utils.Util, DAO.Usuario;

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
  private
    procedure Limpar;
    procedure HabilitaBotoes(b1, b2: boolean);
    procedure Excluir(aValue: integer);
    function ConvertToModel(aValue: TDataSet): iUsuario;
    procedure ConverteParaView(aValue: TDataSet);
    function GetId(aValue: TDataSet): integer;
    procedure FormataCamposGrid;
  public
    FUsuario: iUsuario;
    FId: integer;
    FDAO: iUsuarioDAO;
  end;

var
  FrmCadUsuarios: TFrmCadUsuarios;

implementation

{$R *.lfm}

{ TFrmCadUsuarios }

procedure TFrmCadUsuarios.btNovoClick(Sender: TObject);
begin
  Limpar;
  HabilitaBotoes(False, True);
  edNome.SetFocus;
  checkAtivo.Checked := True;
  edCriacao.Date := Date;
  FId := 0;
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
    HabilitaBotoes(False, True);
    ConverteParaView(dsDados.DataSet);
  end;
end;

procedure TFrmCadUsuarios.btPesquisaClick(Sender: TObject);
begin
  if (trim(edPesquisa.Text) = '') then
    FDAO.FindAll(dsDados)
  else
    FDAO.FindAll(edPesquisa.Text, dsDados);
  FormataCamposGrid;
end;

procedure TFrmCadUsuarios.btSairClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmCadUsuarios.btSalvaClick(Sender: TObject);
begin
  if (FId = 0) then
  begin
    FUsuario.DataCriacao(edCriacao.Date).Ativo(checkAtivo.Checked)
      .Login(edLogin.Text).Senha(edSenha.Text).Nome(edNome.Text);
  end
  else
  begin
    FUsuario.Id(FId).DataCriacao(edCriacao.Date).Ativo(checkAtivo.Checked)
      .Login(edLogin.Text).Senha(edSenha.Text).Nome(edNome.Text);
  end;
  FDAO.Save(FUsuario, dsDados);
  HabilitaBotoes(True, False);
  Limpar;
end;

procedure TFrmCadUsuarios.DBGrid1DblClick(Sender: TObject);
begin
  btEdita.Click;
end;

procedure TFrmCadUsuarios.dsDadosDataChange(Sender: TObject; Field: TField);
begin
  GetId(dsDados.DataSet);
end;

procedure TFrmCadUsuarios.FormCreate(Sender: TObject);
begin
  FUsuario := TUsuario.New;
  FDAO := TDAOUsuario.New;
  FId := 0;
  Limpar;
  HabilitaBotoes(True, False);
  FormataCamposGrid;
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

procedure TFrmCadUsuarios.Excluir(aValue: integer);
begin
  if MessageDlg('Confirma a exclusão do registro ?', mtConfirmation,
    [mbYes, mbNo], 0) = mrYes then
  begin
    FDAO.Delete(aValue, dsDados);
    FormataCamposGrid;
  end;
end;

function TFrmCadUsuarios.ConvertToModel(aValue: TDataSet): iUsuario;
begin
  Result := FUsuario.Ativo(aValue.FieldByName('ATIVO').AsInteger)
    .DataCriacao(aValue.FieldByName('DATA_CRIACAO').AsDateTime)
    .Id(aValue.FieldByName('ID_USUARIO').Value)
    .Login(aValue.FieldByName('LOGIN').Value).Nome(aValue.FieldByName('NOME').Value)
    .Senha(aValue.FieldByName('SENHA').Value);
end;

procedure TFrmCadUsuarios.ConverteParaView(aValue: TDataSet);
begin
  ConvertToModel(aValue);
  edLogin.Text := FUsuario.Login;
  edNome.Text := FUsuario.Nome;
  edSenha.Text := FUsuario.Senha;
  if FUsuario.Ativo = 0 then checkAtivo.Checked := False
  else
    checkAtivo.Checked := True;
  edCriacao.Date := FUsuario.DataCriacao;
  lblCodigo.Caption := StrZero(FUsuario.Id, 6);
end;


function TFrmCadUsuarios.GetId(aValue: TDataSet): integer;
begin
  if not aValue.IsEmpty then
    FId := aValue.Fields[0].Value;
end;

procedure TFrmCadUsuarios.FormataCamposGrid;
begin
  DBGrid1.columns[0].FieldName := 'ID_USUARIO';
  DBGrid1.columns[1].FieldName := 'NOME';
  DBGrid1.columns[2].FieldName := 'ATIVO';
  DBGrid1.columns[0].Width := 64;
  DBGrid1.columns[1].Width := 210;
  DBGrid1.columns[2].Width := 40;
end;

end.
