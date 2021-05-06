unit Controle;

interface

uses
  Model.DAO.Gasto, Model.DAO.Interfaces, Model.Entidade.TipoGasto,
  Model.DAO.TipoGasto, Controle.Interfaces;

type
  TControle = class(TInterfacedObject, IControleInterfaces)
  private
    //FModelDAOGasto: TModelDAOGasto;
    FModelDAOTipoGasto: TModelDAOTipoGasto;
  public
    destructor Destroy; override;

    class function Criar: IControleInterfaces;
    //function Gasto: TModelDAOGasto;
    function TipoGasto: IModelDAOInterface<TEntidadeTipoGasto>;
  end;

implementation

{ TController }

class function TControle.Criar: IControleInterfaces;
begin
  Result := Self.Create;
end;

destructor TControle.Destroy;
begin
  {if Assigned(FModelDAOGasto) then
    FModelDAOGasto.Destroy;}

  inherited;
end;

{function TControle.Gasto: TModelDAOGasto;
begin
  if not Assigned(FModelDAOGasto) then
    FModelDAOGasto := TModelDAOGasto.Create;

  Result := FModelDAOGasto;
end;   }

function TControle.TipoGasto: IModelDAOInterface<TEntidadeTipoGasto>;
begin
  if not Assigned(FModelDAOTipoGasto) then
    FModelDAOTipoGasto := TModelDAOTipoGasto.Create;

  Result := FModelDAOTipoGasto;
end;

end.
