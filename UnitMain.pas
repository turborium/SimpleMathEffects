unit UnitMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, MathParser.Parser, MathParser.Types, Vcl.ComCtrls;


{
int(1.2-sqrt((x-0.5-sin(t)*0.3)^2 + (y-0.5)^2));
int(1.1-sqrt((x-0.5-sin(t)*0.4)^2 + (y-0.5-cos(t)*0.4)^2));
int(1.4-sqrt((x-0.5)^2 + (y-0.5)^2))

cos(sin(x*13+cos(y*7-t)) + sin(x*3.5-y*2-t*0.4) -t );
0.1*abs(7*cos(sin(x*13+cos(y*7-t)) + sin(x*3.5-y*2-t*0.4) -t ));
0

int(4*sqrt((x-0.5)*(y-0.5)*(cos(t*3)*8)));
int(3*sqrt((x-0.5)*(y-0.5)*(cos(t*3)*8)));
int(6*sqrt((x-0.5)*(y-0.5)*(cos(t*3)*8)))


}

type
  TFormMain = class(TForm)
    Ok: TButton;
    ImageDisp: TImage;
    TimerDraw: TTimer;
    StatusBar: TStatusBar;
    MemoEffect: TMemo;
    procedure OkClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TimerDrawTimer(Sender: TObject);
  private
    Effects: TArray<string>;
    procedure SetEffectString(const NewEffect: string);
    procedure DrawEffect;
  public
    { Public declarations }
  end;

var
  FormMain: TFormMain;

implementation

uses
  Effects, StrUtils;

{$R *.dfm}

procedure TFormMain.OkClick(Sender: TObject);
begin
  SetEffectString(MemoEffect.Lines.Text);
end;

procedure TFormMain.SetEffectString(const NewEffect: string);
var
  NewEffectArray: TArray<string>;
begin
  NewEffectArray := string(NewEffect).Replace(#13, '').Replace(#10, '').Split([';']);

  if Length(NewEffectArray) = 3 then
  begin
    Effects := NewEffectArray;
    DrawEffect;
  end else
    StatusBar.Panels[0].Text := 'Invalid expression count. Example "x; y; x + y"';
end;

procedure TFormMain.DrawEffect;
var
  Buffer: TBitmap;
begin
  Buffer := TBitmap.Create;
  try
    Buffer.PixelFormat := pf24bit;
    Buffer.SetSize(64, 64);
    if TryDrawEffect(Buffer, Effects) then
      StatusBar.Panels[0].Text := 'Ok'
    else
      StatusBar.Panels[0].Text := 'Invalid expression';

    ImageDisp.Picture.Assign(Buffer);
  finally
    Buffer.Free;
  end;
end;

procedure TFormMain.FormCreate(Sender: TObject);
const
  DefEffect = 'cos(sin(x*13+cos(y*7-t)) + sin(x*3.5-y*2-t*0.4) -t );' +
    '0.1*abs(7*cos(sin(x*13+cos(y*7-t)) + sin(x*3.5-y*2-t*0.4) -t ));0';
begin
  MemoEffect.Lines.Text := DefEffect;
  SetEffectString(DefEffect);
end;

procedure TFormMain.TimerDrawTimer(Sender: TObject);
begin
  DrawEffect;
end;

end.
