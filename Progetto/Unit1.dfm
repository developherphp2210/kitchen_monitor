object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Service Ticket'
  ClientHeight = 210
  ClientWidth = 586
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Timer1: TTimer
    Enabled = False
    Interval = 5000
    OnTimer = Timer1Timer
    Left = 24
    Top = 16
  end
  object dbserver: TFDConnection
    Params.Strings = (
      'Database=COMANDE'
      'Password=Zm3nu,12abc'
      'Server=192.168.1.10\ZMENU,9081'
      'ApplicationName=Enterprise/Architect/Ultimate'
      'MARS=yes'
      'User_Name=sa'
      'DriverID=MSSQL')
    LoginPrompt = False
    BeforeConnect = dbserverBeforeConnect
    Left = 16
    Top = 80
  end
  object comande: TFDQuery
    Connection = dbserver
    SQL.Strings = (
      
        'select ( sum(quantita) - sum(QtaFatta) ) as prep , nComanda, Upd' +
        'ated'
      'from dbo.Comande'
      'where Consegnato=0 and cast ([Data] as date) = '#39'03/07/2023'#39
      'group by nComanda,Updated'
      'order by Updated')
    Left = 64
    Top = 152
    object comandeprep: TFMTBCDField
      FieldName = 'prep'
      Origin = 'prep'
      ReadOnly = True
      Precision = 38
      Size = 3
    end
    object comandenComanda: TIntegerField
      FieldName = 'nComanda'
      Origin = 'nComanda'
    end
    object comandeUpdated: TSQLTimeStampField
      FieldName = 'Updated'
      Origin = 'Updated'
    end
  end
  object consegnato: TFDQuery
    Connection = dbserver
    SQL.Strings = (
      
        'select distinct Consegnato , nComanda , Updated from Comande whe' +
        're Consegnato=1')
    Left = 16
    Top = 152
    object consegnatoConsegnato: TIntegerField
      FieldName = 'Consegnato'
      Origin = 'Consegnato'
    end
    object consegnatonComanda: TIntegerField
      FieldName = 'nComanda'
      Origin = 'nComanda'
    end
    object consegnatoUpdated: TSQLTimeStampField
      FieldName = 'Updated'
      Origin = 'Updated'
    end
  end
  object TrayIcon1: TTrayIcon
    Visible = True
    OnDblClick = TrayIcon1DblClick
    Left = 72
    Top = 16
  end
  object Timer2: TTimer
    OnTimer = Timer2Timer
    Left = 120
    Top = 16
  end
  object del_trans: TFDCommand
    Connection = dbserver
    Left = 72
    Top = 88
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 128
    Top = 152
  end
  object RESTClient1: TRESTClient
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'UTF-8, *;q=0.8'
    AcceptEncoding = 'identity'
    BaseURL = 'http://webservicecasa.ddnsfree.com/monitor_db.php?id=15'
    ContentType = 'application/x-www-form-urlencoded'
    Params = <>
    HandleRedirects = True
    RaiseExceptionOn500 = False
    Left = 128
    Top = 80
  end
  object RESTRequest1: TRESTRequest
    Client = RESTClient1
    Method = rmPOST
    Params = <>
    Response = RESTResponse1
    SynchronizedEvents = False
    Left = 176
    Top = 80
  end
  object RESTResponse1: TRESTResponse
    ContentType = 'text/html'
    Left = 168
    Top = 16
  end
end
