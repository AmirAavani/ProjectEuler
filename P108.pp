{$O3}
program P108;
{
1/x + 1/y = 1/z
=>
  x=km(m+n)
  y=kn(m+n)
  z=kmn,

  where gcd(m,n) = 1.
  z= 4  = 2^2
  =>   k = 2^0 -> m = 4, n = 1
  =>   k = 2^1 -> m = 2, n = 1
  =>   k = 2^2 -> m = 1, n = 1

  }
uses
  NumberTheoryUnit;
var
  Primes: TIntList;

function Count(n: Integer): Integer;
var
  Factorization: TFactorization;
  i: Integer;

begin
  Result := 1;
// 0 -> 2
// 1 -> 2
// ... -> 2
// n -> 1
  Factorization := Factorize(n, Primes);

  for i := 0 to Factorization.Count - 1 do
    Result *= (2 * Factorization[i].Power + 1);
  Result := 1 + (Result - 1) div 2;

end;

var
  n : Integer;
  c: Integer;
  m: Integer;

begin
  Primes := GenerateAllPrimes(1000000);
  n := 2;
  m := -1;

  while True do
  begin
    c := Count(n);
    if m < c then
    begin
      m := c;
      WriteLn(n, ' ', c);
    end;

    if 1000 <  c then
      break;
    Inc(n);
  end;

  WriteLn(n);
  Primes.Free;
end.
