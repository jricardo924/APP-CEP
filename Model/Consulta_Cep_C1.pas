unit Consulta_Cep_C1;
{ Camada de Controller }

interface
uses
  System.JSON, FireDAC.Phys.MongoDBDataSet, FireDAC.Stan.Option, System.SysUtils, 
  UTiposConsulta, FireDAC.Comp.Client, FireDAC.Phys.MongoDBWrapper, FireDAC.Stan.Intf,
  FireDAC.Phys.MongoDB, Vcl.StdCtrls;

type
  TConsulta_Cep_C1 = class(TObject)

  private
    //Variaveis de ambiente
    FCep: String;
    FLogradouro : string;
    FComplemento : string;
    FBairro : string;
    FLocalidade : string;
    FUf : string;
    FSiafi : string;
    FIBGE : string;
    FMmoLog: TMemo;
    FMongoQry: TFDMongoQuery;
    FConMongo: TFDConnection;
    FDPhysMongoDriverLink1: TFDPhysMongoDriverLink;
    //Get�s
    function GetCep: String;
    function GetLogradouro: String;
    function GetBairro: String;
    function GetComplemento: String;
    function GetIbge: String;
    function GetLocalidade: String;
    function GetSiafi: String;
    function GetUf: String;
    //Set�s
    procedure SetCep(const Value: String);
    procedure SetBairro(const Value: String);
    procedure SetComplemento(const Value: String);
    procedure SetIbge(const Value: String);
    procedure SetLocalidade(const Value: String);
    procedure SetLogradouro(const Value: String);
    procedure SetSiafi(const Value: String);
    procedure SetUf(const Value: String);

    
    //Procedures private         

    function GetConMongo: TFDConnection;
    procedure SetConMongo(const Value: TFDConnection);
    function GetMongoQry: TFDMongoQuery;
    procedure SetMongoQry(const Value: TFDMongoQuery);
    function GetMmoLog: TMemo;
    procedure SetMmoLog(const Value: TMemo);
    
    //Functions private

  public
    FTipoConsulta: TTipoConsulta;
    constructor Create;
    destructor Destroy;  override;
    //Procedures Publicas                            
    procedure pCarregaDadosCadastrados;
    procedure pGravaDadosMongoDb(jsonObject: TJSONObject);

    //Functions Publicas
    function fConsultaCepMongo(TipoConsulta: TTipoConsulta):Boolean;
    //Property
    property Cep: String read GetCep write SetCep;
    property Logradouro: String read GetLogradouro write SetLogradouro;
    property Complemento: String read GetComplemento write SetComplemento;
    property Bairro: String read GetBairro write SetBairro;
    property Localidade: String read GetLocalidade write SetLocalidade;
    property Uf: String read GetUf write SetUf;
    property Siafi: String read GetSiafi write SetSiafi;
    property Ibge: String read GetIbge write SetIbge;
    property MmoLog: TMemo read GetMmoLog write SetMmoLog;

    property ConMongo: TFDConnection read GetConMongo write SetConMongo;
    property MongoQry: TFDMongoQuery read GetMongoQry write SetMongoQry;

  end;
implementation

{ TConsulta_Cep_C1 }


{ TConsulta_Cep_C1 }

constructor TConsulta_Cep_C1.Create;
begin
   //

end;

destructor TConsulta_Cep_C1.Destroy;
begin
  FConMongo.Free;
  inherited Destroy;
end;

function TConsulta_Cep_C1.fConsultaCepMongo(TipoConsulta: TTipoConsulta): Boolean;
Var
   vlsConsulta: String;
begin
  if TipoConsulta = tcEndereco then
  begin
    vlsConsulta := '{"uf": "'+FUf+'", "localidade": "'+FLocalidade+'", "logradouro": "'+FLogradouro+'"}';
  end
  else
  begin
    vlsConsulta := '{"cep": "'+FCep+'"}';
  end;

  FMongoQry.FetchOptions.Mode := fmAll;
  FMongoQry.CachedUpdates := True;
  FMongoQry.Close;
  FMongoQry.QMatch := vlsConsulta;
  FMongoQry.Open;

  Result := not FMongoQry.IsEmpty;
end;

function TConsulta_Cep_C1.GetLogradouro: String;
begin
   Result := Flogradouro;
end;

function TConsulta_Cep_C1.GetBairro: String;
begin
   Result := Fbairro;
end;

function TConsulta_Cep_C1.GetCep: String;
begin
   Result := FCEP;
end;

function TConsulta_Cep_C1.GetComplemento: String;
begin
   Result := Fbairro;
end;

function TConsulta_Cep_C1.GetConMongo: TFDConnection;
begin
  if not Assigned(FConMongo) then
  begin
    FConMongo := TFDConnection.Create(nil);
  end;
  Result := FConMongo;
end;

function TConsulta_Cep_C1.GetIbge: String;
begin
   Result := FIbge;
end;

function TConsulta_Cep_C1.GetLocalidade: String;
begin
   Result := FLocalidade;
end;

function TConsulta_Cep_C1.GetMmoLog: TMemo;
begin
   Result := FMmoLog;
end;

function TConsulta_Cep_C1.GetMongoQry: TFDMongoQuery;
begin
  if not Assigned(FMongoQry) then
  begin
    FMongoQry := TFDMongoQuery.Create(nil);
  end;
  Result := FMongoQry;
end;

function TConsulta_Cep_C1.GetSiafi: String;
begin
   Result := FSiafi;
end;



function TConsulta_Cep_C1.GetUf: String;
begin
   Result := FUf;
end;

procedure TConsulta_Cep_C1.pCarregaDadosCadastrados;
begin
   FCep         := FMongoQry.FieldByName('cep').AsString;
   FLogradouro  := FMongoQry.FieldByName('logradouro').AsString;
   FLocalidade  := UpperCase(FMongoQry.FieldByName('localidade').AsString);
   FBairro      := FMongoQry.FieldByName('bairro').AsString;
   FUf          := FMongoQry.FieldByName('uf').AsString;
   FComplemento := FMongoQry.FieldByName('complemento').AsString;
   FIBGE        := FMongoQry.FieldByName('ibge').AsString;
   FSiafi       := FMongoQry.FieldByName('siafi').AsString;
end;


procedure TConsulta_Cep_C1.pGravaDadosMongoDb(jsonObject: TJSONObject);
var
  doc: TMongoDocument;
begin
  // Verificar se o objeto JSON � nulo
  if not Assigned(jsonObject) then
    Exit;

  try
    // Verificar se o objeto JSON tem as chaves esperadas
    if not (jsonObject.GetValue('logradouro') is TJSONString) then
      Exit; // ou trate o erro de alguma outra forma

    // Criar um documento MongoDB e adicionar os campos
    doc := TMongoDocument.Create(TMongoConnection(FConMongo.CliObj).Env).
      Add('logradouro', UpperCase(jsonObject.GetValue('logradouro').Value)).
      Add('cep', StringReplace(jsonObject.GetValue('cep').Value, '-', '', [rfReplaceAll])).
      Add('localidade', UpperCase(jsonObject.GetValue('localidade').Value)).
      Add('bairro', UpperCase(jsonObject.GetValue('bairro').Value)).
      Add('uf', UpperCase(jsonObject.GetValue('uf').Value)).
      Add('complemento', UpperCase(jsonObject.GetValue('complemento').Value)).
      Add('ibge', UpperCase(jsonObject.GetValue('ibge').Value)).
      Add('siafi', UpperCase(jsonObject.GetValue('siafi').Value));

    // Inserir o documento no MongoDB
    FMongoQry.Collection.Insert(doc);
  finally
    // Liberar a mem�ria do documento
    doc.Free;
  end;
end;



procedure TConsulta_Cep_C1.SetBairro(const Value: String);
begin
   FBairro := Value;
end;

procedure TConsulta_Cep_C1.SetCep(const Value: String);
begin
   FCep := Value;
end;

procedure TConsulta_Cep_C1.SetComplemento(const Value: String);
begin
   FComplemento := Value;
end;

procedure TConsulta_Cep_C1.SetConMongo(const Value: TFDConnection);
begin
   FConMongo := Value;
end;

procedure TConsulta_Cep_C1.SetIbge(const Value: String);
begin
   FIBGE := Value;
end;

procedure TConsulta_Cep_C1.SetLocalidade(const Value: String);
begin
   FLocalidade := Value;
end;

procedure TConsulta_Cep_C1.SetLogradouro(const Value: String);
begin
   FLogradouro := Value;
end;

procedure TConsulta_Cep_C1.SetMmoLog(const Value: TMemo);
begin
   FMmoLog := Value;
end;

procedure TConsulta_Cep_C1.SetMongoQry(const Value: TFDMongoQuery);
begin
   FMongoQry := Value;
end;

procedure TConsulta_Cep_C1.SetSiafi(const Value: String);
begin
   FSiafi := Value;
end;


procedure TConsulta_Cep_C1.SetUf(const Value: String);
begin
   FUf := Value;
end;

end.

