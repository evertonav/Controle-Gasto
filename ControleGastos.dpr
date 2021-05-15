program ControleGastos;





uses
  System.StartUpCopy,
  FMX.Forms,
  uFrmPadrao in 'uFrmPadrao.pas' {frmPadrao},
  uFrmPadraoCadastro in 'uFrmPadraoCadastro.pas' {frmPadraoCadastro},
  DataModule in 'DataModule.pas' {dm: TDataModule},
  uUtils in 'uUtils.pas',
  uFrmListaGenerica in 'uFrmListaGenerica.pas' {frmListaGenerica},
  uFrmCadTipoGasto in 'View\uFrmCadTipoGasto.pas' {frmCadTipoGasto},
  uFrmInserirGasto in 'View\uFrmInserirGasto.pas' {frmInserirGasto},
  uFrmListaGastos in 'View\uFrmListaGastos.pas' {frmListaGastos},
  uFrmPrincipal in 'View\uFrmPrincipal.pas' {frmPrincipal},
  Model.Entidade.Gasto in 'Model\Entidade\Model.Entidade.Gasto.pas',
  Model.Entidade.TipoGasto in 'Model\Entidade\Model.Entidade.TipoGasto.pas',
  Model.DAO.Gasto in 'Model\DAO\Model.DAO.Gasto.pas',
  Model.DAO.GetTotalGasto in 'Model\DAO\Model.DAO.GetTotalGasto.pas',
  Model.DAO.GetTotalInterface in 'Model\DAO\Model.DAO.GetTotalInterface.pas',
  Model.DAO.Interfaces in 'Model\DAO\Model.DAO.Interfaces.pas',
  Model.DAO.TipoGasto in 'Model\DAO\Model.DAO.TipoGasto.pas',
  Controle.GetDados in 'Controle\Controle.GetDados.pas',
  Controle.GetDadosInterface in 'Controle\Controle.GetDadosInterface.pas',
  Controle.Interfaces in 'Controle\Controle.Interfaces.pas',
  Controle in 'Controle\Controle.pas',
  Model.Conexao.FireDac in 'Model\Conexao\Model.Conexao.FireDac.pas',
  Model.Conexao.Interfaces in 'Model\Conexao\Model.Conexao.Interfaces.pas',
  Model.DAO.GetValorGastoPorTipoGasto in 'Model\DAO\Model.DAO.GetValorGastoPorTipoGasto.pas',
  Model.DAO.Get in 'Model\DAO\Model.DAO.Get.pas',
  Model.Conexao in 'Model\Conexao\Model.Conexao.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(TfrmCadTipoGasto, frmCadTipoGasto);
  Application.CreateForm(TfrmInserirGasto, frmInserirGasto);
  Application.CreateForm(TfrmListaGastos, frmListaGastos);
  Application.CreateForm(TfrmListaGastos, frmListaGastos);
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
