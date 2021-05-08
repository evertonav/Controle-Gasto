unit uFrmInserirGasto;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, uFrmPadrao,
  FMX.StdCtrls, FMX.Effects, FMX.Filter.Effects, FMX.DateTimeCtrls,
  FMX.SearchBox, FMX.ListBox, FMX.Layouts, FMX.Objects,
  FMX.Controls.Presentation, FMX.Edit, uFrmPadraoCadastro;

type
  TfrmInserirGasto = class(TfrmPadraoCadastro)
    lytDataGasto: TLayout;
    lytImagemDataGasto: TLayout;
    lytrctDataGasto: TRectangle;
    imgDataVenda: TImage;
    dteDataGasto: TDateEdit;
    lytTipoGasto: TLayout;
    edtTipoGasto: TEdit;
    lytImgTipoGasto: TLayout;
    rtcTipoGasto: TRectangle;
    imgTipoGasto: TImage;
    lytValorGasto: TLayout;
    edtValorGasto: TEdit;
    lytImagemValorGasto: TLayout;
    rtcValorGasto: TRectangle;
    imgValorGasto: TImage;
    procedure btnConfirmarClick(Sender: TObject);
    procedure edtValorGastoKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure edtValorGastoChangeTracking(Sender: TObject);
    procedure edtTipoGastoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    procedure VerificarHabilitarBotao;

    procedure AbrirTelaTipoGastos;
  public
    { Public declarations }
  end;

var
  frmInserirGasto: TfrmInserirGasto;

implementation

Uses
  DataModule,
  uUtils,
  Loading,
  uFrmListaGenerica,
  uFrmPrincipal,
  Controle;

{$R *.fmx}

procedure TfrmInserirGasto.AbrirTelaTipoGastos;
begin
  if not Assigned(frmListaGenerica) then
    Application.CreateForm(TfrmListaGenerica, frmListaGenerica);

  frmListaGenerica.CarregarTipoGastos;

  frmInserirGasto.AddObject(frmListaGenerica.lytContents);
end;

procedure TfrmInserirGasto.btnConfirmarClick(Sender: TObject);
begin
  frmInserirGasto.InserirComThread(
    procedure ()
    begin
      TControle
        .Criar
          .Gasto
            .Entidade
              .Data(dteDataGasto.Date)
              .Valor(edtValorGasto.Text.ToDouble)
              .Tipo(edtTipoGasto.Tag)
            .ModelDAOGasto
          .Inserir;

      TThread.Synchronize(
        TThread.CurrentThread,
        procedure
        begin
          edtValorGasto.Text := '';
        end);
    end,

    //OUTRO PAR�METRO DO M�TODO
    frmInserirGasto
  );
end;

procedure TfrmInserirGasto.edtTipoGastoClick(Sender: TObject);
begin
  AbrirTelaTipoGastos;
end;

procedure TfrmInserirGasto.edtValorGastoChangeTracking(Sender: TObject);
begin
  TMask.MaskFloat(TEdit(Sender), '#0.00');

  VerificarHabilitarBotao;
end;

procedure TfrmInserirGasto.edtValorGastoKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  TEdit(Sender).GoToTextEnd;
end;

procedure TfrmInserirGasto.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  frmPrincipal.AtualizarTotalGasto;
end;

procedure TfrmInserirGasto.FormCreate(Sender: TObject);
begin
  dteDataGasto.Date := Now;

  edtTipoGasto.Tag := 1;
  edtTipoGasto.Text := 'GERAL';
end;

procedure TfrmInserirGasto.VerificarHabilitarBotao;
var
  lHabilitarBotao: Boolean;
begin
  lHabilitarBotao := edtValorGasto.Text <> EmptyStr;

  frmInserirGasto.HabilitarBotao(lHabilitarBotao,
                                 frmInserirGasto);
end;

end.
