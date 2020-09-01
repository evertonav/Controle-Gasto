program ControleGastos;

uses
  System.StartUpCopy,
  FMX.Forms,
  uFrmPadrao in 'uFrmPadrao.pas' {frmPadrao},
  uFrmPrincipal in 'uFrmPrincipal.pas' {frmPrincipal},
  uFrmCadTipoGasto in 'uFrmCadTipoGasto.pas' {frmCadTipoGasto},
  uFrmInserirGasto in 'uFrmInserirGasto.pas' {frmInserirGasto},
  uFrmPadraoCadastro in 'uFrmPadraoCadastro.pas' {frmPadraoCadastro},
  DataModule in 'DataModule.pas' {dm: TDataModule},
  uUtils in 'uUtils.pas',
  uControleGasto in 'uControleGasto.pas',
  uTipoGasto in 'uTipoGasto.pas',
  uGasto in 'uGasto.pas',
  uFrmListaGastos in 'uFrmListaGastos.pas' {frmListaGastos},
  uFrmListaGenerica in 'uFrmListaGenerica.pas' {frmListaGenerica};

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
