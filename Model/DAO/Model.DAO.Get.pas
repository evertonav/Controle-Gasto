unit Model.DAO.Get;

interface

Uses
  Data.DB;

type
  IModelDAOGet<T> = interface
    function DataInicial(const pValor: TDate): IModelDAOGet<T>;
    function DataFinal(const pValor: TDate): IModelDAOGet<T>;

    function Iniciar: IModelDAOGet<T>;
    function Proximo: IModelDAOGet<T>;
    function Fim: Boolean;

    function Get: T;
  end;

implementation

end.
