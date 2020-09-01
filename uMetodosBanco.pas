unit uMetodosBanco;

interface

Uses
  DataModule, System.SysUtils, System.IOUtils, Messages, FMX.Dialogs;

type
  TConexaoBanco = class(Tdm)
  private
    procedure ConectarBancoIOS;

    procedure ConectarBancoAndroid;

    procedure ConectarBancoWindows;
  public
    procedure ConectarBanco;
  end;

implementation

{ TConexaoBanco }

procedure TConexaoBanco.ConectarBanco;
begin
  {$IFDEF IOS}
  ConectarBancoIOS;
  {$ENDIF}

  {$IFDEF ANDROID}
  ConectarBancoAndroid;
  {$ENDIF}

  {$IFDEF MSWINDOWS}
  ConectarBancoWindows;
  {$ENDIF}
end;

procedure TConexaoBanco.ConectarBancoAndroid;
begin
  {$IFDEF ANDROID}
  FDConn.Params.Values['DriverID'] := 'SQLite';
  try
    FDConn.Connected := False;
    FDConn.Params.Values['Database'] := TPath.Combine(TPath.GetDocumentsPath, 'Datashop.db');
    FDConn.Connected := True;
  except on E:Exception do
    raise Exception.Create('Erro de conexão com o banco de dados: ' + E.Message);
  end;
  {$ENDIF}
end;

procedure TConexaoBanco.ConectarBancoIOS;
begin
  {$IFDEF IOS}
  FDConn.Params.Values['DriverID'] := 'SQLite';
  try
    FDConn.Connected := False;
    FDConn.Params.Values['Database'] := TPath.Combine(TPath.GetDocumentsPath, 'Datashop.db');
    FDConn.Connected := true;
  except
  on E:Exception do
    raise Exception.Create('Erro de conexão com o banco de dados: ' + E.Message);
  end;
  {$ENDIF}
end;

procedure TConexaoBanco.ConectarBancoWindows;
begin
  ShowMessage(ExtractFileDir(GetCurrentDir));

  try
    FDConn.Connected := False;
    FDConn.Params.Values['Database'] := ExtractFileDir(GetCurrentDir)  ;
    FDConn.Connected := true;
  except
  on E: Exception do
    raise Exception.Create('Erro de conexão com o banco de dados: ' + E.Message);
  end;
end;

end.
