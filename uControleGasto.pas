unit uControleGasto;

interface

type
  TControleGasto = class
  private

  protected
    procedure InserirBanco(const pSQL: string;
                           const pParametros: array of Variant);
  end;

implementation

Uses
  DataModule;

{ TControleGasto }

procedure TControleGasto.InserirBanco(const pSQL: string;
  const pParametros: array of Variant);
begin
  dm.FDConn.ExecSQL(pSQL,
                    pParametros);
end;

end.
