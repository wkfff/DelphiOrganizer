object Login: TLogin
  Left = 333
  Top = 191
  Width = 363
  Height = 318
  Caption = 'Login'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = 16
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 120
  TextHeight = 16
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 41
    Height = 16
    Caption = 'Label1'
    Visible = False
  end
  object lbe_login: TLabeledEdit
    Left = 80
    Top = 64
    Width = 160
    Height = 28
    EditLabel.Width = 40
    EditLabel.Height = 16
    EditLabel.Caption = 'LOGIN'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -17
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
  end
  object lbe_password: TLabeledEdit
    Left = 80
    Top = 144
    Width = 160
    Height = 28
    EditLabel.Width = 79
    EditLabel.Height = 16
    EditLabel.Caption = 'PASSWORD'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -17
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    PasswordChar = '*'
    TabOrder = 1
    OnKeyPress = lbe_passwordKeyPress
  end
  object OK: TButton
    Left = 48
    Top = 208
    Width = 75
    Height = 25
    Caption = 'OK'
    TabOrder = 2
    OnClick = OKClick
  end
  object Cancel: TButton
    Left = 192
    Top = 208
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 3
  end
  object TrayIcon1: TTrayIcon
    IconType = itCustom
    Hint = 'My Tray Icon'
    Active = False
    Left = 272
    Top = 8
  end
  object cds_user_id: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftUnknown
        Name = 'login'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'password'
        ParamType = ptUnknown
      end>
    ProviderName = 'dsp_user_id'
    RemoteServer = SocketConnection1
    Left = 16
    Top = 72
  end
  object cds_user: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dsp_users'
    RemoteServer = SocketConnection1
    Left = 16
    Top = 120
  end
  object SocketConnection1: TSocketConnection
    Connected = True
    ServerGUID = '{107CD906-6347-449F-A190-BB48BA0798FB}'
    ServerName = 'ORGANAIZER_SERVER.Server_Data'
    Host = 'MVK1'
    Left = 16
    Top = 32
  end
end
