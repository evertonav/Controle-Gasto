unit Controller.GetDados.Interfaces;

interface

uses
  Model.DAO.GetTotal.Interfaces,
  Model.DAO.Get.Interfaces,
  Model.DAO.GetParametros.Interfaces,
  Model.Entidade.Gasto,
  Model.DAO.TipoGasto.GetValorGasto,
  Model.DAO.TipoGasto.Get;

type
  IControllerGetDadosInterfaces = Interface
    function DadosGasto: IModelDAOGetTotal<TEntidadeGasto, Double>;
    function ValorGastoPorTipoGasto: IModelDaoGetParametros<TGasto>;
    function TipoGasto: IModelDAOGet<TTipoGasto>;
  end;

implementation

end.
