unit Controle.GetDados;

interface

uses
  Controle.GetDadosInterface,
  Model.DAO.GetTotalInterface,
  Model.DAO.GetTotalGasto,
  Model.Entidade.Gasto;

type
  TControleGetDados = class(TInterfacedObject, IControleGetDadosInterface)
  private
    FGetDadosGasto: TModelDAOGetDadosGasto;
  public
    class function Criar: IControleGetDadosInterface;
    function DadosGasto: IModelDAOGetTotalInterface<TEntidadeGasto, Double>;
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

end.
