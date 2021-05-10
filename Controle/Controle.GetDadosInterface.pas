unit Controle.GetDadosInterface;

interface

uses
  Model.DAO.GetTotalInterface,
  Model.Entidade.Gasto;

type
  IControleGetDadosInterface = Interface
    function DadosGasto: IModelDAOGetTotalInterface<TEntidadeGasto, Double>;
  end;

implementation

end.
