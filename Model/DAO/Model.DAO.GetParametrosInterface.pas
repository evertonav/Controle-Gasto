unit Model.DAO.GetParametrosInterface;

interface

uses
  Model.DAO.GetInterface;

type
  IModelDaoGetParametros<T> = interface
    function DataInicial(const pValor: TDate): iModelDaoGetParametros<T>;
    function DataFinal(const pValor: TDate): iModelDaoGetParametros<T>;

    function Execucao: IModelDAOGet<T>;
  end;

implementation

end.
