unit Controller.Utils;

interface

Uses MaskUtils, FMX.Edit, System.SysUtils, FMX.VirtualKeyboard, System.UITypes,
  FMX.Platform, FMX.Types, System.Character, FMX.Layouts, FMX.Objects, FMX.ListBox {$IFDEF ANDROID}
  , Androidapi.JNI.Os,
  Androidapi.JNI.GraphicsContentViewText, Androidapi.Helpers,
  Androidapi.JNIBridge{$ENDIF};

Type
  TMask = class
  public
    class procedure MaskText(const pEdit: TEdit;
                             const pMask: string);

    class procedure MaskFloat(const pEdit: TEdit;
                              const pMask: string);
  end;

  THardware = class
  public
    class procedure BotaoBackTeclado(var Key: Word);
    class procedure Vibrar(const pTempo: Integer);
  end;

  TData = class
  public
    class function GetUltimoDiaMes(const pData: TDate): Integer;
    class function GetNomeMes(const pData: TDate): string;
  end;

  TFormatoNumeros = class
  public
    class function GetFormatoValidoFloat(const pValor: string): Double;
  end;

  TFuncLista = class
  public
    class procedure LimparLista(const pVerticalScrollBox: TVertScrollBox;
                                const pNomeRetanguloPadrao: string); overload;

    class procedure LimparLista(const pListBox: TListBox;
                                const pNomeListBoxItem: string); overload;
  end;

implementation

Uses
  System.DateUtils;

{ TMask }

class procedure TMask.MaskFloat(const pEdit: TEdit; const pMask: string);
var
  lStrAux: string;
  lFloatAux: Single;
begin
  lStrAux := pEdit.Text;

  if lStrAux.IsEmpty then
    lStrAux := '0,00';

  lStrAux := lStrAux.Replace('.','', [rfReplaceAll]);
  lStrAux := lStrAux.Replace(',','', [rfReplaceAll]);

  lFloatAux := StrToFloat(lStrAux)/100;

  TEdit(pEdit).Text := FormatFloat(pMask, lFloatAux);
  TEdit(pEdit).GoToTextEnd;
end;

class procedure TMask.MaskText(const pEdit: TEdit; const pMask: string);
var
  lAux: string;
  I: Integer;
begin
  if (pEdit.MaxLength <> pMask.Length) then
    pEdit.MaxLength := pMask.Length;

  lAux := pEdit.Text.Replace('.', '', [rfReplaceAll]);
  lAux := lAux.Replace('-', '', [rfReplaceAll]);
  lAux := lAux.Replace('/', '', [rfReplaceAll]);
  lAux := lAux.Replace('(', '', [rfReplaceAll]);
  lAux := lAux.Replace(')', '', [rfReplaceAll]);

  lAux := FormatMaskText(pMask + ';0;_', lAux).Trim;

  for I := lAux.Length - 1 downto 0 do
  begin
    if not lAux.Chars[I].IsInArray(['0',
                                    '1',
                                    '2',
                                    '3',
                                    '4',
                                    '5',
                                    '6',
                                    '7',
                                    '8',
                                    '9']) then
      Delete(lAux, I + 1, 1)
    else
      break;
  end;

  TEdit(pEdit).Text := lAux;
  TEdit(pEdit).GoToTextEnd;
end;

{ THardware }

class procedure THardware.BotaoBackTeclado(var Key: Word);
{$IFDEF ANDROID}
var
  FService: IFMXVirtualKeyboardService;
{$ENDIF}
begin
  {$IFDEF ANDROID}
  if Key = vkHardwareBack then
  begin
    TPlatformServices.Current.SupportsPlatformService(IFMXVirtualKeyboardService, IInterface(FService));

    if (FService <> nil) and (TVirtualKeyboardState.Visible in FService.VirtualKeyBoardState) then
    // QUANDO TIRAR O TECLADO DA TELA
    else
      begin
        //aqui é quando volta de form, fecha o form que esta
      end;
  end;
  {$ENDIF}
end;

class procedure THardware.Vibrar(const pTempo: Integer);
{$IFDEF ANDROID}
var
  lVibrar: JVibrator;
{$ENDIF}
begin
  {$IFDEF ANDROID}
  //deve configurar Project > Options > USES PERMISSIONS > Vibrate
  lVibrar := TJVibrator.Wrap((SharedActivityContext.getSystemService(TJContext.JavaClass.VIBRATOR_SERVICE) as ILocalObject).GetObjectId);
  lVibrar.vibrate(pTempo);
  {$ENDIF}
end;

{ TData }

class function TData.GetNomeMes(const pData: TDate): string;
begin
  case MonthOf(pData) of
    1: Result := 'Janeiro';
    2: Result := 'Fevereiro';
    3: Result := 'Março';
    4: Result := 'Abril';
    5: Result := 'Maio';
    6: Result := 'Junho';
    7: Result := 'Julho';
    8: Result := 'Agosto';
    9: Result := 'Setembro';
    10: Result := 'Outubro';
    11: Result := 'Novembro';
    12: Result := 'Dezembro';
  end;
end;

class function TData.GetUltimoDiaMes(const pData: TDate): Integer;
begin
  Result := MonthDays[IsLeapYear(YearOf(pData)), MonthOf(pData)];
end;

{ TFuncLista }

class procedure TFuncLista.LimparLista(const pVerticalScrollBox: TVertScrollBox;
  const pNomeRetanguloPadrao: string);
var
  lRetanguloLiberar: TRectangle;
  lI: Integer;
  lTotalFilhos: Integer;
begin
  pVerticalScrollBox.BeginUpdate;

  lTotalFilhos := Pred(pVerticalScrollBox.Content.ChildrenCount);

  For lI:= lTotalFilhos downto 0 do
  begin
    if (pVerticalScrollBox.Content.Children[lI] is TRectangle) then
    begin
      if not (pVerticalScrollBox.Content.Children[lI].Name = pNomeRetanguloPadrao) then
      begin
        lRetanguloLiberar := (pVerticalScrollBox.Content.Children[lI] as TRectangle);
        lRetanguloLiberar.DisposeOf;
        lRetanguloLiberar := nil;
      end;
    end;
  end;

  pVerticalScrollBox.EndUpdate;
end;

class procedure TFuncLista.LimparLista(const pListBox: TListBox;
  const pNomeListBoxItem: string);
var
  lListBoxItemLiberar: TListBoxItem;
  lI: Integer;
  lTotalFilhos: Integer;
begin
  pListBox.BeginUpdate;

  lTotalFilhos := Pred(pListBox.Content.ChildrenCount);

  For lI:= lTotalFilhos downto 0 do
  begin
    if (pListBox.Content.Children[lI] is TListBoxItem) then
    begin
      if not (pListBox.Content.Children[lI].Name = pNomeListBoxItem) then
      begin
        lListBoxItemLiberar := (pListBox.Content.Children[lI] as TListBoxItem);
        lListBoxItemLiberar.DisposeOf;
        lListBoxItemLiberar := nil;
      end;
    end;
  end;

  pListBox.EndUpdate;
end;

{ TFormatoNumeros }

class function TFormatoNumeros.GetFormatoValidoFloat(
  const pValor: string): Double;
begin
  Result := pValor.Replace('.', ',', [rfReplaceAll]).ToDouble;
end;

end.
