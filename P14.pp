program P14;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes
  { you can add units after this };

var
  DP: array[0..10000000] of Integer;

function Calc(n: Int64): Integer;
begin
  if n < 1000000  then
    if DP[n] <> -1 then
      Exit(DP[n]);

  if Odd(n) then
   Result := 1 + Calc(3 * n + 1)
  else
    Result := 1 + Calc(n div 2);

  if n < 1000000 then
   DP[n] := Result;
end;

var
  i: Integer;
  Max: Integer;

begin
  FillChar(DP, SizeOf(DP), 255);
  DP[1] := 1;
  i := 1;

  for i := 1 to 1000000 do
  begin
    if Max < Calc(i) then
     begin
       WriteLn(i, ' ', Calc(i));
       Max := Calc(i);
     end;
  end;

end.

