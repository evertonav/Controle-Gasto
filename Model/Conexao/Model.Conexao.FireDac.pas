unit Model.Conexao.FireDac;

interface

uses
  FireDAC.Comp.Client,
  Model.Conexao.Interfaces,
  Data.DB,
  FireDAC.Stan.Def,
  FireDAC.DApt,
  FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteDef,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.Phys.SQLite,
  FireDAC.FMXUI.Wait,
  FireDAC.DatS,
  FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet;

type
  TModelConexaoFiredac = class(TInterfacedObject, iModelConexaoInterfaces)
  private
    FConexao: TFDConnection;
    FQuery: TFDQuery;

    function Conectar: Boolean;
  public
    constructor Create;
    destructor Destroy; override;

    function AdicionarSQL(const pSQL: string): iModelConexaoInterfaces;

    function AdicionarParametros(const pNomeParametro: string;
                                 const pValue: Variant): iModelConexaoInterfaces;

    function ExecutarRetornar: TDataSet;
    function Executar: iModelConexaoInterfaces;

    class function Criar : iModelConexaoInterfaces;
  end;

implementation

uses
  System.SysUtils, FireDAC.Stan.Param
  {$IFDEF ANDROID}
    ,System.IOUtils
  {$ENDIF};

{ TModelConexaoFiredac }

function TModelConexaoFiredac.AdicionarParametros(const pNomeParametro: string;
  const pValue: Variant): iModelConexaoInterfaces;
begin
  FQuery.Params.ParamByName(pNomeParametro).Value := pValue;

  Result := Self;
end;

function TModelConexaoFiredac.AdicionarSQL(const pSQL: string): iModelConexaoInterfaces;
begin
  FQuery.SQL.Clear;
  FQuery.SQL.Add(pSQL);

  Result := Self;
end;

function TModelConexaoFiredac.Conectar: Boolean;
begin
  {$IFDEF ANDROID}
  FConexao.Params.Values['DriverID'] := 'SQLite';
  try
    FConexao.Connected := False;
    FConexao.Params.Values['Database'] := TPath.Combine(TPath.GetDocumentsPath, 'Datashop.db');
    FConexao.Connected := True;
  except on E:Exception do
    raise Exception.Create('Erro de conexão com o banco de dados: ' + E.Message);
  end;
  {$ENDIF}

  {$IFDEF MSWINDOWS}
  FConexao.Params.Values['DriverID'] := 'SQLite';
  try
    FConexao.Connected := False;
    FConexao.Params.Values['Database'] := 'C:\Controle\DB\Datashop.db';
    FConexao.Connected := true;
  except
    on E: Exception do
      raise Exception.Create('Erro de conexão com o banco de dados: ' + E.Message);
  end;
  {$ENDIF}

  Result := FConexao.Connected;
end;

constructor TModelConexaoFiredac.Create;
begin
  FConexao := TFDConnection.Create(nil);

  if not Conectar then
    raise Exception.Create('Não foi possível conectar ao banco de dados!');

  FQuery := TFDQuery.Create(nil);
  FQuery.Connection := FConexao;
end;

class function TModelConexaoFiredac.Criar: iModelConexaoInterfaces;
begin
  Result := Self.Create;
end;

destructor TModelConexaoFiredac.Destroy;
begin
  if Assigned(FConexao) then
    FConexao.DisposeOf;

  if Assigned(FQuery) then
    FQuery.DisposeOf;
end;

function TModelConexaoFiredac.ExecutarRetornar: TDataSet;
begin
  FQuery.Open;

  Result := FQuery;
end;

function TModelConexaoFiredac.Executar: iModelConexaoInterfaces;
begin
  FQuery.ExecSQL;

  Result := Self;
end;

end.
