program P69;
uses
  NumberTheoryUnit;

var
  Primes: TIntList;
  i, m: Integer;
  Max: Double;
  Factors: TFactorization;

begin
  Primes := GenerateAllPrimes(1000000);

  Max := -1;
  for i := 2 to 1000000 do
  begin
    Factors := Factorize(i, Primes);
    m := ComputePhi(i, Factors);

    if Max < i / m then
    begin
      Max := i / m;
      WriteLn(i, ' ', m, ' ', Max:0:3);
    end;
  end;

end.
