unit uGasto;

interface

Uses
  uControleGasto, uTipoGasto;

type
  TGasto = class(TControleGasto)
  private
    FValor: Double;
    FTipoGasto: Integer;
    FData: TDate;
    procedure SetData(const Value: TDate);
    procedure SetTipoGasto(const Value: Integer);
    procedure SetValor(const Value: Double);

  public
    function GetTotalGasto: Double;

    property Data: TDate read FData write SetData;
    property Valor: Double read FValor write SetValor;
    property Tipo: Integer read FTipoGasto write SetTipoGasto;

    procedure InserirGasto;
  end;

implementation

Uses
  System.SysUtils, DataModule, System.DateUtils, FMX.DialogService,
  FireDAC.Stan.Param, Data.DB;

{ TGasto }

function TGasto.GetTotalGasto: Double;
begin
  dm.qrGetTotalGasto.Close;

  if not dm.qrGetTotalGasto.Prepared then
    dm.qrGetTotalGasto.Prepare;

  dm.qrGetTotalGasto.Params.ParamByName('DATA_INI').AsFloat := StartOfTheMonth(Data);
  dm.qrGetTotalGasto.Params.ParamByName('DATA_FIM').AsFloat := EndOfTheMonth(Data);

  dm.qrGetTotalGasto.Open;

  if dm.qrGetTotalGasto.Fields[0].AsString = EmptyStr then
    Result := 0
  else
    Result := dm.qrGetTotalGasto.Fields[0].AsCurrency;
end;

procedure TGasto.InserirGasto;
const
  CONST_SQL_GASTO = 'INSERT INTO GASTO ('
                  + '             DATA_GASTO,'
                  + '            COD_TIPO_GASTO,'
                  + '            VALOR_GASTO'
                  + '        )'
                  + '        VALUES ('
                  + '            :DATA_GASTO,'
                  + '            :COD_TIPO_GASTO,'
                  + '            :VALOR_GASTO'
                  + '       ) ';

begin
  InserirBanco(CONST_SQL_GASTO,
               [FData, FTipoGasto, FValor]);
end;

procedure TGasto.SetData(const Value: TDate);
begin
  FData := Value;
end;

procedure TGasto.SetTipoGasto(const Value: Integer);
begin
  FTipoGasto := Value;
end;

procedure TGasto.SetValor(const Value: Double);
begin
  if Value > 0 then
    FValor := Value
  else
    raise Exception.Create('Digite um valor válido!');
end;

end.
