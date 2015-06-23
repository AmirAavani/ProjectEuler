program P21;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes, NumberTheoryUnit
  { you can add units after this };

var
  d: array [0..10000] of Integer;
  i, j: Integer;
  Sum: Integer;
  Primes: TIntList;

  f: TFactorization;
  Result : Integer;

begin
  Primes := GenerateAllPrimes(10000);

  for i := 2 to 10000 do
  begin
    f := Factorize(i, Primes);
    D[i] := SumOfDivisors(f) - i;
    WriteLn(i, ' ', D[i]);
    f.Free;
  end;

  WriteLn('****');
  Result := 0;
  for i := 1 to 9999 do
    if (D[i] <= 9999) and (D[D[i]] = i) and (D[i] <> i) then
    begin
      Result += i;
      WriteLn(i, ' ', D[i]);
    end;
  WriteLn(Result);
end.

