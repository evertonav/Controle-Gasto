unit Controle.Interfaces;

interface

uses
  Model.DAO.Interfaces,
  Model.Entidade.TipoGasto;

type
  IControleInterfaces = Interface
    function TipoGasto: IModelDAOInterface<TEntidadeTipoGasto>;
  End;

implementation

end.
