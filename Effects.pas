unit Effects;

{$POINTERMATH ON}

interface

uses
  Windows, Classes, SysUtils, Graphics;

function TryDrawEffect(const Bitmap: TBitmap; const Effects: array of string): Boolean;

implementation

uses
  MathParser.Types, MathParser.Parser, Math;

type
  PPixelRGB = ^TPixelRGB;
  TPixelRGB = packed record
    B, G, R: Byte;
  end;

function ClipValue(const Value: Integer): Byte;
begin
  if Value < 0 then
    Exit(0);
  if Value > 255 then
    Exit(255);

  Result := Value;
end;

function TryDrawEffect(const Bitmap: TBitmap; const Effects: array of string): Boolean;
var
  Y: Integer;
  X: Integer;
  Scanline: PPixelRGB;
  Color: TPixelRGB;
  ParserR, ParserG, ParserB: TMathParser;
begin
  Assert(Bitmap.PixelFormat = pf24bit);
  Assert(Length(Effects) = 3);

  try
    ParserR := nil;
    ParserG := nil;
    ParserB := nil;
    try
      ParserR := TMathParser.Create;
      ParserG := TMathParser.Create;
      ParserB := TMathParser.Create;

      ParserR.CompileExpression(Effects[0]);
      ParserG.CompileExpression(Effects[1]);
      ParserB.CompileExpression(Effects[2]);

      ParserR.DefineVariable('t', GetTickCount / 1000);
      ParserG.DefineVariable('t', GetTickCount / 1000);
      ParserB.DefineVariable('t', GetTickCount / 1000);

      for Y := 0 to Bitmap.Height - 1 do
      begin
        ParserR.DefineVariable('y', Y / Max(1, (Bitmap.Height - 1)));
        ParserG.DefineVariable('y', Y / Max(1, (Bitmap.Height - 1)));
        ParserB.DefineVariable('y', Y / Max(1, (Bitmap.Height - 1)));
        Scanline := Bitmap.ScanLine[Y];
        for X := 0 to Bitmap.Width - 1 do
        begin
          ParserR.DefineVariable('x', X / Max(1, (Bitmap.Width - 1)));
          ParserG.DefineVariable('x', X / Max(1, (Bitmap.Width - 1)));
          ParserB.DefineVariable('x', X / Max(1, (Bitmap.Width - 1)));
          try
            Color.R := ClipValue(Trunc(ParserR.Calculate() * 255));
            Color.G := ClipValue(Trunc(ParserG.Calculate() * 255));
            Color.B := ClipValue(Trunc(ParserB.Calculate() * 255));
          except
            Color.R := 0;
            Color.G := 0;
            Color.B := 0;
          end;
          Scanline[X] := Color;
        end;
      end;
    finally
      ParserR.Free;
      ParserG.Free;
      ParserB.Free;
    end;
  except
    Exit(False);
  end;

  Result := True;
end;

end.
