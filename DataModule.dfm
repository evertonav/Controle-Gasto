object dm: Tdm
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 454
  Width = 514
  object FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink
    Left = 304
    Top = 32
  end
  object FDConn: TFDConnection
    Params.Strings = (
      
        'Database=C:\Users\Everton\Desktop\Controle de Gastos\Nova pasta\' +
        'DB\Datashop.db'
      'OpenMode=ReadWrite'
      'LockingMode=Normal'
      'DriverID=SQLite')
    LoginPrompt = False
    Left = 80
    Top = 48
  end
  object qrGetTipoGasto: TFDQuery
    Connection = FDConn
    SQL.Strings = (
      'SELECT'
      '  COD_TIPO_GASTO,'
      '  NOME_TIPO_GASTO'
      'FROM'
      '  TIPO_GASTO')
    Left = 312
    Top = 168
  end
  object qrGetGastos: TFDQuery
    Connection = FDConn
    SQL.Strings = (
      'SELECT'
      '  SUM(G.VALOR_GASTO) AS VALOR_GASTO,'
      '  TP.NOME_TIPO_GASTO,'
      '  TP.COD_TIPO_GASTO'
      'FROM'
      '  GASTO G'
      'JOIN '
      '  TIPO_GASTO TP ON TP.COD_TIPO_GASTO = G.COD_TIPO_GASTO'
      'WHERE DATA_GASTO >= :DATA_INI'
      '  AND DATA_GASTO <= :DATA_FIM'
      'GROUP BY '
      '  TP.NOME_TIPO_GASTO,'
      '  TP.COD_TIPO_GASTO')
    Left = 64
    Top = 144
    ParamData = <
      item
        Name = 'DATA_INI'
        DataType = ftFloat
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'DATA_FIM'
        DataType = ftFloat
        ParamType = ptInput
        Value = Null
      end>
  end
  object qrDeletar: TFDQuery
    Connection = FDConn
    SQL.Strings = (
      'DELETE FROM GASTO WHERE COD_GASTO = :COD_GASTO')
    Left = 224
    Top = 192
    ParamData = <
      item
        Name = 'COD_GASTO'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
  object qrGetTotalGasto: TFDQuery
    Connection = FDConn
    SQL.Strings = (
      'SELECT'
      '  SUM(VALOR_GASTO) AS VALOR_GASTO'
      'FROM'
      '  GASTO'
      'WHERE DATA_GASTO > :DATA_INI'
      '  AND DATA_GASTO < :DATA_FIM')
    Left = 120
    Top = 200
    ParamData = <
      item
        Name = 'DATA_INI'
        DataType = ftFloat
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'DATA_FIM'
        DataType = ftFloat
        ParamType = ptInput
        Value = Null
      end>
  end
  object qrGetGastoUnitario: TFDQuery
    Connection = FDConn
    SQL.Strings = (
      'SELECT'
      '  G.COD_GASTO,'
      '  SUM(G.VALOR_GASTO) as VALOR_GASTO'
      'FROM'
      '  GASTO G'
      'WHERE DATA_GASTO > :DATA_INI'
      '  AND DATA_GASTO < :DATA_FIM'
      '  AND G.COD_TIPO_GASTO = :ICOD_TIPO_GASTO'
      'GROUP BY G.VALOR_GASTO')
    Left = 72
    Top = 272
    ParamData = <
      item
        Name = 'DATA_INI'
        DataType = ftFloat
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'DATA_FIM'
        DataType = ftFloat
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'ICOD_TIPO_GASTO'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
end
