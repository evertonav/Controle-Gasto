unit Model.DAO.Gasto.GetTotal;

interface

USES
  Model.Entidade.Gasto,
  Model.DAO.Gasto,
  Model.DAO.GetTotal.Interfaces,
  Model.Conexao.Interfaces;

type
  IModelDAOGetDadosGasto = interface
    function DataInicial(const pValor: TDate): IModelDAOGetDadosGasto;
    function DataFinal(const pValor: TDate): IModelDAOGetDadosGasto;
    function Total: Double;
  end;

  TModelDAOGastoGetDados = class(TInterfacedObject,
                                 IModelDAOGetDadosGasto)
  private
    FConexao: iModelConexaoInterfaces;
    FDataInicial: TDate;
    FDataFinal: TDate;
  public
    constructor Create;
    destructor Destroy; override;

    function DataInicial(const pValor: TDate): IModelDAOGetDadosGasto;
    function DataFinal(const pValor: TDate): IModelDAOGetDadosGasto;
    function Total: Double;
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
  FConexao := TModelConexao.Criar;
end;

function TModelDAOGastoGetDados.DataFinal(
  const pValor: TDate): IModelDAOGetDadosGasto;
begin
  FDataFinal := pValor;
end;

function TModelDAOGastoGetDados.DataInicial(
  const pValor: TDate): IModelDAOGetDadosGasto;
begin
  FDataInicial := pValor;
end;

destructor TModelDAOGastoGetDados.Destroy;
begin

  inherited;
end;

function TModelDAOGastoGetDados.Total: Double;
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
                     .AdicionarParametros('DATA_INI', Double(FDataInicial))
                     .AdicionarParametros('DATA_FIM', Double(FDataFinal))
                   .ExecutarRetornar.Fields[0].AsString;

  if Trim(lTotalGasto) = EmptyStr then
    Result := 0
  else
    Result := TFormatoNumeros.GetFormatoValidoFloat(lTotalGasto);
end;

end.
