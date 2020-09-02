unit DataModule;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.FMXUI.Wait, Data.DB, FireDAC.Comp.Client, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet,
  system.IOUtils, FMX.Dialogs, FMX.Forms;

type
  Tdm = class(TDataModule)
    FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink;
    FDConn: TFDConnection;
    qrGetTipoGasto: TFDQuery;
    qrGetGastos: TFDQuery;
    qrDeletar: TFDQuery;
    qrGetTotalGasto: TFDQuery;
    qrGetGastoUnitario: TFDQuery;
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  private
    procedure ConectarBancoIOS;

    procedure ConectarBancoAndroid;

    procedure ConectarBancoWindows;
  public
    procedure ConectarBanco;
  end;

var
  dm: Tdm;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

procedure Tdm.ConectarBanco;
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

procedure Tdm.ConectarBancoAndroid;
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

procedure Tdm.ConectarBancoIOS;
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

procedure Tdm.ConectarBancoWindows;
begin
  {$IFDEF MSWINDOWS}
  try
    FDConn.Connected := False;
    FDConn.Params.Values['Database'] := 'C:\Controle\DB\Datashop.db';
    FDConn.Connected := true;
  except
  on E: Exception do
    raise Exception.Create('Erro de conexão com o banco de dados: ' + E.Message);
  end;
  {$ENDIF}
end;

procedure Tdm.DataModuleCreate(Sender: TObject);
begin
  ConectarBanco;
end;

procedure Tdm.DataModuleDestroy(Sender: TObject);
begin
  FDConn.Connected := False;
end;

end.
