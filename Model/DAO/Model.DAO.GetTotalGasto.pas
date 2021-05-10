unit Model.DAO.GetTotalGasto;

interface

USES
  Model.Entidade.Gasto,
  Model.DAO.Gasto,
  Model.DAO.GetTotalInterface,
  Model.Conexao.Interfaces;

type
  TModelDAOGetDadosGasto = class(TInterfacedObject,
                                 IModelDAOGetTotalInterface<TEntidadeGasto,
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
  DataModule, uUtils, System.DateUtils, System.SysUtils, FireDAC.Stan.Param,
  Model.Conexao.FireDac;

{ TModelDAOGetDadosGasto }

constructor TModelDAOGetDadosGasto.Create;
begin
  FEntidadeGasto := TEntidadeGasto.Create(TModelDAOGasto.Create);
  FConexao := TModelConexaoFiredac.Criar;
end;

destructor TModelDAOGetDadosGasto.Destroy;
begin
  if Assigned(FEntidadeGasto) then
    FEntidadeGasto.DisposeOf;

  inherited;
end;

function TModelDAOGetDadosGasto.Entidade: TEntidadeGasto;
begin
  Result := FEntidadeGasto;
end;

function TModelDAOGetDadosGasto.GetTotal: Double;
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
