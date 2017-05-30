program P134;
{
  Let l = log(p1) and L = 10^l.

  n = k p2
  n = p1 (mod L)
  k p2 = p1 (mod L)
  k * p2 = p1 (mod L)
  k = p1 * p2^{-1} (mod L)
}
uses
  NumberTheoryUnit;
const
  Max = 1000003;

var
  i: Integer;
  Primes: TIntList;
  p1, p2: Integer;
  P2Inv: Int64;
  TenToL: Integer;
  n, k: Int64;
  Sum : uInt64;

begin
  Primes := GenerateAllPrimes(Max);

  TenToL := 1;
  Sum := 0;
  for i := 2 to Primes.Count - 2 do
  begin
    p1 := Primes[i];
    p2 := Primes[i + 1];

    while TenToL < p1 do
      TenToL *= 10;

    P2Inv := ModularMultiplicativeInverse(p2, TenToL);
    k := (p1 * p2Inv) mod TenToL;
    n := k * p2;
    Sum += n;
    if i mod 100 = 0 then
      WriteLn(n mod TenToL, ' ', n mod p2, ' ', p1, ' ', Sum);
  end;
  WriteLn('Sum = ', Sum);

end.
