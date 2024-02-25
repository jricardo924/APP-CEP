unit EdtFocus;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.StdCtrls, vcl.Graphics;

type
  TEdtFocus = class(TEdit)
  private
    FMudarColor: Tcolor;
    procedure SetMudarColor(const Value: Tcolor);
    { Private declarations }
  protected
    { Protected declarations }
    procedure DoEnter; override;
    procedure DoExit; override;
  public
    { Public declarations }
    Constructor Create (AOwner: TComponent); override;
  published
    { Published declarations }
    property MudarColor : Tcolor read FMudarColor write SetMudarColor;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('MyComponents', [TEdtFocus]);
end;

{ TEdtFocus }

constructor TEdtFocus.Create(AOwner: TComponent);
begin
  inherited;
  FMudarColor := clWindow;
end;

procedure TEdtFocus.DoEnter;
begin
  inherited;
  Color := FMudarColor;
end;

procedure TEdtFocus.DoExit;
begin
  inherited;
  Color := clWindow;
end;

procedure TEdtFocus.SetMudarColor(const Value: Tcolor);
begin
  FMudarColor := Value;
end;

end.
