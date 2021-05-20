unit View.FrmPadrao;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Layouts, FMX.Effects, FMX.Filter.Effects, FMX.Controls.Presentation,
  FMX.Objects;

type
  TfrmPadrao = class(TForm)
    rctTitulo: TRectangle;
    lytTopo: TLayout;
    lytTitulo: TLayout;
    lblTitulo: TLabel;
    lytLadoTitulo: TLayout;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPadrao: TfrmPadrao;

implementation

{$R *.fmx}

end.
