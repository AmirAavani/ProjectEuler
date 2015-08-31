program P77;
uses
  NumberTheoryUnit, dateutils, sysutils;
const
  Max = 10000;

var
  dp: array [0..Max] of array of Integer;

function Compute(n, Index: Integer; Primes: TIntList): Integer;
var
  i: Integer;

begin
  if n = 0 then
    Exit(1);

  if n < Primes[Index] then
    Exit(0);

  if dp[n, Index] <> 0 then
    Exit(dp[n, Index]);

  Result := 0;
  for i := 0 to (n div Primes[Index]) do
    Result += Compute(n - i * Primes[Index], Index + 1, Primes);

end;


var
  Primes: TIntList;
  i: Integer;
  MaxCount: Integer;
  Count: Integer;

  T1: TDateTime;

begin
  T1 := Now;

  Primes := GenerateAllPrimes(Max);
  for i := 0 to Max do
  begin
    SetLength(dp[i], Primes.Count + 1);
    FillChar(dp[i][0], SizeOf(dp[i]), 0);
  end;


  for i := 2 to Max do
  begin
    Count := Compute(i, 0, Primes);
    if MaxCount < Count then
    begin
      MaxCount := Count;
      WriteLn(i, ' ', MaxCount);
    end;

    if 5000 < MaxCount then
      break;
  end;

  WriteLn('MS = ',  MilliSecondsBetween(Now, T1));
end.
