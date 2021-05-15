unit Model.DAO.GetValorGastoPorTipoGasto;

interface

Uses
  //Model.DAO.GetValor,
  Model.Conexao.Interfaces,
  Model.Conexao,
  Data.DB,
  Model.Entidade.Gasto,
  Model.DAO.Get;

type
  TGasto = packed record
    CodigoTipoGasto: Integer;
    ValorGasto: Double;
    NomeTipoGasto: string;
  end;

  TModelDaoGetValorGastoPorTipoGasto = class(TInterfacedObject, IModelDAOGet<TGasto>)
   private
     FConexao: iModelConexaoInterfaces;
     FDataInicial: TDate;
     FDataFinal: TDate;
     FQuery: TDataSet;
   public
      constructor Create;

      class function Criar: IModelDAOGet<TGasto>;

      function DataInicial(const pValor: TDate): IModelDAOGet<TGasto>;
      function DataFinal(const pValor: TDate): IModelDAOGet<TGasto>; overload;

      function Iniciar: IModelDAOGet<TGasto>;
      function Proximo: IModelDAOGet<TGasto>;
      function Fim: Boolean;

      function Get: TGasto;
  end;

implementation

{ TModelDaoGetValorGastoPorTipoGasto }

constructor TModelDaoGetValorGastoPorTipoGasto.Create;
begin
  FConexao := TModelConexao.Criar;
end;

class function TModelDaoGetValorGastoPorTipoGasto.Criar: IModelDAOGet<TGasto>;
begin
  Result := Self.Create;
end;

function TModelDaoGetValorGastoPorTipoGasto.Fim: Boolean;
begin
  Result := FQuery.Eof;
end;

function TModelDaoGetValorGastoPorTipoGasto.Get: TGasto;
begin
  Result.CodigoTipoGasto := FQuery.FieldByName('COD_TIPO_GASTO').AsInteger;
  Result.ValorGasto :=  FQuery.FieldByName('VALOR_GASTO').AsFloat;
  Result.NomeTipoGasto := FQuery.FieldByName('NOME_TIPO_GASTO').AsString;
end;

function TModelDaoGetValorGastoPorTipoGasto.DataFinal(
  const pValor: TDate): IModelDAOGet<TGasto>;
begin
  FDataFinal := pValor;

  Result := Self;
end;

function TModelDaoGetValorGastoPorTipoGasto.DataInicial(
  const pValor: TDate): IModelDAOGet<TGasto>;
begin
  FDataInicial := pValor;

  Result := Self;
end;

function TModelDaoGetValorGastoPorTipoGasto.Iniciar: IModelDAOGet<TGasto>;
const
  CONST_GET_VALOR_GASTO_POR_TIPO_GASTO = ' SELECT '
                                       + '  SUM(G.VALOR_GASTO) AS VALOR_GASTO, '
                                       + '  TP.NOME_TIPO_GASTO, '
                                       + '  TP.COD_TIPO_GASTO '
                                       + ' FROM '
                                       + '   GASTO G '
                                       + ' JOIN '
                                       + '   TIPO_GASTO TP ON TP.COD_TIPO_GASTO = G.COD_TIPO_GASTO '
                                       + ' WHERE DATA_GASTO >= :DATA_INI '
                                       + '   AND DATA_GASTO <= :DATA_FIM '
                                       + ' GROUP BY '
                                       + '   TP.NOME_TIPO_GASTO, '
                                       + '   TP.COD_TIPO_GASTO ';
begin
  FQuery := FConexao
              .AdicionarSQL(CONST_GET_VALOR_GASTO_POR_TIPO_GASTO)
              .AdicionarParametros('DATA_INI', FDataInicial)
              .AdicionarParametros('DATA_FIM', FDataFinal)
            .ExecutarRetornar;

  FQuery.First;

  Result := Self;
end;

function TModelDaoGetValorGastoPorTipoGasto.Proximo: IModelDAOGet<TGasto>;
begin
  FQuery.Next;

  Result := Self;
end;

end.
