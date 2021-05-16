unit Controle.GetDadosInterface;

interface

uses
  Model.DAO.GetTotalInterface,
  Model.DAO.GetInterface,
  Model.DAO.GetParametrosInterface,
  Model.Entidade.Gasto,
  Model.DAO.GetValorGastoPorTipoGasto,
  Model.DAO.GetTipoGasto;

type
  IControleGetDadosInterface = Interface
    function DadosGasto: IModelDAOGetTotalInterface<TEntidadeGasto, Double>;
    function ValorGastoPorTipoGasto: IModelDaoGetParametros<TGasto>;
    function TipoGasto: IModelDAOGet<TTipoGasto>;
  end;

implementation

end.
