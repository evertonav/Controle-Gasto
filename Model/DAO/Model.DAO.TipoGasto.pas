unit Model.DAO.TipoGasto;

interface

uses
  Model.Entidade.TipoGasto, DataModule, Model.Conexao.Interfaces,
  Model.Conexao.Firedac, Model.DAO.Interfaces;

type
  TModelDAOTipoGasto = class(TInterfacedObject, IModelDAOInterface<TEntidadeTipoGasto>)
  private
    FEntidadeTipoGasto: TEntidadeTipoGasto;
    FConexao: iModelConexaoInterfaces;
  public
    constructor Create;
    destructor Destroy; override;

    class function Criar: IModelDAOInterface<TEntidadeTipoGasto>;
    function Entidade: TEntidadeTipoGasto;
    function Inserir: IModelDAOInterface<TEntidadeTipoGasto>;
    function Deletar: IModelDAOInterface<TEntidadeTipoGasto>;
  end;

implementation

uses
  System.SysUtils;

{ TModelDAOTipoGasto }

constructor TModelDAOTipoGasto.Create;
begin
  FEntidadeTipoGasto := TEntidadeTipoGasto.Create(Self);
  FConexao := TModelConexaoFiredac.Criar;
end;

class function TModelDAOTipoGasto.Criar: IModelDAOInterface<TEntidadeTipoGasto>;
begin
  Result := TModelDAOTipoGasto.Create;
end;

function TModelDAOTipoGasto.Deletar: IModelDAOInterface<TEntidadeTipoGasto>;
begin
  raise Exception.Create('Sem implementação!');

  Result := Self;
end;

destructor TModelDAOTipoGasto.Destroy;
begin
  if Assigned(FEntidadeTipoGasto) then
    FEntidadeTipoGasto.DisposeOf;

  inherited
end;

function TModelDAOTipoGasto.Entidade: TEntidadeTipoGasto;
begin
  Result := FEntidadeTipoGasto;
end;

function TModelDAOTipoGasto.Inserir: IModelDAOInterface<TEntidadeTipoGasto>;
const
  C_SQL_INSERT_TIPO_GASTO = 'INSERT INTO TIPO_GASTO (NOME_TIPO_GASTO) '
                          + 'VALUES (:NOME_TIPO_GASTO)';
begin
  FConexao
    .AdicionarSQL(C_SQL_INSERT_TIPO_GASTO)
    .AdicionarParametros('NOME_TIPO_GASTO', FEntidadeTipoGasto.Descricao)
    .Executar;

  Result := Self;
end;

end.
