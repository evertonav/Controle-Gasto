unit uFrmListaGenerica;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Layouts, FMX.ListView.Types, FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base, FMX.ListView, FMX.Controls.Presentation,
  FMX.StdCtrls, FMX.Ani, FMX.ListBox, FMX.Edit, FMX.SearchBox, FMX.Effects,
  FMX.Filter.Effects, DataModule, Loading;

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
    imgSair: TImage;
    sbxGenerico: TSearchBox;
    btnPesquisa: TSpeedButton;
    procedure cclPesquisaClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure imgSairClick(Sender: TObject);
    procedure lbiGenericoClick(Sender: TObject);
  private
    { Private declarations }
    procedure CarregarListBoxProduto(const pListBox: TListBox;
                                     const pCarregarVendas: Boolean;
                                     const pItemListBoxClonar: TListBoxItem);
  public
    { Public declarations }
    procedure CarregarTipoGastos;
  end;

var
  frmListaGenerica: TfrmListaGenerica;

implementation

uses
  uFrmInserirGasto, FMX.DialogService, uUtils;

{$R *.fmx}

procedure TfrmListaGenerica.CarregarTipoGastos;
begin
  TFuncLista.LimparLista(lbxGenerico, lbiGenerico.Name);

  CarregarListBoxProduto(lbxGenerico, False, lbiGenerico);
end;

procedure TfrmListaGenerica.cclPesquisaClick(Sender: TObject);
begin
  lytTitulo.Visible := False;
  sbxGenerico.Visible := True;
end;

procedure TfrmListaGenerica.CarregarListBoxProduto(const pListBox: TListBox;
  const pCarregarVendas: Boolean; const pItemListBoxClonar: TListBoxItem);
var
  lMinhaThread: TThread;
begin
  lMinhaThread := TThread.CreateAnonymousThread(
                    procedure ()
                    var
                      I: Integer;
                      lItemListBox: TListBoxItem;
                    begin
                      DM.qrGetTipoGasto.Close;

                      try
                        if not dm.qrGetTipoGasto.Prepared then
                          DM.qrGetTipoGasto.Prepare;

                        DM.qrGetTipoGasto.Open;
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

                      for I := 0 to DM.qrGetTipoGasto.RecordCount - 1 do
                      begin
                        lItemListBox := TListBoxItem(pItemListBoxClonar.Clone(pListBox));

                        lItemListBox.Text := dm.qrGetTipoGasto.FieldByName('NOME_TIPO_GASTO').AsString;

                        lItemListBox.OnClick := pItemListBoxClonar.OnClick;
                        lItemListBox.Parent := pListBox;
                        lItemListBox.Tag := DM.qrGetTipoGasto.FieldByName('COD_TIPO_GASTO').AsInteger;
                        lItemListBox.Visible := True;

                        dm.qrGetTipoGasto.Next;
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
  frmInserirGasto.edtTipoGasto.Text := TListBoxItem(Sender).Text;
  frmInserirGasto.edtTipoGasto.Tag := TListBoxItem(Sender).Tag;

  frmInserirGasto.RemoveObject(lytContents);
end;

procedure TfrmListaGenerica.btnPesquisaClick(Sender: TObject);
begin
  lytTitulo.Visible := False;
  sbxGenerico.Visible := True;

  sbxGenerico.SetFocus;
end;

end.
