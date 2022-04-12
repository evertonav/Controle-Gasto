unit Controller.GetDados.Interfaces;

interface

uses
  Model.DAO.GetTotal.Interfaces,
  Model.DAO.Get.Interfaces,
  Model.DAO.GetParametros.Interfaces,
  Model.Entidade.Gasto,
  Model.DAO.TipoGasto.GetValorGasto,
  Model.DAO.TipoGasto.Get,
  Model.DAO.Gasto.GetTotal;

type
  IControllerGetDadosInterfaces = Interface
    function DadosGasto: IModelDAOGetDadosGasto;
    function ValorGastoPorTipoGasto: IModelDaoGetParametros<TGasto>;
    function TipoGasto: IModelDAOGet<TTipoGasto>;
  end;

implementation

end.
