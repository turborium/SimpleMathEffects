object FormMain: TFormMain
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'FormMain'
  ClientHeight = 651
  ClientWidth = 529
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object ImageDisp: TImage
    Left = 8
    Top = 8
    Width = 512
    Height = 512
    Stretch = True
  end
  object Ok: TButton
    Left = 446
    Top = 599
    Width = 75
    Height = 25
    Caption = 'Ok'
    TabOrder = 0
    OnClick = OkClick
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 632
    Width = 529
    Height = 19
    Panels = <
      item
        Text = 'XXX'
        Width = 50
      end>
    ExplicitLeft = 184
    ExplicitTop = 456
    ExplicitWidth = 0
  end
  object MemoEffect: TMemo
    Left = 8
    Top = 526
    Width = 512
    Height = 67
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Segoe UI'
    Font.Style = []
    Lines.Strings = (
      'x;y;x*y')
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 2
  end
  object TimerDraw: TTimer
    Interval = 33
    OnTimer = TimerDrawTimer
    Left = 512
    Top = 240
  end
end
