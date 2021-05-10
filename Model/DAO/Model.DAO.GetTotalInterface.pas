unit Model.DAO.GetTotalInterface;

interface

type
  IModelDAOGetTotalInterface<E, T> = interface
    function Entidade: E;
    function GetTotal: T;
  end;

implementation

end.
