unit uTipoGasto;

interface

Uses
  uControleGasto;

type
  TTipoGasto = class(TControleGasto)
  private
    FTipoGasto: string;
    FCodTipoGasto: Integer;

    procedure SetTipoGasto(const Value: string);
    procedure SetCodTipoGasto(const Value: Integer);
  public
    property Codigo: Integer read FCodTipoGasto write SetCodTipoGasto;
    property Descricao: string read FTipoGasto write SetTipoGasto;

    procedure InserirTipoGasto;
  end;

implementation

Uses
  System.SysUtils;

{ TTipoGasto }

procedure TTipoGasto.InserirTipoGasto;
const
  C_SQL_INSERT_TIPO_GASTO = 'INSERT INTO TIPO_GASTO (NOME_TIPO_GASTO) '
                          + 'VALUES (:NOME_TIPO_GASTO)';
begin
  InserirBanco(C_SQL_INSERT_TIPO_GASTO,
               [FTipoGasto]);
end;

procedure TTipoGasto.SetCodTipoGasto(const Value: Integer);
begin
  FCodTipoGasto := Value;
end;

procedure TTipoGasto.SetTipoGasto(const Value: string);
begin
  if Trim(Value) <> Emptystr then
    FTipoGasto := Value
  else
    raise Exception.Create('Preencha corretamente o tipo de gasto!');
end;

end.
