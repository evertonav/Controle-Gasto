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
  Result := 0;
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
    raise Exception.Create('Digite um valor v�lido!');
end;

end.
