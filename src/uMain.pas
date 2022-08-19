unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Data.DB, Vcl.Grids,
  Vcl.DBGrids, uDados, Vcl.ExtCtrls, Vcl.Menus, Vcl.Buttons, Vcl.ComCtrls,
  frxClass, frxExportBaseDialog, frxExportPDF, frxGradient, frxDBSet,
  Vcl.Mask, ACBrValidador, ACBrBase, ACBrSocket, ACBrCEP;

type
  TMainForm = class(TForm)
    DataSource1: TDataSource;
    PageCadastro: TPageControl;
    tab1: TTabSheet;
    Panel2: TPanel;
    DBGrid1: TDBGrid;
    tab2: TTabSheet;
    Panel3: TPanel;
    Panel6: TPanel;
    edNome: TLabeledEdit;
    Panel1: TPanel;
    Panel4: TPanel;
    edPesquisa: TEdit;
    sbExc: TSpeedButton;
    sbAlt: TSpeedButton;
    sbInc: TSpeedButton;
    sbCan: TSpeedButton;
    MainMenu1: TMainMenu;
    Relatrios1: TMenuItem;
    RelatriodeProdutos1: TMenuItem;
    MenuItem1: TMenuItem;
    Label1: TLabel;
    btLimpar: TSpeedButton;
    edNomeMae: TLabeledEdit;
    edNomePai: TLabeledEdit;
    meCpf: TMaskEdit;
    lbCpf: TLabel;
    Label2: TLabel;
    meRg: TMaskEdit;
    tab3: TTabSheet;
    Panel5: TPanel;
    Panel7: TPanel;
    sbVoltar: TSpeedButton;
    Label3: TLabel;
    meCep: TMaskEdit;
    sbProxima: TSpeedButton;
    sbGrv: TSpeedButton;
    Label5: TLabel;
    Label6: TLabel;
    edCidade: TLabeledEdit;
    meUf: TMaskEdit;
    Label4: TLabel;
    ACBrCEP1: TACBrCEP;
    ACBrValidador1: TACBrValidador;
    Label7: TLabel;
    edNumero: TEdit;
    btPesquisarCep: TButton;
    edEndereco: TLabeledEdit;
    sbVisualizar: TSpeedButton;
    SpeedButton1: TSpeedButton;
    sbBUscar: TSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure sbGrvClick(Sender: TObject);
    procedure sbIncClick(Sender: TObject);
    procedure sbCanClick(Sender: TObject);
    procedure sbAltClick(Sender: TObject);
    procedure sbExcClick(Sender: TObject);
    procedure btLimparClick(Sender: TObject);
    procedure RelatriodeProdutos1Click(Sender: TObject);
    procedure sbProximaClick(Sender: TObject);
    procedure sbVoltarClick(Sender: TObject);
    procedure meUfExit(Sender: TObject);
    procedure meCepExit(Sender: TObject);
    procedure btPesquisarCepClick(Sender: TObject);
    procedure sbVisualizarClick(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure meCpfExit(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure sbBUscarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    xIncluindo, xEditando, xSoAlerta: Boolean;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

procedure TMainForm.btLimparClick(Sender: TObject);
begin
  edPesquisa.Text := '';
end;

procedure TMainForm.btPesquisarCepClick(Sender: TObject);
 var
 i : integer;
begin

  ACBrCEP1.BuscarPorCEP(meCep.Text);
  for I := 0 to ACBrCEP1.Enderecos.Count -1 do
  begiN
      meCep.Text          := ACBrCEP1.Enderecos[i].CEP;
      edCidade.Text       := ACBrCEP1.Enderecos[i].Municipio;
      meUf.Text           := ACBrCEP1.Enderecos[i].UF;
      edEndereco.Text         := ACBrCEP1.Enderecos[i].Tipo_Logradouro+' '+ACBrCEP1.Enderecos[i].Logradouro;
     // edtLogradouro.Text   := ACBrCEP1.Enderecos[i].Logradouro;
     // edtComplemento.Text  := ACBrCEP1.Enderecos[i].Complemento;
     // edtBairro.Text       := ACBrCEP1.Enderecos[i].Bairro;
  end;


end;

procedure TMainForm.FormShow(Sender: TObject);
begin
  edNome.Clear;

  PageCadastro.Pages[0].TabVisible := True;
  PageCadastro.Pages[1].TabVisible := False;
  PageCadastro.Pages[2].TabVisible := False;
  PageCadastro.ActivePage := Tab1; // Volta para a Tela de Consulta

  dmDados.FDQueryJoin.Open();

  // verifica se tem registro/ se nao => ele deixa ele desabilitado
  sbAlt.Enabled := dmDados.FDQueryJoin.RecordCount > 0;
  sbExc.Enabled := dmDados.FDQueryJoin.RecordCount > 0;
  sbVisualizar.Enabled := dmDados.FDQueryJoin.RecordCount > 0;


  sbInc.Enabled := True;
  sbAlt.Visible := True;
  sbExc.Visible := True;
  sbInc.Visible := True;

  btLimpar.Visible := True;
  edPesquisa.Visible := True;

end;

procedure TMainForm.meCepExit(Sender: TObject);
begin

 if ( meCep.Text ) <> '' then
  begin
    ACBrValidador1.Documento:= meCep.Text;
    ACBrValidador1.TipoDocto := docCEP;

    if not ACBrValidador1.Validar  then
    begin
     Application.MessageBox('ATENÇÃO:( CEP ) DIGITADO INVÁLIDO ',' ERRO NO PREENCHIMENTO DO CPF ',mb_Ok+MB_ICONERROR);
     meCep.Text := '';
     meCep.SetFocus;
     exit;
    end;


  end;




end;

procedure TMainForm.meCpfExit(Sender: TObject);
begin

  if ( meCpf.Text ) <> '' then
  begin

    ACBrValidador1.Documento:= meCpf.Text;
    ACBrValidador1.TipoDocto := docCPF;

    if not ACBrValidador1.Validar  then
    begin
     Application.MessageBox('ATENÇÃO:(CPF) DIGITADO INVÁLIDO ',' ERRO NO PREENCHIMENTO DO CPF ',mb_Ok+MB_ICONERROR);
     meCpf.Text := '';
     meCpf.SetFocus;
    end;


  end;

end;

procedure TMainForm.MenuItem1Click(Sender: TObject);
begin
 Close;
end;

procedure TMainForm.meUfExit(Sender: TObject);
begin
  if ( meUf.Text ) <> '' then
  begin
    ACBrValidador1.Documento:= meUf.Text;
    ACBrValidador1.TipoDocto := docUF;

    if not ACBrValidador1.Validar  then
    begin
     Application.MessageBox('ATENÇÃO: ESTADO (UF) DIGITADO INVÁLIDO ',' ERRO NO PREENCHIMENTO DA UF ',mb_Ok+MB_ICONERROR);
     meUf.Text := '';
     meUf.SetFocus;
    end;


  end;

end;

procedure TMainForm.RelatriodeProdutos1Click(Sender: TObject);
begin

  {passando nova consulta parar o relatorio}
  dmDados.FDQueryAuxiliar.Close;
  dmDados.FDQueryAuxiliar.SQL.Clear;
  dmDados.FDQueryAuxiliar.SQL.Add('select * from tblCadastro ') ;
  dmDados.FDQueryAuxiliar.Open;

  dmDados.rel_Cadastro.LoadFromFile(GetCurrentDir + '\Rel\RelDados.fr3');
  dmDados.rel_Cadastro.ShowReport();


end;

procedure TMainForm.sbAltClick(Sender: TObject);
begin
  xIncluindo := False;
  xEditando := True;

  edPesquisa.Visible := False;
  btLimpar.Visible := False;
  sbBUscar.Visible := False;

  // Visualizando a Tab2
  PageCadastro.ActivePage := Tab1; // Volta para a Tela de Consulta
  PageCadastro.Pages[0].TabVisible := False;
  PageCadastro.Pages[1].TabVisible := True;
  PageCadastro.Pages[2].TabVisible := False;

  // Visualizando Botao do Crud

  sbInc.Enabled := False;
  sbAlt.Enabled := False;
  sbExc.Enabled := False;
  sbVisualizar.Enabled := False;
  sbGrv.Visible := True;

  edNome.SetFocus;
  edNome.Text := dmDados.FDQueryJoinNome.Value;
  edNomeMae.Text := dmDados.FDQueryJoinNomeMae.Value;
  edNomePai.Text := dmDados.FDQueryJoinNomePai.Value;
  meCpf.Text := dmDados.FDQueryJoinCpf.Value;
  meRg.Text := dmDados.FDQueryJoinRg.Value;


  meCep.Text := dmDados.FDQueryJoinCep.Value;
  edEndereco.Text := dmDados.FDQueryJoinEndereco.Value;
  meUf.Text := dmDados.FDQueryJoinUf.Value;
  edCidade.Text := dmDados.FDQueryJoinCidade.Value;
  edNumero.Text := dmDados.FDQueryJoinNum.Value;

end;

procedure TMainForm.sbBUscarClick(Sender: TObject);
begin
  dmDados.FDQueryJoin.Close;
  dmDados.FDQueryJoin.SQL.Clear;
  dmDados.FDQueryJoin.SQL.Add('select tblCadastro.idCadastro, tblCadastro.Nome, tblCadastro.Cpf,');
  dmDados.FDQueryJoin.SQL.Add('tblCadastro.NomeMae, tblCadastro.NomePai, tblCadastro.Rg,');
  dmDados.FDQueryJoin.SQL.Add('tblEndereco.CodCadastro, tblEndereco.Cep, tblEndereco.Endereco,');
  dmDados.FDQueryJoin.SQL.Add('tblEndereco.Num, tblEndereco.Cidade, tblEndereco.Uf');
  dmDados.FDQueryJoin.SQL.Add('from tblCadastro');
  dmDados.FDQueryJoin.SQL.Add('join tblEndereco on tblCadastro.idCadastro=tblEndereco.CodCadastro');
  dmDados.FDQueryJoin.SQL.Add('where');
  dmDados.FDQueryJoin.SQL.Add('(Nome LIKE  '+QuotedStr('%'+edPesquisa.Text+'%') );
  dmDados.FDQueryJoin.SQL.Add('or Cpf LIKE  '+QuotedStr('%'+edPesquisa.Text+'%') );
  dmDados.FDQueryJoin.SQL.Add(')order by idCadastro ');
  dmDados.FDQueryJoin.Open;

end;

procedure TMainForm.sbCanClick(Sender: TObject);
begin
  edPesquisa.Visible := True;
  btLimpar.Visible := True;
  sbBUscar.Visible := True;

  PageCadastro.ActivePage := Tab1; // Volta para a Tela de Consulta
  PageCadastro.Pages[0].TabVisible := True;
  PageCadastro.Pages[1].TabVisible := False;
  PageCadastro.Pages[2].TabVisible := False;

  // Visualizando Botao do Crud
  sbInc.Enabled := True;
  sbAlt.Enabled := True;
  sbExc.Enabled := True;
  sbVisualizar.Enabled := True;

  dmDados.FDQueryCadastro.Cancel;
  PageCadastro.ActivePage := Tab1; // Volta para a Tela de Consulta
  PageCadastro.Pages[0].TabVisible := True;
  PageCadastro.Pages[1].TabVisible := False;

  dmDados.FDQueryJoin.Close();
  dmDados.FDQueryJoin.Open();

  // verifica se tem registro/ se nao => ele deixa ele desabilitado
  sbAlt.Enabled := dmDados.FDQueryJoin.RecordCount > 0;
  sbExc.Enabled := dmDados.FDQueryJoin.RecordCount > 0;
  sbVisualizar.Enabled := dmDados.FDQueryJoin.RecordCount > 0;

end;

procedure TMainForm.sbExcClick(Sender: TObject);
  var
  xErro : string;
  xId : Integer;

begin
  xId := dmDados.FDQueryJoinidCadastro.Value;

  If MessageDlg(' DESEJA Excluir '+dmDados.FDQueryJoinNome.Value+' ?',mtConfirmation,[mbyes,mbno],0) = mryes then

      begin

        dmDados.FDQueryAuxiliar.Close;
        dmDados.FDQueryAuxiliar.SQL.Clear;
        dmDados.FDQueryAuxiliar.SQL.Add('delete from tblCadastro where IdCadastro=:vIdCadastro');
        dmDados.FDQueryAuxiliar.Params[0].DataType := ftInteger;
        dmDados.FDQueryAuxiliar.Params[0].Value :=  xId;
        dmDados.FDQueryAuxiliar.ExecSQL( xErro );
        dmDados.FDQueryCadastro.Close();
        dmDados.FDQueryCadastro.Open();

        dmDados.FDQueryAuxiliar.Close;
        dmDados.FDQueryAuxiliar.SQL.Clear;
        dmDados.FDQueryAuxiliar.SQL.Add('delete from tblEndereco where CodCadastro=:vCodCadastro');
        dmDados.FDQueryAuxiliar.Params[0].DataType := ftInteger;
        dmDados.FDQueryAuxiliar.Params[0].Value :=  xId;

        dmDados.FDQueryAuxiliar.ExecSQL( xErro );
        dmDados.FDQueryEndereco.Close();
        dmDados.FDQueryEndereco.Open();

        dmDados.FDQueryJoin.Close();
        dmDados.FDQueryJoin.Open();
        exit;

      end
      else
      begin

        Exit;

      end;
end;

procedure TMainForm.sbGrvClick(Sender: TObject);
var
xErro : string;
I : Integer;

begin
  // pega ultimo registro
    dmDados.FDQueryAuxiliar.SQL.Clear;
    dmDados.FDQueryAuxiliar.SQL.Add('SELECT MAX(idCadastro) AS crescente FROM tblCadastro' );
    dmDados.FDQueryAuxiliar.Open;
    I :=  dmDados.FDQueryAuxiliar.fieldbyname('crescente').asinteger+1;

  if edNome.Text = '' then
    begin
      Application.MessageBox('DIGITE SEU NOME ',' ATENÇÃO ',mb_Ok+MB_ICONINFORMATION);
      PageCadastro.ActivePage := tab2; // Volta para a Tela de Consulta
      PageCadastro.Pages[0].TabVisible := False;
      PageCadastro.Pages[1].TabVisible := True;
      PageCadastro.Pages[2].TabVisible := False;

      edNome.SetFocus;
      exit;

    end;

    If MessageDlg(' DESEJA SALVAR ?',mtConfirmation,[mbyes,mbno],0) = mryes then
    begin

      if xIncluindo then
      begin
        // Dados Cadastro
        dmDados.FDQueryAuxiliar.Close;
        dmDados.FDQueryAuxiliar.SQL.Clear;
        dmDados.FDQueryAuxiliar.SQL.Add('insert into tblCadastro (idCadastro, Nome, Cpf, NomeMae, NomePai, Rg)');
        dmDados.FDQueryAuxiliar.SQL.Add('values(:vidCadastro, :vNome, :vCpf, :vNomeMae, :vNomePai, :vRg)');

        dmDados.FDQueryAuxiliar.Params[0].DataType := ftInteger;
        dmDados.FDQueryAuxiliar.Params[0].Value := I;

        dmDados.FDQueryAuxiliar.Params[1].DataType := ftString;
        dmDados.FDQueryAuxiliar.Params[1].Value := Trim(edNome.Text);

        dmDados.FDQueryAuxiliar.Params[2].DataType := ftString;
        dmDados.FDQueryAuxiliar.Params[2].Value := meCpf.Text;

        dmDados.FDQueryAuxiliar.Params[3].DataType := ftString;
        dmDados.FDQueryAuxiliar.Params[3].Value := Trim(edNomeMae.Text);

        dmDados.FDQueryAuxiliar.Params[4].DataType := ftString;
        dmDados.FDQueryAuxiliar.Params[4].Value := Trim(edNomePai.Text);

        dmDados.FDQueryAuxiliar.Params[5].DataType := ftString;
        dmDados.FDQueryAuxiliar.Params[5].Value := meRg.Text;

        dmDados.FDQueryAuxiliar.ExecSQL( xErro );
        dmDados.FDQueryCadastro.Close();
        dmDados.FDQueryCadastro.Open();

        // Dados Endereco
        dmDados.FDQueryAuxiliar.Close;
        dmDados.FDQueryAuxiliar.SQL.Clear;
        dmDados.FDQueryAuxiliar.SQL.Add('insert into tblEndereco (CodCadastro, Cep, Endereco, Num, Cidade, Uf )');
        dmDados.FDQueryAuxiliar.SQL.Add('values(:vCodCadastro, :vCep, :vEndereco, :vNum, :vCidade, :vUf)');

        dmDados.FDQueryAuxiliar.Params[0].DataType := ftInteger;
        dmDados.FDQueryAuxiliar.Params[0].Value := I;  // Cod do Cadastro

        dmDados.FDQueryAuxiliar.Params[1].DataType := ftString;
        dmDados.FDQueryAuxiliar.Params[1].Value := meCep.Text;

        dmDados.FDQueryAuxiliar.Params[2].DataType := ftString;
        dmDados.FDQueryAuxiliar.Params[2].Value := Trim(edEndereco.Text);

        dmDados.FDQueryAuxiliar.Params[3].DataType := ftString;
        dmDados.FDQueryAuxiliar.Params[3].Value := edNumero.Text;

        dmDados.FDQueryAuxiliar.Params[4].DataType := ftString;
        dmDados.FDQueryAuxiliar.Params[4].Value := Trim(edCidade.Text);

        dmDados.FDQueryAuxiliar.Params[5].DataType := ftString;
        dmDados.FDQueryAuxiliar.Params[5].Value := meUf.Text;

        dmDados.FDQueryAuxiliar.ExecSQL( xErro );
        dmDados.FDQueryEndereco.Close();
        dmDados.FDQueryEndereco.Open();


        dmDados.FDQueryJoin.Close();
        dmDados.FDQueryJoin.Open();


        PageCadastro.ActivePage := Tab1; // Volta para a Tela de Consulta
        PageCadastro.Pages[0].TabVisible := True;
        PageCadastro.Pages[1].TabVisible := False;
        PageCadastro.Pages[2].TabVisible := False;

        // Visualizando Botao do Crud
        sbInc.Enabled := True;
        sbAlt.Enabled := True;
        sbExc.Enabled := True;
        sbVisualizar.Enabled := False;

        edPesquisa.Visible := True;
        btLimpar.Visible := True;
        sbBUscar.Visible := True;

        xIncluindo := False;

      end;

      if xEditando then
      begin
        // dados Cadastro
        dmDados.FDQueryAuxiliar.Close;
        dmDados.FDQueryAuxiliar.SQL.Clear;
        dmDados.FDQueryAuxiliar.SQL.Add('update tblCadastro set Nome=:vNome, Cpf=:vCpf, NomeMae=:vNomeMae, NomePai=:vNomePai, Rg=:vRg where IdCadastro=:vIdCadastro');

        dmDados.FDQueryAuxiliar.Params[0].DataType := ftString;
        dmDados.FDQueryAuxiliar.Params[0].Value := edNome.Text;

        dmDados.FDQueryAuxiliar.Params[1].DataType := ftString;
        dmDados.FDQueryAuxiliar.Params[1].Value := meCpf.Text;

        dmDados.FDQueryAuxiliar.Params[2].DataType := ftString;
        dmDados.FDQueryAuxiliar.Params[2].Value := edNomeMae.Text;

        dmDados.FDQueryAuxiliar.Params[3].DataType := ftString;
        dmDados.FDQueryAuxiliar.Params[3].Value := edNomePai.Text;

        dmDados.FDQueryAuxiliar.Params[4].DataType := ftString;
        dmDados.FDQueryAuxiliar.Params[4].Value := meRg.Text;

        dmDados.FDQueryAuxiliar.Params[5].DataType := ftInteger;
        dmDados.FDQueryAuxiliar.Params[5].Value := dmDados.FDQueryJoinIdCadastro.Value;

        dmDados.FDQueryAuxiliar.ExecSQL( xErro );
        dmDados.FDQueryCadastro.Close();
        dmDados.FDQueryCadastro.Open();


        // dados Endereco
        dmDados.FDQueryAuxiliar.Close;
        dmDados.FDQueryAuxiliar.SQL.Clear;
        dmDados.FDQueryAuxiliar.SQL.Add('update tblEndereco set  Cep=:vCep, Endereco=:vEndereco, Num=:vNum, Cidade=:vCidade, Uf=:vUf where CodCadastro=:vCodCadastro');

        dmDados.FDQueryAuxiliar.Params[0].DataType := ftString;
        dmDados.FDQueryAuxiliar.Params[0].Value := meCep.Text;

        dmDados.FDQueryAuxiliar.Params[1].DataType := ftString;
        dmDados.FDQueryAuxiliar.Params[1].Value := edEndereco.Text;

        dmDados.FDQueryAuxiliar.Params[2].DataType := ftString;
        dmDados.FDQueryAuxiliar.Params[2].Value := edNumero.Text;

        dmDados.FDQueryAuxiliar.Params[3].DataType := ftString;
        dmDados.FDQueryAuxiliar.Params[3].Value := edCidade.Text;

        dmDados.FDQueryAuxiliar.Params[4].DataType := ftString;
        dmDados.FDQueryAuxiliar.Params[4].Value := meUf.Text;

        dmDados.FDQueryAuxiliar.Params[5].DataType := ftInteger;
        dmDados.FDQueryAuxiliar.Params[5].Value := dmDados.FDQueryJoinIdCadastro.Value;

        dmDados.FDQueryAuxiliar.ExecSQL( xErro );
        dmDados.FDQueryEndereco.Close();
        dmDados.FDQueryEndereco.Open();

        dmDados.FDQueryJoin.Close();
        dmDados.FDQueryJoin.Open();


        PageCadastro.ActivePage := Tab1; // Volta para a Tela de Consulta
        PageCadastro.Pages[0].TabVisible := True;
        PageCadastro.Pages[1].TabVisible := False;
        PageCadastro.Pages[2].TabVisible := False;

        // Visualizando Botao do Crud
        sbInc.Enabled := True;
        sbAlt.Enabled := True;
        sbExc.Enabled := True;
        sbVisualizar.Enabled := False;

        edPesquisa.Visible := True;
        btLimpar.Visible := True;
        sbBUscar.Visible := True;

        xEditando := False;

      end;

      edPesquisa.Visible := True;
      btLimpar.Visible := True;


    end
    else
    begin

        PageCadastro.ActivePage := Tab1; // Volta para a Tela de Consulta
        PageCadastro.Pages[0].TabVisible := True;
        PageCadastro.Pages[1].TabVisible := False;
        PageCadastro.Pages[2].TabVisible := False;

        // Visualizando Botao do Crud
        sbInc.Enabled := True;
        sbAlt.Enabled := True;
        sbExc.Enabled := True;
        sbVisualizar.Enabled := False;

        xIncluindo := False;
        xEditando :=  False;

        edPesquisa.Visible := True;
        btLimpar.Visible := True;

    end;

end;

procedure TMainForm.sbIncClick(Sender: TObject);
begin
  edPesquisa.Visible := False;
  btLimpar.Visible := False;
  sbBUscar.Visible := False;

  xIncluindo := True;
  xEditando := False;
  PageCadastro.ActivePage := Tab2;

  // Visualizando a Tab2
  PageCadastro.Pages[0].TabVisible := False;
  PageCadastro.Pages[1].TabVisible := Visible;
  PageCadastro.Pages[2].TabVisible := False;

  // Visualizando Botao do Crud
  sbInc.Enabled := False;
  sbAlt.Enabled := False;
  sbExc.Enabled := False;
  sbVisualizar.Enabled := False;
  sbGrv.Visible := True;

  // Limpa os botoes iniciais
  edNome.SetFocus;
  edNome.Text := '';
  edPesquisa.Text := '';
  edNome.Text := '';
  meCpf.Text := '';
  edNomeMae.Text := '';
  edNomePai.Text := '';
  meRg.Text := '';

  edEndereco.Text := '';
  edNumero.Text := '';
  meCep.Text := '';
  meUf.Text := '';
  edCidade.Text := '';

end;

procedure TMainForm.sbProximaClick(Sender: TObject);
begin
  PageCadastro.ActivePage := tab3; // Volta para a Tela de Consulta
  PageCadastro.Pages[0].TabVisible := False;
  PageCadastro.Pages[1].TabVisible := False;
  PageCadastro.Pages[2].TabVisible := True;
  meCep.SelectAll;
  meCep.SetFocus;

end;

procedure TMainForm.sbVisualizarClick(Sender: TObject);
begin

  edPesquisa.Visible := False;
  btLimpar.Visible := False;
  sbBUscar.Visible := False;

  // Visualizando a Tab2
  PageCadastro.ActivePage := Tab1; // Volta para a Tela de Consulta
  PageCadastro.Pages[0].TabVisible := False;
  PageCadastro.Pages[1].TabVisible := True;
  PageCadastro.Pages[2].TabVisible := False;

  // Visualizando Botao do Crud

  sbInc.Enabled := False;
  sbAlt.Enabled := False;
  sbExc.Enabled := False;
  sbVisualizar.Enabled := False;
  sbGrv.Visible := False;

  edNome.SetFocus;
  edNome.Text := dmDados.FDQueryJoinNome.Value;
  edNomeMae.Text := dmDados.FDQueryJoinNomeMae.Value;
  edNomePai.Text := dmDados.FDQueryJoinNomePai.Value;
  meCpf.Text := dmDados.FDQueryJoinCpf.Value;
  meRg.Text := dmDados.FDQueryJoinRg.Value;


  meCep.Text := dmDados.FDQueryJoinCep.Value;
  edEndereco.Text := dmDados.FDQueryJoinEndereco.Value;
  meUf.Text := dmDados.FDQueryJoinUf.Value;
  edCidade.Text := dmDados.FDQueryJoinCidade.Value;
  edNumero.Text := dmDados.FDQueryJoinNum.Value;

end;

procedure TMainForm.sbVoltarClick(Sender: TObject);
begin
  PageCadastro.ActivePage := tab2; // Volta para a Tela de Consulta
  PageCadastro.Pages[0].TabVisible := False;
  PageCadastro.Pages[1].TabVisible := True;
  PageCadastro.Pages[2].TabVisible := False;
end;

procedure TMainForm.SpeedButton1Click(Sender: TObject);
begin
  sbCanClick(Sender);
end;

end.
