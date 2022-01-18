program TestStr2Int;

{$mode objfpc}{$H+}

uses
  Interfaces, Forms, GuiTestRunner, main;

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TGuiTestRunner, TestRunner);
  Application.Run;
end.

