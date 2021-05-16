unit Model.DAO.Gasto.GetTotal;

interface

USES
  Model.Entidade.Gasto,
  Model.DAO.Gasto,
  Model.DAO.GetTotal.Interfaces,
  Model.Conexao.Interfaces;

type
  TModelDAOGastoGetDados = class(TInterfacedObject,
                                 IModelDAOGetTotal<TEntidadeGasto,
                                                            Double>)
  private
    FConexao: iModelConexaoInterfaces;
    FEntidadeGasto: TEntidadeGasto;
  public
    constructor Create;
    destructor Destroy; override;

    function Entidade: TEntidadeGasto;
    function GetTotal: Double;
  end;

implementation

uses
  Controller.Utils,
  System.DateUtils,
  System.SysUtils,
  Model.Conexao;

{ TModelDAOGastoGetDados }

constructor TModelDAOGastoGetDados.Create;
begin
  FEntidadeGasto := TEntidadeGasto.Create(TModelDAOGasto.Create);
  FConexao := TModelConexao.Criar;
end;

destructor TModelDAOGastoGetDados.Destroy;
begin
  if Assigned(FEntidadeGasto) then
    FEntidadeGasto.DisposeOf;

  inherited;
end;

function TModelDAOGastoGetDados.Entidade: TEntidadeGasto;
begin
  Result := FEntidadeGasto;
end;

function TModelDAOGastoGetDados.GetTotal: Double;
const
  CONST_SQL_GET_TOTAL = ' SELECT '
                      + '  SUM(VALOR_GASTO) AS VALOR_GASTO '
                      + ' FROM '
                      + '  GASTO '
                      + ' WHERE DATA_GASTO > :DATA_INI '
                      + '  AND DATA_GASTO < :DATA_FIM ';
var
  lTotalGasto: string;
begin
  lTotalGasto := FConexao
                   .AdicionarSQL(CONST_SQL_GET_TOTAL)
                     .AdicionarParametros('DATA_INI', Double(StartOfTheMonth(FEntidadeGasto.Data)))
                     .AdicionarParametros('DATA_FIM', Double(EndOfTheMonth(FEntidadeGasto.Data)))
                   .ExecutarRetornar.Fields[0].AsString;

  if Trim(lTotalGasto) = EmptyStr then
    Result := 0
  else
    Result := TFormatoNumeros.GetFormatoValidoFloat(lTotalGasto);
end;

end.
