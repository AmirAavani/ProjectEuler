program P72;
uses
  NumberTheoryUnit;

var
  d: Integer;
  n: Int64;
  Factors: TFactorization;
  Primes : TIntList;

begin
  Primes := GenerateAllPrimes(1000000);
  n := 0;

  for d := 2 to 1000000 do
  begin
    Factors := Factorize(d, Primes);
    n += ComputePhi(d, Factors);
    Factors.Free;
  end;

  WriteLn(n);

end.
