unit Controle.GetDados;

interface

uses
  Controle.GetDadosInterface,
  Model.DAO.GetTotalInterface,
  Model.DAO.GetTotalGasto,
  Model.Entidade.Gasto,
  Model.DAO.GetValorGastoPorTipoGasto,
  Model.DAO.Get;

type
  TControleGetDados = class(TInterfacedObject, IControleGetDadosInterface)
  private
    FGetDadosGasto: TModelDAOGetDadosGasto;
    FValorGastoPorTipoGasto: TModelDaoGetValorGastoPorTipoGasto;
  public
    class function Criar: IControleGetDadosInterface;

    function DadosGasto: IModelDAOGetTotalInterface<TEntidadeGasto, Double>;
    function ValorGastoPorTipoGasto: IModelDAOGet<TGasto>;
  end;

implementation

{ TControleGetDados }

class function TControleGetDados.Criar: IControleGetDadosInterface;
begin
  Result := Self.Create;
end;

function TControleGetDados.DadosGasto: IModelDAOGetTotalInterface<TEntidadeGasto, Double>;
begin
  if not Assigned(FGetDadosGasto) then
    FGetDadosGasto := TModelDAOGetDadosGasto.Create;

  Result := FGetDadosGasto;
end;

function TControleGetDados.ValorGastoPorTipoGasto: IModelDAOGet<TGasto>;
begin
  if not Assigned(FValorGastoPorTipoGasto) then
    FValorGastoPorTipoGasto := TModelDaoGetValorGastoPorTipoGasto.Create;

  Result := FValorGastoPorTipoGasto;  
end;

end.
