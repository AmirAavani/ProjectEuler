program P24;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes
  { you can add units after this };
var
  Factorial : array [0..10] of Integer;


var
  Index : Integer;// = 1000000;

var
  i, j: Integer;
  Used: array [0..10] of Integer;

begin
  Factorial[0] := 1;
  for i := 1 to 10 do
    Factorial[i] := Factorial[i - 1] * i;

  Index := 1000000;
  FillChar(Used, SizeOf(Used), 255);

  for i := 0 to 9 do
  begin
    for j := 0 to 9 do
      if Used[j] = -1 then
      begin
        if Factorial[9 - i] < Index then
        begin
          Index := Index - Factorial[9 - i];
          //WriteLn(i, ' ' ,  Index);
        end
        else
        begin
          Used[j] := i;
          Write(j, ' ');
          Break;
        end;
      end;
  end;

  WriteLn(Index);
end.

