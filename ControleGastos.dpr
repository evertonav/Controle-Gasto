program ControleGastos;









uses
  System.StartUpCopy,
  FMX.Forms,
  Model.Entidade.Gasto in 'Model\Entidade\Model.Entidade.Gasto.pas',
  Model.Entidade.TipoGasto in 'Model\Entidade\Model.Entidade.TipoGasto.pas',
  Model.DAO.Interfaces in 'Model\DAO\Model.DAO.Interfaces.pas',
  Model.Conexao.FireDac in 'Model\Conexao\Model.Conexao.FireDac.pas',
  Model.Conexao.Interfaces in 'Model\Conexao\Model.Conexao.Interfaces.pas',
  Model.Conexao in 'Model\Conexao\Model.Conexao.pas',
  Controller.Utils in 'Controller\Controller.Utils.pas',
  Controller.GetDados in 'Controller\Controller.GetDados.pas',
  Controller in 'Controller\Controller.pas',
  Controller.Interfaces in 'Controller\Controller.Interfaces.pas',
  Controller.GetDados.Interfaces in 'Controller\Controller.GetDados.Interfaces.pas',
  Model.DAO.Gasto in 'Model\DAO\Gasto\Model.DAO.Gasto.pas',
  Model.DAO.GetParametros.Interfaces in 'Model\DAO\Model.DAO.GetParametros.Interfaces.pas',
  Model.DAO.GetTotal.Interfaces in 'Model\DAO\Model.DAO.GetTotal.Interfaces.pas',
  Model.DAO.Get.Interfaces in 'Model\DAO\Model.DAO.Get.Interfaces.pas',
  Model.DAO.Gasto.GetTotal in 'Model\DAO\Gasto\Model.DAO.Gasto.GetTotal.pas',
  Model.DAO.TipoGasto.Get in 'Model\DAO\TipoGasto\Model.DAO.TipoGasto.Get.pas',
  Model.DAO.TipoGasto in 'Model\DAO\TipoGasto\Model.DAO.TipoGasto.pas',
  Model.DAO.TipoGasto.GetValorGasto in 'Model\DAO\TipoGasto\Model.DAO.TipoGasto.GetValorGasto.pas',
  View.Loading in 'View\View.Loading.pas',
  View.FrmPrincipal in 'View\View.FrmPrincipal.pas' {frmPrincipal},
  View.FrmInserirGasto in 'View\View.FrmInserirGasto.pas' {frmInserirGasto},
  View.FrmCadTipoGasto in 'View\View.FrmCadTipoGasto.pas' {frmCadTipoGasto},
  View.FrmListaGastos in 'View\View.FrmListaGastos.pas' {frmListaGastos},
  View.FrmListaGenerica in 'View\View.FrmListaGenerica.pas' {frmListaGenerica},
  View.FrmPadrao in 'View\View.FrmPadrao.pas' {frmPadrao},
  View.FrmPadraoCadastro in 'View\View.FrmPadraoCadastro.pas' {frmPadraoCadastro};

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
