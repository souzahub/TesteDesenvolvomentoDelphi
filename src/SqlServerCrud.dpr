program SqlServerCrud;

uses
  Vcl.Forms,
  uMain in 'uMain.pas' {MainForm},
  uDados in 'uDados.pas' {dmDados: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TdmDados, dmDados);
  Application.Run;
end.
