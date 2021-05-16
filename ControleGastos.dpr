program ControleGastos;





uses
  System.StartUpCopy,
  FMX.Forms,
  uFrmPadrao in 'uFrmPadrao.pas' {frmPadrao},
  uFrmPadraoCadastro in 'uFrmPadraoCadastro.pas' {frmPadraoCadastro},
  uFrmCadTipoGasto in 'View\uFrmCadTipoGasto.pas' {frmCadTipoGasto},
  uFrmInserirGasto in 'View\uFrmInserirGasto.pas' {frmInserirGasto},
  uFrmListaGastos in 'View\uFrmListaGastos.pas' {frmListaGastos},
  uFrmPrincipal in 'View\uFrmPrincipal.pas' {frmPrincipal},
  Model.Entidade.Gasto in 'Model\Entidade\Model.Entidade.Gasto.pas',
  Model.Entidade.TipoGasto in 'Model\Entidade\Model.Entidade.TipoGasto.pas',
  Model.DAO.Interfaces in 'Model\DAO\Model.DAO.Interfaces.pas',
  Model.Conexao.FireDac in 'Model\Conexao\Model.Conexao.FireDac.pas',
  Model.Conexao.Interfaces in 'Model\Conexao\Model.Conexao.Interfaces.pas',
  Model.Conexao in 'Model\Conexao\Model.Conexao.pas',
  uFrmListaGenerica in 'View\uFrmListaGenerica.pas' {frmListaGenerica},
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
  Model.DAO.TipoGasto.GetValorGasto in 'Model\DAO\TipoGasto\Model.DAO.TipoGasto.GetValorGasto.pas';

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
  Application.CreateForm(TfrmListaGenerica, frmListaGenerica);
  Application.Run;
end.
