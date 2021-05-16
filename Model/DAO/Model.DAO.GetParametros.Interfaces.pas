unit Model.DAO.GetParametros.Interfaces;

interface

uses
  Model.DAO.Get.Interfaces;

type
  IModelDAOGetParametros<T> = interface
    function DataInicial(const pValor: TDate): IModelDAOGetParametros<T>;
    function DataFinal(const pValor: TDate): IModelDAOGetParametros<T>;

    function Execucao: IModelDAOGet<T>;
  end;

implementation

end.
