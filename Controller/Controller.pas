unit Controller;

interface

uses
  Model.DAO.Gasto,
  Model.DAO.Interfaces,
  Model.Entidade.TipoGasto,
  Model.DAO.TipoGasto,
  Controller.Interfaces, Model.Entidade.Gasto;

type
  TController = class(TInterfacedObject, IControllerInterfaces)
  private
    FModelDAOGasto: TModelDAOGasto;
    FModelDAOTipoGasto: TModelDAOTipoGasto;
  public
    destructor Destroy; override;

    class function Criar: IControllerInterfaces;
    function Gasto: IModelDAOInterface<TEntidadeGasto>;
    function TipoGasto: IModelDAOInterface<TEntidadeTipoGasto>;
  end;

implementation

{ TController }

class function TController.Criar: IControllerInterfaces;
begin
  Result := Self.Create;
end;

destructor TController.Destroy;
begin

  inherited;
end;

function TController.Gasto: IModelDAOInterface<TEntidadeGasto>;
begin
  if not Assigned(FModelDAOGasto) then
    FModelDAOGasto := TModelDAOGasto.Create;

  Result := FModelDAOGasto;
end;

function TController.TipoGasto: IModelDAOInterface<TEntidadeTipoGasto>;
begin
  if not Assigned(FModelDAOTipoGasto) then
    FModelDAOTipoGasto := TModelDAOTipoGasto.Create;

  Result := FModelDAOTipoGasto;
end;

end.
