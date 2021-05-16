unit Model.DAO.Get.Interfaces;

interface

Uses
  Data.DB;

type
  IModelDAOGet<T> = interface
    function Iniciar: IModelDAOGet<T>;
    function Proximo: IModelDAOGet<T>;
    function Fim: Boolean;

    function Get: T;
  end;

implementation

end.
