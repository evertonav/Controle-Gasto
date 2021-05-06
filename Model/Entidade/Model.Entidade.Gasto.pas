unit Model.Entidade.Gasto;

interface

Uses
  uControleGasto, uTipoGasto;

type
  TEntidadeGasto = class
  private
    FValor: Double;
    FTipoGasto: Integer;
    FData: TDate;
    procedure SetData(const Value: TDate);
    procedure SetTipoGasto(const Value: Integer);
    procedure SetValor(const Value: Double);
  public
    property Data: TDate read FData write SetData;
    property Valor: Double read FValor write SetValor;
    property Tipo: Integer read FTipoGasto write SetTipoGasto;
  end;

implementation

Uses
  System.SysUtils, DataModule, System.DateUtils, FMX.DialogService,
  FireDAC.Stan.Param, Data.DB, uUtils;

{ TGasto }

procedure TEntidadeGasto.SetData(const Value: TDate);
begin
  FData := Value;
end;

procedure TEntidadeGasto.SetTipoGasto(const Value: Integer);
begin
  FTipoGasto := Value;
end;

procedure TEntidadeGasto.SetValor(const Value: Double);
begin
  if Value > 0 then
    FValor := Value
  else
    raise Exception.Create('Digite um valor válido!');
end;

end.
