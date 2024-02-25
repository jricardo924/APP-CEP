program App_Consulta_Cep_WS;

uses
  Vcl.Forms,
  Frm_Consulta_Cep_F1 in 'View\Frm_Consulta_Cep_F1.pas' {Form_Consulta_Cep_F1},
  Consulta_Cep_L1 in 'Controller\Consulta_Cep_L1.pas',
  Consulta_Cep_C1 in 'Model\Consulta_Cep_C1.pas',
  UTiposConsulta in 'Controller\UTiposConsulta.pas',
  StompClient in 'features\StompClient.pas',
  UControllerRabbitMQ_L1 in 'Controller\UControllerRabbitMQ_L1.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm_Consulta_Cep_F1, Form_Consulta_Cep_F1);
  Application.Run;
end.
