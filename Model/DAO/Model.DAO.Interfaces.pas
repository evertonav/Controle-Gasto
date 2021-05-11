unit Model.DAO.Interfaces;

interface

type
  IModelDAOInterface<T> = interface
    function Entidade: T;
    function Inserir: IModelDAOInterface<T>;
    function Deletar: IModelDAOInterface<T>;
  end;

implementation

end.
