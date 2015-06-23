program P23;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes, NumberTheoryUnit
  { you can add units after this };

var
  Abundants: TIntList;

function GenerateAllAbundants(Max: Integer): TIntList;
var
  i: Integer;
  Factors: TFactorization;
  Primes: TIntList;

begin
  Primes := GenerateAllPrimes(Max);
  Result := TIntList.Create;

  for i := 2 to Max do
  begin
    Factors := Factorize(i, Primes);
    if i < SumOfDivisors(Factors) - i then
    begin
      Result.Add(i);
//      WriteLn(i);
    end;
  end;

  Primes.Free;
end;
const Max = 28123;

var
  IsReachable: array [0..Max] of Boolean;
  i, j: Integer;
  Result : Int64;

begin
  Abundants := GenerateAllAbundants(Max);

  FillChar(IsReachable, SizeOf(IsReachable), 0);
  for i := 0 to Abundants.Count - 1 do
    for j := 0 to Abundants.Count - 1 do
      if Abundants[i] + Abundants[j] <= Max then
        IsReachable[Abundants[i] + Abundants[j]] := True;

  Result := 0;
  for i := 0 to Max - 1 do
    if not IsReachable[i] then
      Result += i;

  WriteLn(Result);

end.

