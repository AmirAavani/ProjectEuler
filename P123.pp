program P123;
uses
  NumberTheoryUnit;

const
  Max = 10000000000;

var
  Primes: TIntList;
  n, Pn: Integer;
  Result_n : Int64;

begin
  Primes := GenerateAllPrimes(1000000);
  WriteLn(Primes.Count);

  for n := 3 to Primes.Count - 1 do
  begin
    Pn := Primes[n - 1];

    Result_n := 0;
    if Odd(n) then
      Result_n:= 2 * n * Pn
    else
      Result_n:= +2;
    Result_n:= Result_n mod (Pn * Pn);

    if Max < Result_n  then
    begin
      WriteLn(n, ' ', Result_n);
      Break;
    end;

  end;


end.
{
(p-1)^n= (-1)^n + n * (-1)^(n-1)p (mod p^2)
(p+1)^n= (+1)^n + n * (+1)^(n-1)p (mod p^2)


}
