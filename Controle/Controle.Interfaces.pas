unit Controle.Interfaces;

interface

uses
  Model.DAO.Interfaces,
  Model.Entidade.TipoGasto,
  Model.Entidade.Gasto;

type
  IControleInterfaces = Interface
    function TipoGasto: IModelDAOInterface<TEntidadeTipoGasto>;
    function Gasto: IModelDAOInterface<TEntidadeGasto>;
  End;

implementation

end.
