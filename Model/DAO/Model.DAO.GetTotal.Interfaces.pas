unit Model.DAO.GetTotal.Interfaces;

interface

type
  IModelDAOGetTotal<E, T> = interface
    function Entidade: E;
    function GetTotal: T;
  end;

implementation

end.
