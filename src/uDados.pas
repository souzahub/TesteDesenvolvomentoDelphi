unit uDados;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Data.Win.ADODB,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MSSQL,
  FireDAC.Phys.MSSQLDef, FireDAC.VCLUI.Wait, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, frxClass, frxDBSet, frxGradient,
  frxExportBaseDialog, frxExportPDF;

type
  TdmDados = class(TDataModule)
    FDConexao: TFDConnection;
    FDQueryCadastro: TFDQuery;
    FDQueryAuxiliar: TFDQuery;
    rel_ds_cadastro: TfrxDBDataset;
    rel_Cadastro: TfrxReport;
    FDQueryEndereco: TFDQuery;
    frxPDFExport1: TfrxPDFExport;
    FDQueryJoin: TFDQuery;
    FDQueryJoinidCadastro: TIntegerField;
    FDQueryJoinNome: TWideStringField;
    FDQueryJoinCpf: TWideStringField;
    FDQueryJoinNomeMae: TWideStringField;
    FDQueryJoinNomePai: TWideStringField;
    FDQueryJoinRg: TWideStringField;
    FDQueryJoinCodCadastro: TIntegerField;
    FDQueryJoinCep: TStringField;
    FDQueryJoinEndereco: TWideStringField;
    FDQueryJoinNum: TWideStringField;
    FDQueryJoinCidade: TWideStringField;
    FDQueryJoinUf: TWideStringField;
    FDQueryCadastroidCadastro: TIntegerField;
    FDQueryCadastroNome: TWideStringField;
    FDQueryCadastroCpf: TWideStringField;
    FDQueryCadastroNomeMae: TWideStringField;
    FDQueryCadastroNomePai: TWideStringField;
    FDQueryCadastroRg: TWideStringField;
    FDQueryEnderecoCodCadastro: TIntegerField;
    FDQueryEnderecoCep: TStringField;
    FDQueryEnderecoEndereco: TWideStringField;
    FDQueryEnderecoNum: TWideStringField;
    FDQueryEnderecoCidade: TWideStringField;
    FDQueryEnderecoUf: TWideStringField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmDados: TdmDados;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
