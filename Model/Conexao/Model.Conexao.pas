unit Model.Conexao;

interface

uses
  Model.Conexao.Interfaces,
  Model.Conexao.FireDac;

type
  TModelConexao = class
  public
    class function Criar: iModelConexaoInterfaces;
  end;

implementation

{ TModelConexao }

class function TModelConexao.Criar: iModelConexaoInterfaces;
begin
  Result := TModelConexaoFiredac.Create;
end;

end.
