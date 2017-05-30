program P135;
{
 (y+d)^2 - y^2 - (y-d)^2 = n.
 4yd - y^2 = n.
 y(4d - y) = n.

 y>d

 n=27:
   y=1, d=7
   y=3, d=3
  y=9, d=3
   y=27,d=7

}
uses
  NumberTheoryUnit;

const
  Max = 1000000;


var
  Primes: TIntList;

function CountSolution(n: Integer): Integer;
var
  Factors: TFactorization;
  Divisors: TIntList;
  i: Integer;
  y, d, divisor: Integer;

begin
  Result := 0;

  Factors := Factorize(n, Primes);
  Divisors := GenerateAllDivisors(Factors);

  for i := 0 to Divisors.Count - 1 do
  begin
    y := Divisors[i];

    // 4d - y = n / y
    if ((n div y) + y) mod 4 = 0 then
    begin
      d := ((n div y) + y) div 4;
      if y * (4 * d - y) <> n then
        WriteLn('ERROR');
      if d < y then
        Inc(Result);
    end;

  end;

  Factors.Free;
  Divisors.Free;

end;

var
  n: Integer;
  Count: Integer;

begin
  Primes := GenerateAllPrimes(Max);
  Count := 0;

  for n := 1 to Max do
  begin
    if CountSolution(n) = 10 then
    begin
      Inc(Count);
      WriteLn(Count, ' ', n);
    end;
  end;
  Primes.Free;

end.
