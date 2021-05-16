unit Controller.GetDados;

interface

uses
  Controller.GetDados.Interfaces,
  Model.DAO.Get.Interfaces,
  Model.DAO.GetTotal.Interfaces,
  Model.DAO.GetParametros.Interfaces,
  Model.DAO.Gasto.GetTotal,
  Model.Entidade.Gasto,
  Model.DAO.TipoGasto.Get,
  Model.DAO.TipoGasto.GetValorGasto;

type
  TControllerGetDados = class(TInterfacedObject, IControllerGetDadosInterfaces)
  private
    FGetDadosGasto: TModelDAOGastoGetDados;
    FValorGastoPorTipoGasto: TModelDaoTipoGastoGetValorGasto;
    FTipoGasto: TModelDAOTipoGastoGet;
  public
    class function Criar: IControllerGetDadosInterfaces;

    function DadosGasto: IModelDAOGetTotal<TEntidadeGasto, Double>;
    function ValorGastoPorTipoGasto: IModelDaoGetParametros<TGasto>;
    function TipoGasto: IModelDAOGet<TTipoGasto>;
  end;

implementation

{ TControllerGetDados }

class function TControllerGetDados.Criar: IControllerGetDadosInterfaces;
begin
  Result := Self.Create;
end;

function TControllerGetDados.DadosGasto: IModelDAOGetTotal<TEntidadeGasto, Double>;
begin
  if not Assigned(FGetDadosGasto) then
    FGetDadosGasto := TModelDAOGastoGetDados.Create;

  Result := FGetDadosGasto;
end;

function TControllerGetDados.TipoGasto: IModelDAOGet<TTipoGasto>;
begin
  if not Assigned(FTipoGasto) then
    FTipoGasto := TModelDAOTipoGastoGet.Create;

  Result := FTipoGasto;
end;

function TControllerGetDados.ValorGastoPorTipoGasto: iModelDaoGetParametros<TGasto>;
begin
  if not Assigned(FValorGastoPorTipoGasto) then
    FValorGastoPorTipoGasto := TModelDAOTipoGastoGetValorGasto.Create;

  Result := FValorGastoPorTipoGasto;  
end;

end.
