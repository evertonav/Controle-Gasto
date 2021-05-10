unit Model.Conexao.Interfaces;

interface

uses
  Data.DB;

type
  iModelConexaoInterfaces = interface
    function AdicionarSQL(const pSQL: string): iModelConexaoInterfaces;

    function AdicionarParametros(const pNomeParametro: string;
                                 const pValue: Variant): iModelConexaoInterfaces;

    function ExecutarRetornar: TDataSet;
    function Executar: iModelConexaoInterfaces;
  end;

implementation

end.
