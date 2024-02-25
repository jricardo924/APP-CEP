unit Frm_Consulta_Cep_F1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.Mask, Vcl.DBCtrls, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ExtCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.UI.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.MongoDB, FireDAC.Phys.MongoDBDef, System.Rtti,
  System.JSON.Types, System.JSON.Readers, System.JSON.BSON, Consulta_Cep_L1,
  System.JSON.Builders, FireDAC.Phys.MongoDBWrapper, FireDAC.VCLUI.Wait,
  FireDAC.Comp.Client, FireDAC.Comp.DataSet, FireDAC.Phys.MongoDBDataSet, UTiposConsulta,
  EdtFocus;

type
  TForm_Consulta_Cep_F1 = class(TForm)
    Panel1: TPanel;
    lblCebecalho: TLabel;
    PageControl: TPageControl;
    aba_consultaPorCEP: TTabSheet;
    lbled_cepConsulta: TLabel;
    bt_consultarCEP: TButton;
    aba_consultaPorEndereco: TTabSheet;
    Label10: TLabel;
    lbled_cidadeConsulta: TLabel;
    lbled_logradouroConsulta: TLabel;
    bt_consultarEndereco: TButton;
    Memo_json: TMemo;
    LblRetornoServico: TLabel;
    lbldt_logradouro: TLabel;
    lbled_complemento: TLabel;
    lbled_Siafi: TLabel;
    lbled_bairro: TLabel;
    lbled_ibge: TLabel;
    lbled_localidade: TLabel;
    lbled_uf: TLabel;
    lbled_cep: TLabel;
    ed_complemento: TDBEdit;
    ed_Siafi: TDBEdit;
    ed_bairro: TDBEdit;
    ed_ibge: TDBEdit;
    ed_localidade: TDBEdit;
    ed_uf: TDBEdit;
    ed_cep: TDBEdit;
    PnlRodapé: TPanel;
    bt_limparCampos: TButton;
    bt_fechar: TButton;
    DbGridCEPCadastrado: TDBGrid;
    ds_Mongo: TDataSource;
    FMongoQry: TFDMongoQuery;
    FConMongo: TFDConnection;
    ed_logradouro: TDBEdit;
    ed_ufConsulta: TEdtFocus;
    ed_cidadeConsulta: TEdtFocus;
    ed_logradouroConsulta: TEdtFocus;
    ed_cepConsulta: TEdtFocus;
    procedure bt_fecharClick(Sender: TObject);
    procedure bt_limparCamposClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ed_cepConsultaExit(Sender: TObject);
    procedure ed_cepConsultaKeyPress(Sender: TObject; var Key: Char);
    procedure ed_cidadeConsultaExit(Sender: TObject);
    procedure ed_logradouroConsultaExit(Sender: TObject);
    procedure ed_ufConsultaExit(Sender: TObject);
    procedure bt_consultarCEPClick(Sender: TObject);
    procedure bt_consultarEnderecoClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    vptConsultaCepL1: TConsulta_Cep_L1;
    procedure pLimparCampos(Sender: TObject);
    procedure pVerificaCampos(TipoConsulta: TTipoConsulta);
    procedure mensagemAviso(mensagem: string);
    procedure raiseInformativo(mensagem: string);
    procedure pCarregaDadosCep;



  public
    { Public declarations }

  end;

var
  Form_Consulta_Cep_F1: TForm_Consulta_Cep_F1;

implementation

{$R *.dfm}

procedure TForm_Consulta_Cep_F1.bt_consultarCEPClick(Sender: TObject);
begin
  pLimparCampos(Sender);
  pVerificaCampos(tcCep);
  vptConsultaCepL1.pConsultaCep(tcCep);
  pCarregaDadosCep;

end;

procedure TForm_Consulta_Cep_F1.bt_consultarEnderecoClick(Sender: TObject);
begin
  pLimparCampos(Sender);
  pVerificaCampos(tcEndereco);
  vptConsultaCepL1.pConsultaCep(tcEndereco);
  pCarregaDadosCep;
end;

procedure TForm_Consulta_Cep_F1.bt_fecharClick(Sender: TObject);
begin
   Close;
end;

procedure TForm_Consulta_Cep_F1.bt_limparCamposClick(Sender: TObject);
begin
   pLimparCampos(Sender);
end;


procedure TForm_Consulta_Cep_F1.ed_cepConsultaExit(Sender: TObject);
begin
  ed_cepConsulta.Text := Trim(ed_cepConsulta.Text);
  vptConsultaCepL1.Cep := ed_cepConsulta.text;

end;

procedure TForm_Consulta_Cep_F1.ed_cepConsultaKeyPress(Sender: TObject;
  var Key: Char);
begin
   If key = #13 then
   Begin
      Key:= #0;
      Perform(Wm_NextDlgCtl,0,0);
   end;
end;

procedure TForm_Consulta_Cep_F1.ed_cidadeConsultaExit(Sender: TObject);
begin
  ed_cidadeConsulta.Text := Trim(ed_cidadeConsulta.Text);
  vptConsultaCepL1.Localidade := ed_cidadeConsulta.text;
end;

procedure TForm_Consulta_Cep_F1.ed_logradouroConsultaExit(Sender: TObject);
begin
  ed_logradouroConsulta.Text := Trim(ed_logradouroConsulta.Text);
  vptConsultaCepL1.Logradouro := ed_logradouroConsulta.text;
end;

procedure TForm_Consulta_Cep_F1.ed_ufConsultaExit(Sender: TObject);
begin
  ed_ufConsulta.Text := Trim(ed_ufConsulta.Text);
  vptConsultaCepL1.Uf := ed_ufConsulta.text;
end;

procedure TForm_Consulta_Cep_F1.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  //destroy a classe de controller
  vptConsultaCepL1.Destroy;
end;

procedure TForm_Consulta_Cep_F1.FormCreate(Sender: TObject);
begin
  PageControl.ActivePageIndex := aba_consultaPorCEP.TabIndex;
  Memo_json.Text := '';
  //Instacia a classe de controller
  vptConsultaCepL1 := TConsulta_Cep_L1.Create;
  vptConsultaCepL1.ConMongo := FConMongo;
  vptConsultaCepL1.MongoQry := FMongoQry;
  vptConsultaCepL1.MmoLog := Memo_json;
end;

procedure TForm_Consulta_Cep_F1.FormShow(Sender: TObject);
begin
   ed_cepConsulta.SetFocus;
end;

procedure TForm_Consulta_Cep_F1.mensagemAviso(mensagem: string);
begin
  Application.MessageBox(PChar(mensagem), '', MB_OK + MB_ICONERROR);
end;

procedure TForm_Consulta_Cep_F1.pCarregaDadosCep;
begin
   ed_cep.Text         := vptConsultaCepL1.Cep;
   ed_logradouro.Text  := vptConsultaCepL1.Logradouro;
   ed_localidade.Text  := UpperCase(vptConsultaCepL1.localidade);
   ed_bairro.Text      := vptConsultaCepL1.bairro;
   ed_uf.Text          := vptConsultaCepL1.uf;
   ed_complemento.Text := vptConsultaCepL1.complemento;
   ed_ibge.Text        := vptConsultaCepL1.ibge;
   ed_Siafi.Text       :=vptConsultaCepL1.Siafi;
end;

procedure TForm_Consulta_Cep_F1.pLimparCampos(Sender: TObject);
var
  I : integer;
begin
  for I := 0 to Self.ControlCount - 1 do
  begin
    if Self.Controls[I] is TDBEdit then
      TDBEdit(Self.Controls[I]).Clear;
  end;

  FMongoQry.Active := False;
  memo_json.Clear;
end;

procedure TForm_Consulta_Cep_F1.pVerificaCampos(tipoConsulta: TTipoConsulta);
begin
   if tipoConsulta = tcEndereco then
   begin
      if Length(Trim(ed_ufConsulta.Text)) <> 2 then
      begin
        mensagemAviso('O campo UF deve conter dois caracteres!');
        ed_logradouroConsulta.SetFocus;
        Exit;
      end;

      if Length(ed_cidadeConsulta.Text) < 3 then
      begin
        mensagemAviso('O campo Cidade deve conter pelo menos 3 caracteres!');
        ed_logradouroConsulta.SetFocus;
        Exit;
      end;

      if Length(ed_logradouroConsulta.Text) < 3 then
      begin
        mensagemAviso('O campo Logradouro deve conter pelo menos 3 caracteres!');
        ed_logradouroConsulta.SetFocus;
        Exit;
      end;
   end
   else
   if tipoConsulta = tcCep then
   begin
      if Length(ed_cepConsulta.Text) <> 8 then
      begin
        raiseInformativo('CEP inválido');
        ed_cepConsulta.SetFocus;
        exit;
      end;
   end;
end;

procedure TForm_Consulta_Cep_F1.raiseInformativo(mensagem: string);
begin
  raise Exception.Create(PChar(mensagem));
end;

end.


