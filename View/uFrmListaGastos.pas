unit uFrmListaGastos;

interface

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  FMX.Types,
  FMX.Controls,
  FMX.Forms,
  FMX.Graphics,
  FMX.Dialogs,
  uFrmPadrao,
  FMX.StdCtrls,
  FMX.Controls.Presentation,
  FMX.Objects,
  FMX.Layouts,
  FMX.Effects,
  FMX.Filter.Effects,
  FMX.ListView.Types,
  FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base,
  FMX.ListView;

type
  TfrmListaGastos = class(TfrmPadrao)
    imgVoltar: TImage;
    rgbImgVoltar: TFillRGBEffect;
    vsbListaGastos: TVertScrollBox;
    rtcItemLista: TRectangle;
    lblGastou: TLabel;
    lblValorGasto: TLabel;
    lneDivisao: TLine;
    lblTipoGasto: TLabel;
    lytTopoItemLista: TLayout;
    lytTodoItemLista: TLayout;
    ltvItensGasto: TListView;
    imgReprimir: TImage;
    FillRGBEffect2: TFillRGBEffect;
    btnExpandirReprimir: TSpeedButton;
    procedure btnTituloClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ltvItensGastoDeletingItem(Sender: TObject; AIndex: Integer;
      var ACanDelete: Boolean);
    procedure FormShow(Sender: TObject);
    procedure btnExpandirReprimirClick(Sender: TObject);
  private
    FDataGasto: TDateTime;
    { Private declarations }
    procedure CarregarListaGastos;

    {procedure CriarItemListView(const pListView: TListView;
                                const pValorGasto: Double;
                                const pListViewPadrao: TListView;
                                const pCodigoGasto: Integer);}

    //function PesquisarListView(const pComponentePadrao: TFmxObject): TListView;

    procedure SetDataGasto(const Value: TDateTime);

    //procedure DeletarGasto(const pCodGasto: Integer);

    //procedure CarregarListaGasto(Sender: TObject);

    {procedure CarregarGastoDetalhado(const pDataInicial: TDate;
                                     const pDataFinal: TDate ;
                                     const pCodigoTipoGasto: Integer); }

    {procedure TratarReprimirExpandir(const pRetanguloMaste: TRectangle;
                                     const pBotaoReimprimirExpandir: TSpeedButton;
                                     const pCodTipoGasto: Integer);}
  public
    { Public declarations }
    property DataGasto: TDateTime read FDataGasto write SetDataGasto;
  end;

var
  frmListaGastos: TfrmListaGastos;

implementation

Uses
  Loading,
  FMX.DialogService,
  System.DateUtils,
  uUtils,
  FireDAC.Stan.Param,
  uFrmPrincipal,
  Controle,
  Controle.GetDados,
  Controle.GetDadosInterface;

{$R *.fmx}

procedure TfrmListaGastos.btnExpandirReprimirClick(Sender: TObject);
var
  lTotalFilhos: Integer;
  lI: Integer;
begin
  lTotalFilhos := Pred(vsbListaGastos.Content.ChildrenCount);

  For lI:= lTotalFilhos downto 0 do
  begin
    if (vsbListaGastos.Content.Children[lI] is TRectangle) then
    begin
      if (vsbListaGastos.Content.Children[lI].Tag = TSpeedButton(Sender).Tag) then
      begin
        if TRectangle(vsbListaGastos.Content.Children[lI]).Height = 80 then
          TRectangle(vsbListaGastos.Content.Children[lI]).Height := 200
        else
          if TRectangle(vsbListaGastos.Content.Children[lI]).Height = 200 then
            TRectangle(vsbListaGastos.Content.Children[lI]).Height := 80;
      end;
    end;
  end;
end;

procedure TfrmListaGastos.btnTituloClick(Sender: TObject);
begin
  Self.Close;
end;

{procedure TfrmListaGastos.CriarItemListView(const pListView: TListView;
 const pValorGasto: Double; const pListViewPadrao: TListView;
 const pCodigoGasto: Integer);
var
  lItem: TListViewItem;
  lItemText: TListItemText;
begin
  pListView.OnDeletingItem := pListViewPadrao.OnDeletingItem;

  lItem := pListView.Items.Add;
  lItem.Objects.Clear;

  lItemText := TListItemText(lItem.Objects.FindDrawable('Text1'));
  lItemText.Text := FormatFloat('R$#0.00', pValorGasto);
  lItemText.Font.Size := 18;
  lItemText.Height := 70;
  //txt.Font.Style := [TFontStyle.fsBold];
  lItemText.PlaceOffset.X := 25;
  lItemText.PlaceOffset.Y := 0;
  lItemText.TagFloat := pCodigoGasto;
end; }

{procedure TfrmListaGastos.DeletarGasto(const pCodGasto: Integer);
var
  lMinhaThread: TThread;
begin
  lMinhaThread := TThread.CreateAnonymousThread(
                    procedure ()
                    begin
                      TThread.Synchronize(
                        TThread.CurrentThread,
                        PROCEDURE ()
                        BEGIN
                          TLoading.Show(frmListaGastos, 'Carregando...');
                        END
                        );
                      try
                        try
                          TControle
                            .Criar
                              .Gasto
                                .Entidade
                                  .Codigo(pCodGasto)
                                .ModelDAOGasto
                              .Deletar;

                          TFuncLista.LimparLista(vsbListaGastos, rtcItemLista.Name);
                        except
                          on E: Exception do
                            TThread.Synchronize(
                              TThread.CurrentThread,
                              PROCEDURE ()
                              BEGIN
                                TLoading.Hide;
                                TDialogService.ShowMessage(e.Message);
                              END
                            );
                        end;
                      finally
                        TThread.Synchronize(
                          TThread.CurrentThread,
                          PROCEDURE ()
                          BEGIN
                            TLoading.Hide;
                          END
                          );
                      end;
                    end);

  lMinhaThread.FreeOnTerminate := True;
  lMinhaThread.OnTerminate := CarregarListaGasto;
  lMinhaThread.Start;
end;  }

{procedure TfrmListaGastos.CarregarGastoDetalhado(const pDataInicial,
  pDataFinal: TDate; const pCodigoTipoGasto: Integer);
begin
{SELECT
  G.COD_GASTO,
  SUM(G.VALOR_GASTO) as VALOR_GASTO
FROM
  GASTO G
WHERE DATA_GASTO > :DATA_INI
  AND DATA_GASTO < :DATA_FIM
  AND G.COD_TIPO_GASTO = :ICOD_TIPO_GASTO
GROUP BY G.VALOR_GASTO
}{
  DM.qrGetGastoUnitario.Close;

  if not dm.qrGetGastoUnitario.Prepared then
    DM.qrGetGastoUnitario.Prepare;

  dm.qrGetGastoUnitario.Params.ParamByName('DATA_INI').AsFloat := pDataInicial;
  dm.qrGetGastoUnitario.Params.ParamByName('DATA_FIM').AsFloat := pDataFinal;
  dm.qrGetGastoUnitario.Params.ParamByName('ICOD_TIPO_GASTO').AsInteger := pCodigoTipoGasto;

  DM.qrGetGastoUnitario.Open;
end;
      }
{procedure TfrmListaGastos.CarregarListaGasto(Sender: TObject);
begin
  CarregarListaGastos;
end;  }

procedure TfrmListaGastos.CarregarListaGastos;
var
  lMinhaThread: TThread;
begin
  lMinhaThread := TThread.CreateAnonymousThread(
                    procedure ()
                    var
                      lControleGetDados: IControleGetDadosInterface;

                      procedure CriarItemListaGasto(const pTitulo: string;
                        const pValor: Double; const pCodTipoGasto: Integer);
                      var
                        lRtcItemLista: TRectangle;
                      begin
                        lblTipoGasto.Text := pTitulo;
                        lblValorGasto.Text := FormatFloat('R$#0.00', pValor);

                        {$REGION 'Clonar Item Lista'}
                        lRtcItemLista := TRectangle(rtcItemLista.Clone(vsbListaGastos));
                        lRtcItemLista.Parent := vsbListaGastos;
                        lRtcItemLista.Tag := pCodTipoGasto;
                        lRtcItemLista.Name := rtcItemLista.Name + pCodTipoGasto.ToString;
                        lRtcItemLista.Visible := True;
                        {$ENDREGION}

                        {while not DM.qrGetGastoUnitario.Eof do
                        begin
                          CriarItemListView(PesquisarListView(lRtcItemLista),
                                            DM.qrGetGastoUnitario.FieldByName('VALOR_GASTO').AsCurrency,
                                            ltvItensGasto,
                                            DM.qrGetGastoUnitario.FieldByName('COD_GASTO').AsInteger);

                          DM.qrGetGastoUnitario.Next;
                        end;

                        TratarReprimirExpandir(lRtcItemLista,
                                               btnExpandirReprimir,
                                               pCodTipoGasto);}
                      end;

                    begin
                      TThread.Synchronize(
                        TThread.CurrentThread,
                        PROCEDURE ()
                        BEGIN
                          TLoading.Show(frmListaGastos, 'Carregando...');
                        END
                        );

                      try
                        lControleGetDados := TControleGetDados.Criar;

                        lControleGetDados
                          .ValorGastoPorTipoGasto
                            .DataInicial(StartOfTheMonth(DataGasto))
                            .DataFinal(EndOfTheMonth(DataGasto))
                          .Execucao
                        .Iniciar;

                      except
                        on E: Exception do
                        TThread.Synchronize(
                          TThread.CurrentThread,
                          PROCEDURE ()
                          BEGIN
                            TLoading.Hide;
                            TDialogService.ShowMessage(e.Message);
                          END
                        );
                      end;

                      try
                        try
                          vsbListaGastos.BeginUpdate;
                          try
                            while not lControleGetDados.ValorGastoPorTipoGasto.Execucao.Fim do
                            begin
                              try
                                {CarregarGastoDetalhado(StartOfTheMonth(DataGasto),
                                                       EndOfTheMonth(DataGasto),
                                                       DM.qrGetGastos.FieldByName('COD_TIPO_GASTO').AsInteger);}

                                CriarItemListaGasto(lControleGetDados.ValorGastoPorTipoGasto.Execucao.Get.NomeTipoGasto,
                                                    lControleGetDados.ValorGastoPorTipoGasto.Execucao.Get.ValorGasto,
                                                    lControleGetDados.ValorGastoPorTipoGasto.Execucao.Get.CodigoTipoGasto);

                                lControleGetDados.ValorGastoPorTipoGasto.Execucao.Proximo;
                              except
                                on E: Exception do
                                TThread.Synchronize(
                                  TThread.CurrentThread,
                                  PROCEDURE ()
                                  begin
                                    TLoading.Hide;
                                    TDialogService.ShowMessage(e.Message);
                                  end
                                );
                              end;
                            end;
                          finally
                            vsbListaGastos.EndUpdate;
                          end;
                        finally
                          TThread.Synchronize(
                            TThread.CurrentThread,
                            PROCEDURE ()
                            BEGIN
                              TLoading.Hide;
                            END
                            );
                        end;
                      except
                        on E: Exception do
                        begin
                          TThread.Synchronize(
                            TThread.CurrentThread,
                            PROCEDURE ()
                            BEGIN
                              TLoading.Hide;
                              TDialogService.ShowMessage(e.Message);
                            END);
                        end;
                      end;
                    end

                  );

  lMinhaThread.FreeOnTerminate := True;
  lMinhaThread.Start;
end;

procedure TfrmListaGastos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  TFuncLista.LimparLista(vsbListaGastos, rtcItemLista.Name);

  frmPrincipal.AtualizarTotalGasto(DataGasto);

  Action := TCloseAction.caFree;
  frmListaGastos := nil;
end;

procedure TfrmListaGastos.FormShow(Sender: TObject);
begin
  CarregarListaGastos;
end;

procedure TfrmListaGastos.ltvItensGastoDeletingItem(Sender: TObject;
  AIndex: Integer; var ACanDelete: Boolean);
{var
  txt : TListItemText;}
begin
 { txt := TListItemText(TListView(Sender).Items[AIndex].Objects.FindDrawable('Text1'));

  if txt.TagFloat <> 0 then
    DeletarGasto(StrToInt(txt.TagFloat.ToString))
  else
    ACanDelete := False;}
end;

{function TfrmListaGastos.PesquisarListView(
  const pComponentePadrao: TFmxObject): TListView;
var
  lTotalFilhos: Integer;
  lI: Integer;
begin
  Result := nil;

  lTotalFilhos := Pred(pComponentePadrao.ChildrenCount);

  For lI := lTotalFilhos downto 0 do
  begin
    if (pComponentePadrao.Children[lI] is TListView) then
    begin
      Result := TListView(pComponentePadrao.Children[lI]);
    end;
  end;
end; }

procedure TfrmListaGastos.SetDataGasto(const Value: TDateTime);
begin
  FDataGasto := Value;
end;

{procedure TfrmListaGastos.TratarReprimirExpandir(
  const pRetanguloMaste: TRectangle;
  const pBotaoReimprimirExpandir: TSpeedButton; const pCodTipoGasto: Integer);
var
  lTotalFilhoRetangulo: Integer;
  lIRetangulo: Integer;
  lTotalFilhosBotao: Integer;
  lIBotao: Integer;
begin
  lTotalFilhoRetangulo := Pred(pRetanguloMaste.ChildrenCount);

  For lIRetangulo := lTotalFilhoRetangulo downto 0 do
  begin
    if (pRetanguloMaste.Children[lIRetangulo] is TLayout) then
    begin
      lTotalFilhosBotao := Pred(TLayout(pRetanguloMaste.Children[lIRetangulo]).ChildrenCount);

      for lIBotao := 0 to lTotalFilhosBotao do
      begin
        if (TLayout(pRetanguloMaste.Children[lIRetangulo]).Children[lIBotao] is TSpeedButton) then
        begin
          TSpeedButton(TLayout(pRetanguloMaste.Children[lIRetangulo]).Children[lIBotao]).Tag := pCodTipoGasto;
          TSpeedButton(TLayout(pRetanguloMaste.Children[lIRetangulo]).Children[lIBotao]).Name := btnExpandirReprimir.Name + pCodTipoGasto.ToString;
          TSpeedButton(TLayout(pRetanguloMaste.Children[lIRetangulo]).Children[lIBotao]).Text := EmptyStr;
          TSpeedButton(TLayout(pRetanguloMaste.Children[lIRetangulo]).Children[lIBotao]).OnClick := pBotaoReimprimirExpandir.OnClick;
        end;
      end;
    end;
  end;
end; }

end.
