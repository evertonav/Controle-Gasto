unit Controller.Interfaces;

interface

uses
  Model.DAO.Interfaces,
  Model.Entidade.TipoGasto,
  Model.Entidade.Gasto;

type
  IControllerInterfaces = Interface
    function TipoGasto: IModelDAOInterface<TEntidadeTipoGasto>;
    function Gasto: IModelDAOInterface<TEntidadeGasto>;
  End;

implementation

end.
