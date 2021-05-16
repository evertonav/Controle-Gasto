unit Model.DAO.TipoGasto.Get;

interface

uses
  Model.DAO.Get.Interfaces,
  Model.Conexao,
  Model.Conexao.Interfaces,
  Data.DB;

type
  TTipoGasto = packed record
    Codigo: Integer;
    Nome: string;
  end;

  TModelDAOTipoGastoGet = class(TInterfacedObject, IModelDAOGet<TTipoGasto>)
  private
    FConexao: iModelConexaoInterfaces;
    FQuery: TDataSet;
  public
    constructor Create;

    function Iniciar: IModelDAOGet<TTipoGasto>;
    function Proximo: IModelDAOGet<TTipoGasto>;
    function Fim: Boolean;

    function Get: TTipoGasto;
  end;

implementation

{ TModelDAOTipoGastoGet }

constructor TModelDAOTipoGastoGet.Create;
begin
  FConexao := TModelConexao.Criar;
end;

function TModelDAOTipoGastoGet.Fim: Boolean;
begin
  Result := FQuery.Eof;
end;

function TModelDAOTipoGastoGet.Get: TTipoGasto;
begin
  Result.Codigo := FQuery.FieldByName('COD_TIPO_GASTO').AsInteger;
  Result.Nome := FQuery.FieldByName('NOME_TIPO_GASTO').AsString;
end;

function TModelDAOTipoGastoGet.Iniciar: IModelDAOGet<TTipoGasto>;
const
  CONST_GET_TIPO_GASTO = ' SELECT '
                       + '   COD_TIPO_GASTO, '
                       + '   NOME_TIPO_GASTO '
                       + ' FROM '
                       + '   TIPO_GASTO ';
begin
  FQuery := FConexao
              .AdicionarSQL(CONST_GET_TIPO_GASTO)
            .ExecutarRetornar;

  FQuery.First;

  Result := Self;
end;

function TModelDAOTipoGastoGet.Proximo: IModelDAOGet<TTipoGasto>;
begin
  FQuery.Next;

  Result := Self;
end;

end.
