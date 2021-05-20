unit View.FrmPrincipal;

interface

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  FMX.Types,
  FMX.Graphics,
  FMX.Controls,
  FMX.Forms,
  FMX.Dialogs,
  FMX.StdCtrls,
  View.FrmPadrao,
  FMX.Controls.Presentation,
  FMX.Objects,
  FMX.Layouts,
  FMX.MultiView,
  FMX.Effects,
  FMX.Filter.Effects;

type
  TfrmPrincipal = class(TfrmPadrao)
    lytTodoForm: TLayout;
    lytTopoTodoForm: TLayout;
    rtcData: TRectangle;
    lblData: TLabel;
    lytRestoForm: TLayout;
    rtcVendiValor: TRectangle;
    Layout7: TLayout;
    lblVendido: TLabel;
    rtcMargemToda: TRectangle;
    Layout8: TLayout;
    Layout9: TLayout;
    lblQtdVendido: TLabel;
    Image3: TImage;
    lytInferior: TLayout;
    rtcBotao: TRectangle;
    Image4: TImage;
    btnInserirVenda: TSpeedButton;
    MultiView: TMultiView;
    lytClienteMultiView: TLayout;
    rtgClientMultiView: TRectangle;
    lneTopoMultiview: TLine;
    lytTopoMultiView: TLayout;
    rtgTopoMultiView: TRectangle;
    lytCadTipoGasto: TLayout;
    Line2: TLine;
    btnCadTipoGasto: TSpeedButton;
    imgCadTipoGasto: TImage;
    lytTituloTipoGasto: TLayout;
    lblCadastro: TLabel;
    lneTituloBottomTipoGasto: TLine;
    FillRGBEffect1: TFillRGBEffect;
    btnMesAnterior: TSpeedButton;
    imgMesAnterior: TImage;
    FillRGBEffect2: TFillRGBEffect;
    btnProximoMes: TSpeedButton;
    imgProximoMes: TImage;
    FillRGBEffect3: TFillRGBEffect;
    procedure btnCadTipoGastoClick(Sender: TObject);
    procedure btnInserirVendaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure rtcVendiValorClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnMesAnteriorClick(Sender: TObject);
    procedure btnProximoMesClick(Sender: TObject);
  private
    { Private declarations }
    procedure AbrirCadastroTipoGasto;
    procedure AbrirInsercaoGasto;
    procedure AbrirListaGastos;

    procedure AtualizarMesGasto(const pData: TDateTime);

    function ValidarRetornarAnoAtual(const pData: TDate): TDate;
  public
    { Public declarations }
    procedure AtualizarTotalGasto(const pDataGasto: TDate = -1);
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

Uses
  View.FrmInserirGasto,
  View.FrmCadTipoGasto,
  View.FrmListaGastos,
  System.DateUtils,
  Controller.Utils,
  Controller.GetDados,
  Controller.GetDados.Interfaces;

{$R *.fmx}

procedure TfrmPrincipal.AbrirCadastroTipoGasto;
begin
  if not Assigned(frmCadTipoGasto) then
    Application.CreateForm(TFrmCadTipoGasto, frmCadTipoGasto);

  frmCadTipoGasto.Show;
end;

procedure TfrmPrincipal.AbrirInsercaoGasto;
begin
  if not Assigned(frmInserirGasto) then
    Application.CreateForm(TfrmInserirGasto, frmInserirGasto);

  frmInserirGasto.Show;
end;

procedure TfrmPrincipal.AbrirListaGastos;
begin
  if not Assigned(frmListaGastos) then
    Application.CreateForm(TfrmListaGastos, frmListaGastos);

  frmListaGastos.DataGasto := lblData.TagFloat;
  frmListaGastos.Show;
end;

procedure TfrmPrincipal.AtualizarMesGasto(const pData: TDateTime);
var
  lData: TDate;
begin
  lData := ValidarRetornarAnoAtual(pData);

  lblData.Text := TData.GetNomeMes(lData);
  lblData.TagFloat := lData;

  AtualizarTotalGasto(lData);
end;

procedure TfrmPrincipal.AtualizarTotalGasto(const pDataGasto: TDate);
var
  lGetDadosGasto: IControllerGetDadosInterfaces;
begin
  lGetDadosGasto := TControllerGetDados.Criar;

  if pDataGasto = -1 then
    lGetDadosGasto.DadosGasto.Entidade.Data(lblData.TagFloat)
  else
    lGetDadosGasto.DadosGasto.Entidade.Data(pDataGasto);

  lblQtdVendido.Text := FormatFloat('R$#0.00',
                                    lGetDadosGasto.DadosGasto.GetTotal);
end;

procedure TfrmPrincipal.btnCadTipoGastoClick(Sender: TObject);
begin
  AbrirCadastroTipoGasto;
end;

procedure TfrmPrincipal.btnInserirVendaClick(Sender: TObject);
begin
  AbrirInsercaoGasto;
end;

procedure TfrmPrincipal.btnMesAnteriorClick(Sender: TObject);
begin
  AtualizarMesGasto(IncMonth(lblData.TagFloat, -1));
end;

procedure TfrmPrincipal.btnProximoMesClick(Sender: TObject);
begin
  AtualizarMesGasto(IncMonth(lblData.TagFloat, 1));
end;

procedure TfrmPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := TCloseAction.caFree;
  frmPrincipal := nil;
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  AtualizarMesGasto(Now);
end;

procedure TfrmPrincipal.rtcVendiValorClick(Sender: TObject);
begin
  try
    rtcVendiValor.HitTest := False;

    AbrirListaGastos;
  finally
    rtcVendiValor.HitTest := True;
  end;
end;

function TfrmPrincipal.ValidarRetornarAnoAtual(const pData: TDate): TDate;
begin
  Result := pData;

  if YearOf(pData) <> YearOf(Now) then
  begin
    if YearOf(pData) > YearOf(Now) then
      Result := IncYear(pData, -1)
    else
      Result := IncYear(pData, 1)
  end;
end;

end.
