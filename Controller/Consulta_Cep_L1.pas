unit Consulta_Cep_L1;
{ Camada de Controller }

interface
  uses Consulta_Cep_C1, System.JSON, UTiposConsulta, FireDAC.Comp.Client,
  FireDAC.Phys.MongoDBDataSet, System.Net.HttpClient, UControllerRabbitMQ_L1,
  ACBrSocket, System.Classes, System.SysUtils, Vcl.StdCtrls, IdHTTP, IdSSLOpenSSL;

type

  TConsulta_Cep_L1 = class(TObject)

   private
    FConsultaCepC1: TConsulta_Cep_C1;
    FControllerRabbitMQ: TUControllerRabbitMQ_L1;
    FConMongo: TFDConnection;
    FMongoQry: TFDMongoQuery;
    FMsgRabbitMQ: String;
    //Procedures Privadas

    //Functions Privadas
    function fRemoveColchetes(JsonString:String): String;
    function fEnviaRabbiMqAutorizado(JsonString:String): Boolean;
    function fGetDados(TipoConsulta:TTipoConsulta): TJSONObject;
    function removerAcentuacao(str: string): string;

    //Get�s
    function GetLogradouro: String;
    function GetBairro: String;
    function GetCep: String;
    function GetComplemento: String;
    function GetIbge: String;
    function GetLocalidade: String;
    function GetSiafi: String;
    function GetUf: String;
    //Set�s
    procedure SetBairro(const Value: String);
    procedure SetCep(const Value: String);
    procedure SetComplemento(const Value: String);
    procedure SetIbge(const Value: String);
    procedure SetLocalidade(const Value: String);
    procedure SetLogradouro(const Value: String);
    procedure SetSiafi(const Value: String);
    procedure SetUf(const Value: String);
    function GetConsulta_Cep_C1: TConsulta_Cep_C1;
    function GetConMongo: TFDConnection;
    procedure SetConMongo(const Value: TFDConnection);
    function GetMongoQry: TFDMongoQuery;
    procedure SetMongoQry(const Value: TFDMongoQuery);
    function GetMmoLog: TMemo;
    procedure SetMmoLog(const Value: TMemo);
    function GetUControllerRabbitMQ: TUControllerRabbitMQ_L1;

    //Property privadas
    property Consulta_Cep_C1: TConsulta_Cep_C1 read GetConsulta_Cep_C1;
    property ControllerRabbitMQ: TUControllerRabbitMQ_L1 read GetUControllerRabbitMQ;

   public
    constructor Create;
    destructor Destroy; override;

    //Procedures Publicas
    procedure pConsultaCep(TipoConsulta:TTipoConsulta);

    //Functions Publicas

    //Property Publicas
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

{ TConsulta_Cep_L1 }



constructor TConsulta_Cep_L1.Create;
begin
   //Instacia a classe de Model
   Consulta_Cep_C1.Create;
end;

destructor TConsulta_Cep_L1.Destroy;
begin
  //destroy a classe de Model
   Consulta_Cep_C1.Free;
  inherited;
end;

function TConsulta_Cep_L1.fEnviaRabbiMqAutorizado(JsonString:String): Boolean;
var
   msgRabbit: String;
begin
   FMsgRabbitMQ := '';
   MmoLog.Lines.Add('Enviando requisi��o para fila do RabbitMQ...');
   Result := False;

   ControllerRabbitMQ.ConectandoRabbitMQ;

   ControllerRabbitMQ.EnviarMsgRabbitMQ(JsonString);

   ControllerRabbitMQ.VerificaMensagens;
   FMsgRabbitMQ := ControllerRabbitMQ.MsgRecebida;

   if Trim(FMsgRabbitMQ) <> '' then
     Result := True;


end;

function TConsulta_Cep_L1.fGetDados(TipoConsulta: TTipoConsulta): TJSONObject;
var
  IdHTTP: TIdHTTP;
  Response: TStringStream;
  RetornoJson: TJSONObject;
  JsonString: String;
begin
  IdHTTP := TIdHTTP.Create(nil);
  Response := TStringStream.Create;
  try
    try
      IdHTTP.IOHandler := TIdSSLIOHandlerSocketOpenSSL.Create(IdHTTP);
      TIdSSLIOHandlerSocketOpenSSL(IdHTTP.IOHandler).SSLOptions.SSLVersions := [sslvTLSv1_2];

      MmoLog.Lines.Add('Efetuando request no WS...');
      if tipoConsulta = tcCep then
      begin
        IdHTTP.Request.ContentType := 'application/json';
        Response.WriteString(IdHTTP.Get('https://viacep.com.br/ws/' + cep + '/json'));
      end
      else if tipoConsulta = tcEndereco then
      begin
        IdHTTP.Request.ContentType := 'application/json';
        Response.WriteString(IdHTTP.Get('https://viacep.com.br/ws/' + Uf + '/' +
             removerAcentuacao(Localidade) + '/' + removerAcentuacao(Logradouro) + '/json'));
      end;

      if IdHTTP.ResponseCode = 200 then
      begin
        MmoLog.Lines.Add('Dados encontrados no WS...');
        JsonString :=  fRemoveColchetes(Response.DataString);

        MmoLog.Lines.Add('Desserializa��o Json: ');
        RetornoJson := TJSONObject.ParseJSONValue(JsonString) as TJSONObject;

        if Assigned(RetornoJson) then
        begin
          if RetornoJson.GetValue('erro').Value = 'true' then
            raise Exception.Create('CEP ou Endere�o inexistente!')
        end
        else raise Exception.Create('CEP ou Endere�o inexistente!');

        MmoLog.Lines.Add(Response.DataString);

        Result := RetornoJson;
      end
      else
        raise Exception.Create('CEP ou Endere�o inexistente!');
    except
      on E: Exception do
      begin
        MmoLog.Lines.Add('Ocorreu um erro ao consultar o ViaCEP: ' + E.Message);
        raise Exception.Create('Ocorreu um erro ao consultar o ViaCEP: ' + E.Message);
      end;
    end;
  finally
    IdHTTP.Free;
    Response.Free;
  end;
end;

function TConsulta_Cep_L1.fRemoveColchetes(JsonString: String): String;
begin
  while (Length(JsonString) > 0) and (JsonString[1] = '[') do
    Delete(JsonString, 1, 1);

  while (Length(JsonString) > 0) and (JsonString[Length(JsonString)] = ']') do
    Delete(JsonString, Length(JsonString), 1);

  Result := JsonString;
end;

function TConsulta_Cep_L1.GetLogradouro: String;
begin
   Result := Consulta_Cep_C1.Logradouro;
end;

function TConsulta_Cep_L1.GetBairro: String;
begin
   Result := Consulta_Cep_C1.Bairro;
end;

function TConsulta_Cep_L1.GetCep: String;
begin
   Result := Consulta_Cep_C1.Cep;
end;

function TConsulta_Cep_L1.GetComplemento: String;
begin
   Result := Consulta_Cep_C1.Complemento;
end;

function TConsulta_Cep_L1.GetConMongo: TFDConnection;
begin
   Result := Consulta_Cep_C1.ConMongo;
end;

function TConsulta_Cep_L1.GetConsulta_Cep_C1: TConsulta_Cep_C1;
begin
  if not Assigned(FConsultaCepC1) then
  begin
    FConsultaCepC1 := TConsulta_Cep_C1.Create;
  end;
  Result := FConsultaCepC1;
end;

function TConsulta_Cep_L1.GetIbge: String;
begin
   Result := Consulta_Cep_C1.Ibge;
end;

function TConsulta_Cep_L1.GetLocalidade: String;
begin
   Result := Consulta_Cep_C1.Localidade;
end;

function TConsulta_Cep_L1.GetMmoLog: TMemo;
begin
   Result := Consulta_Cep_C1.MmoLog;
end;

function TConsulta_Cep_L1.GetMongoQry: TFDMongoQuery;
begin
   Result := Consulta_Cep_C1.MongoQry;
end;

function TConsulta_Cep_L1.GetSiafi: String;
begin
   Result := Consulta_Cep_C1.Siafi;
end;

function TConsulta_Cep_L1.GetUControllerRabbitMQ: TUControllerRabbitMQ_L1;
begin
  if not Assigned(FControllerRabbitMQ) then
  begin
    FControllerRabbitMQ := TUControllerRabbitMQ_L1.Create;
  end;
  Result := FControllerRabbitMQ;
end;

function TConsulta_Cep_L1.GetUf: String;
begin
   Result := Consulta_Cep_C1.Uf;
end;


procedure TConsulta_Cep_L1.pConsultaCep(TipoConsulta: TTipoConsulta);
var
  jsonString: String;
  jsonRetornadosWS: TJSONObject;
begin
   //Consulta no banco primeiro se o cep existe
   if not Consulta_Cep_C1.fConsultaCepMongo(TipoConsulta) then
   begin
      MmoLog.Lines.Add('Registro n�o cadastrado base de dados...');

      //Function que obtem dados no WS e retorna JSON
      jsonRetornadosWS :=  fGetDados(TipoConsulta);

      if JsonRetornadosWS.Count > 0 then
      begin
        //Desserializa��o Json
        jsonString := jsonRetornadosWS.ToString;
        //Envio o json em string para requisi��o no RabbatMQ
        if fEnviaRabbiMqAutorizado(jsonString) then
        begin
           MmoLog.Lines.Add('Requisi��o autorizada pelo RabbitMQ...');
           //Grava dados retornados do RabbitMQ para o MongoDB
           MmoLog.Lines.Add('Gravando dados na base de dados (Mongodb)...');
           MmoLog.Lines.Add('');
           Consulta_Cep_C1.pGravaDadosMongoDb(jsonRetornadosWS);
           MmoLog.Lines.Add('Registro gravado...');

           //Carrega Dados no MongoDB
           Consulta_Cep_C1.fConsultaCepMongo(TipoConsulta);
           Consulta_Cep_C1.pCarregaDadosCadastrados;
        end;
      end;
   end
   else
   begin
      MmoLog.Lines.Add('Dados existentes na base de dados...');
      MmoLog.Lines.Add('');
      MmoLog.Lines.Add('Carregando dados da base de dados...');
      //Caso cep esteja cadastrado no banco, carrega info. sem consultar no WS
      Consulta_Cep_C1.pCarregaDadosCadastrados;
      MmoLog.Lines.Add('Dados atualizados...');
   end;
end;

function TConsulta_Cep_L1.removerAcentuacao(str: string): string;
var
  x: Integer;
const
  ComAcento = '����������������������������';
  SemAcento = 'aaeouaoaeioucuAAEOUAOAEIOUCU';
begin
  for x := 1 to Length(Str) do

    if Pos(Str[x], ComAcento) <> 0 then
      Str[x] := SemAcento[Pos(Str[x], ComAcento)];

  Str := StringReplace(Str, ' ', '%20', [rfReplaceAll]);

  Result := Str;
end;

procedure TConsulta_Cep_L1.SetBairro(const Value: String);
begin
   Consulta_Cep_C1.Bairro := Value;
end;

procedure TConsulta_Cep_L1.SetCep(const Value: String);
begin
   Consulta_Cep_C1.Cep := Value;
end;

procedure TConsulta_Cep_L1.SetComplemento(const Value: String);
begin
   Consulta_Cep_C1.Complemento := Value;
end;

procedure TConsulta_Cep_L1.SetConMongo(const Value: TFDConnection);
begin
   Consulta_Cep_C1.ConMongo := Value;
end;

procedure TConsulta_Cep_L1.SetIbge(const Value: String);
begin
   Consulta_Cep_C1.Ibge := Value;
end;

procedure TConsulta_Cep_L1.SetLocalidade(const Value: String);
begin
   Consulta_Cep_C1.Localidade := Value;
end;

procedure TConsulta_Cep_L1.SetLogradouro(const Value: String);
begin
   Consulta_Cep_C1.Logradouro := Value;
end;

procedure TConsulta_Cep_L1.SetMmoLog(const Value: TMemo);
begin
  Consulta_Cep_C1.MmoLog := Value;
end;

procedure TConsulta_Cep_L1.SetMongoQry(const Value: TFDMongoQuery);
begin
   Consulta_Cep_C1.MongoQry := Value;
end;

procedure TConsulta_Cep_L1.SetSiafi(const Value: String);
begin
   Consulta_Cep_C1.Siafi := Value;
end;

procedure TConsulta_Cep_L1.SetUf(const Value: String);
begin
   Consulta_Cep_C1.Uf := Value;
end;

end.
