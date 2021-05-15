unit Controle.GetDadosInterface;

interface

uses
  Model.DAO.GetTotalInterface,
  Model.Entidade.Gasto,
  Model.DAO.GetValorGastoPorTipoGasto,
  Model.DAO.Get;

type
  IControleGetDadosInterface = Interface
    function DadosGasto: IModelDAOGetTotalInterface<TEntidadeGasto, Double>;
    function ValorGastoPorTipoGasto: IModelDAOGet<TGasto>;
  end;

implementation

end.
