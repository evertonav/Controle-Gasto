unit Model.DAO.GetTipoGasto;

interface

uses
  Model.DAO.GetInterface,
  Model.Conexao,
  Model.Conexao.Interfaces,
  Data.DB;

type
  TTipoGasto = packed record
    Codigo: Integer;
    Nome: string;
  end;

  TModelDaoGetTipoGasto = class(TInterfacedObject, IModelDAOGet<TTipoGasto>)
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

{ TModelDaoGetTipoGasto }

constructor TModelDaoGetTipoGasto.Create;
begin
  FConexao := TModelConexao.Criar;
end;

function TModelDaoGetTipoGasto.Fim: Boolean;
begin
  Result := FQuery.Eof;
end;

function TModelDaoGetTipoGasto.Get: TTipoGasto;
begin
  Result.Codigo := FQuery.FieldByName('COD_TIPO_GASTO').AsInteger;
  Result.Nome := FQuery.FieldByName('NOME_TIPO_GASTO').AsString;
end;

function TModelDaoGetTipoGasto.Iniciar: IModelDAOGet<TTipoGasto>;
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

function TModelDaoGetTipoGasto.Proximo: IModelDAOGet<TTipoGasto>;
begin
  FQuery.Next;

  Result := Self;
end;

end.
