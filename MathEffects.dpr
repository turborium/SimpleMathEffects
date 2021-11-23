program MathEffects;

uses
  Vcl.Forms,
  UnitMain in 'UnitMain.pas' {FormMain},
  MathParser.Compiler in 'MathParser.Compiler.pas',
  MathParser.Parser in 'MathParser.Parser.pas',
  MathParser.Types in 'MathParser.Types.pas',
  MathParser.VirtualMachine in 'MathParser.VirtualMachine.pas',
  Effects in 'Effects.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormMain, FormMain);
  Application.Run;
end.
