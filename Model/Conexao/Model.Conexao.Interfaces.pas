unit Model.Conexao.Interfaces;

interface

type
  iModelConexaoInterfaces = interface
    function AdicionarSQL(const pSQL: string): iModelConexaoInterfaces;

    function AdicionarParametros(const pNomeParametro: string;
                                 const pValue: Variant): iModelConexaoInterfaces;

    function Executar: iModelConexaoInterfaces;
  end;

implementation

end.
