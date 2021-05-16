unit Controle.GetDados;

interface

uses
  Controle.GetDadosInterface,
  Model.DAO.GetInterface,
  Model.DAO.GetTotalInterface,
  Model.DAO.GetParametrosInterface,
  Model.DAO.GetTotalGasto,
  Model.Entidade.Gasto,
  Model.DAO.GetTipoGasto,
  Model.DAO.GetValorGastoPorTipoGasto;

type
  TControleGetDados = class(TInterfacedObject, IControleGetDadosInterface)
  private
    FGetDadosGasto: TModelDAOGetDadosGasto;
    FValorGastoPorTipoGasto: TModelDaoGetValorGastoPorTipoGasto;
    FTipoGasto: TModelDaoGetTipoGasto;
  public
    class function Criar: IControleGetDadosInterface;

    function DadosGasto: IModelDAOGetTotalInterface<TEntidadeGasto, Double>;
    function ValorGastoPorTipoGasto: IModelDaoGetParametros<TGasto>;
    function TipoGasto: IModelDAOGet<TTipoGasto>;
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

function TControleGetDados.TipoGasto: IModelDAOGet<TTipoGasto>;
begin
  if not Assigned(FTipoGasto) then
    FTipoGasto := TModelDaoGetTipoGasto.Create;

  Result := FTipoGasto;
end;

function TControleGetDados.ValorGastoPorTipoGasto: iModelDaoGetParametros<TGasto>;
begin
  if not Assigned(FValorGastoPorTipoGasto) then
    FValorGastoPorTipoGasto := TModelDaoGetValorGastoPorTipoGasto.Create;

  Result := FValorGastoPorTipoGasto;  
end;

end.
