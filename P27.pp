program P27;
uses
  NumberTheoryUnit;

var
  Primes: TIntList;
  a, b: Integer;
  n: Int64;
  Max: Integer;
begin
  Primes := GenerateAllPrimes(10000000);
  for a := -999 to 999 do
    for b := -999 to 999 do
    begin
        n := 0;
        while IsPrime(n * n + a * n + b, Primes) do
          Inc(n);
        if Max < n then
        begin
          Max := n;
          WriteLn(a, ' ', b, ' ', Max, ' ', a * b);
        end;

      end;


end.
