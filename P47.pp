program P47;
uses
  NumberTheoryUnit;

var
  Primes: TIntList;
  Count: array[0..1000000] of Integer;
  i: Integer;
  Factorization: TFactorization;
  First4: Integer;

begin
  Primes := GenerateAllPrimes(1000);

  First4:= 0;
  for i := 1 to High(Count) do
  begin
    Factorization := Factorize(i, Primes);
    if Factorization.Count = 4 then
    begin
      if First4 = -1 then
        First4 := i;

      if i - First4 + 1 = 4 then
      begin
        WriteLn(First4, ' ', i);
        break;
      end;
    end
    else
      First4 := -1;
    Factorization.Free;
  end;



  Primes.Free;
end.
