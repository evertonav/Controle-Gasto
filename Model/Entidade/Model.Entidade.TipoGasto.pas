unit
  Model.Entidade.TipoGasto;

interface

uses
  Model.DAO.Interfaces;

type
  TEntidadeTipoGasto = class
  private
    [weak] //Para não da memory leak quando tem referência cruzada(MODELDAO tem uma instancia e essa classe também.
    FModelDaoInterface: IModelDAOInterface<TEntidadeTipoGasto>;
    FDescricao: string;
    FCodTipoGasto: Integer;
  public
    constructor Create(pModelDAOInterface: IModelDAOInterface<TEntidadeTipoGasto>);
    destructor Destroy; override;

    function Codigo(const pValor: Integer): TEntidadeTipoGasto; overload;
    function Codigo: Integer; overload;

    function Descricao(pValor: string): TEntidadeTipoGasto; overload;
    function Descricao: string; overload;

    function ModelDAOTipoGasto: IModelDAOInterface<TEntidadeTipoGasto>;
  end;

implementation

uses
  System.SysUtils;

{ TEntidadeTipoGasto }

function TEntidadeTipoGasto.Codigo(const pValor: Integer): TEntidadeTipoGasto;
begin
  FCodTipoGasto := pValor;
  Result := Self;
end;

function TEntidadeTipoGasto.Codigo: Integer;
begin
  Result := FCodTipoGasto;
end;

constructor TEntidadeTipoGasto.Create(
  pModelDAOInterface: IModelDAOInterface<TEntidadeTipoGasto>);
begin
  FModelDaoInterface := pModelDAOInterface;
end;

function TEntidadeTipoGasto.Descricao: string;
begin
  Result := FDescricao;
end;

destructor TEntidadeTipoGasto.Destroy;
begin

end;

function TEntidadeTipoGasto.Descricao(pValor: string): TEntidadeTipoGasto;
begin
  if Trim(pValor) = Emptystr then
    raise Exception.Create('Preencha corretamente o tipo de gasto!');

  FDescricao := pValor;

  Result := Self;
end;

function TEntidadeTipoGasto.ModelDAOTipoGasto: IModelDAOInterface<TEntidadeTipoGasto>;
begin
  Result := FModelDaoInterface;
end;

end.
