unit uFrmPadraoCadastro;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, uFrmPadrao,
  FMX.StdCtrls, FMX.Effects, FMX.Filter.Effects, FMX.DateTimeCtrls,
  FMX.SearchBox, FMX.ListBox, FMX.Layouts, FMX.Objects,
  FMX.Controls.Presentation, FMX.Edit;

type
  TfrmPadraoCadastro = class(TfrmPadrao)
    lytRestoTela: TLayout;
    rtcCampos: TRectangle;
    rtcMsg: TRectangle;
    lblMsg: TLabel;
    lytInferior: TLayout;
    rtgConfirmar: TRectangle;
    imgCerto: TImage;
    FillRGBEffect1: TFillRGBEffect;
    ShadowEffect1: TShadowEffect;
    imgErrado: TImage;
    btnConfirmar: TSpeedButton;
    stbListBox: TStyleBook;
    imgVoltar: TImage;
    rgbImgVoltar: TFillRGBEffect;
    procedure btnTituloClick(Sender: TObject);
  private
    { Private declarations }
  protected
    { Public declarations }
    procedure MostrarMensagem(const pMensagem: string;
                              const pCor: TColor;
                              const pTempoSleep: Cardinal;
                              const pForm: TForm);

    procedure HabilitarBotao(const pDadosCorretos: Boolean;
                             const pForm: TForm);

    procedure InserirComThread(const pProcessamento: TProc;
                               const pFormExecutando: TForm);
  end;

var
  frmPadraoCadastro: TfrmPadraoCadastro;

implementation

Uses
  Loading, DataModule, FMX.DialogService;

{$R *.fmx}

procedure TfrmPadraoCadastro.btnTituloClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TfrmPadraoCadastro.HabilitarBotao(const pDadosCorretos: Boolean;
  const pForm: TForm);
begin
  TfrmPadraoCadastro(pForm).btnConfirmar.Enabled := pDadosCorretos;

  TfrmPadraoCadastro(pForm).btnConfirmar.EnableDragHighlight := pDadosCorretos;

  TfrmPadraoCadastro(pForm).imgCerto.Visible := pDadosCorretos;
  TfrmPadraoCadastro(pForm).imgErrado.Visible := not pDadosCorretos;
end;

procedure TfrmPadraoCadastro.MostrarMensagem(const pMensagem: string;
  const pCor: TColor; const pTempoSleep: Cardinal; const pForm: TForm);
begin
  TfrmPadraoCadastro(pForm).rtcMsg.Visible := True;
  TfrmPadraoCadastro(pForm).lblMsg.Text := pMensagem;
  TfrmPadraoCadastro(pForm).rtcMsg.Fill.Color := pCor;

  Sleep(pTempoSleep);

  TfrmPadraoCadastro(pForm).rtcMsg.Visible := False;
end;

procedure TFrmPadraoCadastro.InserirComThread(const pProcessamento: TProc;
  const pFormExecutando: TForm);
var
  lMinhaThread: TThread;
begin
  lMinhaThread := TThread.CreateAnonymousThread(
                    procedure ()
                    var
                      lDeuErro: Boolean;
                    begin
                      TThread.Synchronize(
                        TThread.CurrentThread,
                        PROCEDURE ()
                        BEGIN
                          TLoading.Show(pFormExecutando, 'Carregando...');
                        END
                        );

                       try
                         try
                           pProcessamento;
                         except
                           on E: Exception do
                          begin
                            TThread.Synchronize(
                             TThread.CurrentThread,
                             procedure
                             begin
                               TLoading.Hide;

                               TDialogService.ShowMessage(e.Message);

                               lDeuErro := True;
                             end);
                          end
                         end;

                          TThread.Synchronize(
                            TThread.CurrentThread,
                            procedure ()
                            begin
                              TLoading.Hide;
                            end
                          );

                         if not lDeuErro then
                         begin
                           TFrmPadraoCadastro(pFormExecutando).MostrarMensagem('Dados inseridos com sucesso...',
                                                                               $FFA8D67F,
                                                                               2000,
                                                                               pFormExecutando);
                         end;
                       except
                         on E: Exception do
                         begin
                           TLoading.Hide;

                           TDialogService.ShowMessage(E.Message);
                         end;
                       end;
                    end

                  );

  lMinhaThread.FreeOnTerminate := True;
  lMinhaThread.Start;
end;

end.
