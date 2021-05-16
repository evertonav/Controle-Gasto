unit uFrmListaGenerica;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Layouts, FMX.ListView.Types, FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base, FMX.ListView, FMX.Controls.Presentation,
  FMX.StdCtrls, FMX.Ani, FMX.ListBox, FMX.Edit, FMX.SearchBox, FMX.Effects,
  FMX.Filter.Effects, Loading;

type
  TfrmListaGenerica = class(TForm)
    lytContents: TLayout;
    rctContents: TRectangle;
    lytBottom: TLayout;
    lytRestoTela: TLayout;
    rctLista: TRectangle;
    lytTitulo: TLayout;
    rtcCabecalho: TRectangle;
    lblSelecioneEstabelecimento: TLabel;
    StyleBook1: TStyleBook;
    lbxGenerico: TListBox;
    lbiGenerico: TListBoxItem;
    lneSeparacaoLista: TLine;
    cclPesquisa: TCircle;
    sbxGenerico: TSearchBox;
    btnPesquisa: TSpeedButton;
    rctContainerBottom: TRectangle;
    btnVoltar: TSpeedButton;
    procedure cclPesquisaClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure imgSairClick(Sender: TObject);
    procedure lbiGenericoClick(Sender: TObject);
    procedure btnVoltarClick(Sender: TObject);
  private
    { Private declarations }
    procedure CarregarListBoxProduto(const pListBox: TListBox;
                                     const pCarregarVendas: Boolean;
                                     const pItemListBoxClonar: TListBoxItem);

    procedure RemoverLayout(const pNomeTipoGasto: string;
                            const pTagTipoGasto: Integer;
                            const pLayoutRemover: TLayout);

    procedure MostrarPesquisa(const pMostrar: Boolean);
  public
    { Public declarations }
    procedure CarregarTipoGastos;
  end;

var
  frmListaGenerica: TfrmListaGenerica;

implementation

uses
  uFrmInserirGasto,
  FMX.DialogService,
  Controller.Utils,
  Controller.GetDados,
  Controller.GetDados.Interfaces;

{$R *.fmx}

procedure TfrmListaGenerica.CarregarTipoGastos;
begin
  sbxGenerico.Text := EmptyStr;
  MostrarPesquisa(False);

  TFuncLista.LimparLista(lbxGenerico, lbiGenerico.Name);

  CarregarListBoxProduto(lbxGenerico, False, lbiGenerico);
end;

procedure TfrmListaGenerica.cclPesquisaClick(Sender: TObject);
begin
  lytTitulo.Visible := False;
  sbxGenerico.Visible := True;
end;

procedure TfrmListaGenerica.btnVoltarClick(Sender: TObject);
begin
  RemoverLayout(frmInserirGasto.edtTipoGasto.Text,
                frmInserirGasto.edtTipoGasto.Tag,
                lytContents);
end;

procedure TfrmListaGenerica.CarregarListBoxProduto(const pListBox: TListBox;
  const pCarregarVendas: Boolean; const pItemListBoxClonar: TListBoxItem);
var
  lMinhaThread: TThread;
begin
  lMinhaThread := TThread.CreateAnonymousThread(
                    procedure ()
                    var
                      lItemListBox: TListBoxItem;
                      lControleGetDados: IControllerGetDadosInterfaces;
                    begin
                      try
                        lControleGetDados := TControllerGetDados.Criar;

                        lControleGetDados.TipoGasto.Iniciar;
                      except
                        on E: Exception do
                        begin
                          TThread.Synchronize(
                            TThread.CurrentThread,
                            PROCEDURE ()
                            BEGIN
                              TDialogService.ShowMessage(e.Message);
                            END
                          );
                        end;

                      end;

                      TThread.Synchronize(
                        TThread.CurrentThread,
                        PROCEDURE ()
                        BEGIN
                          //TLoading.Show(frmListaGenerica, 'Carregando...');

                          pListBox.BeginUpdate;
                        END
                        );

                      while not lControleGetDados.TipoGasto.Fim do
                      begin
                        lItemListBox := TListBoxItem(pItemListBoxClonar.Clone(pListBox));

                        lItemListBox.Text := lControleGetDados.TipoGasto.Get.Nome;

                        lItemListBox.OnClick := pItemListBoxClonar.OnClick;
                        lItemListBox.Parent := pListBox;
                        lItemListBox.Tag := lControleGetDados.TipoGasto.Get.Codigo;
                        lItemListBox.Visible := True;

                        lControleGetDados.TipoGasto.Proximo;
                      end;

                      TThread.Synchronize(
                        TThread.CurrentThread,
                        PROCEDURE ()
                        BEGIN
                          pListBox.EndUpdate;

                          TLoading.Hide;
                        END
                        );
                    end

                  );

  lMinhaThread.FreeOnTerminate := True;
  lMinhaThread.Start;
end;


procedure TfrmListaGenerica.imgSairClick(Sender: TObject);
begin
  frmInserirGasto.RemoveObject(lytContents);
end;

procedure TfrmListaGenerica.lbiGenericoClick(Sender: TObject);
begin
  RemoverLayout(TListBoxItem(Sender).Text,
                TListBoxItem(Sender).Tag,
                lytContents);
end;

procedure TfrmListaGenerica.MostrarPesquisa(const pMostrar: Boolean);
begin
  lytTitulo.Visible := not pMostrar;
  sbxGenerico.Visible := pMostrar;

  if pMostrar then
    sbxGenerico.SetFocus;
end;

procedure TfrmListaGenerica.RemoverLayout(const pNomeTipoGasto: string;
  const pTagTipoGasto: Integer; const pLayoutRemover: TLayout);
begin
  frmInserirGasto.edtTipoGasto.Text := pNomeTipoGasto;
  frmInserirGasto.edtTipoGasto.Tag := pTagTipoGasto;

  frmInserirGasto.RemoveObject(pLayoutRemover);
end;

procedure TfrmListaGenerica.btnPesquisaClick(Sender: TObject);
begin
  MostrarPesquisa(True);
end;

end.
