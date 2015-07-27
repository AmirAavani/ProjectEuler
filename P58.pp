program P58;
uses
  NumberTheoryUnit;

var
  i, j, k: Integer;
  Primes: TIntList;

begin
  Primes := GenerateAllPrimes(1000000);

  i := 1;
  j := 0;
  k := 1;
  while True do
  begin
    if IsPrime(i + 2 * k, Primes) then
      Inc(j);
    if IsPrime(i + 4 * k, Primes) then
      Inc(j);
    if IsPrime(i + 6 * k, Primes) then
      Inc(j);
    if IsPrime(i + 8 * k, Primes) then
      Inc(j);
    i += 8 * k;
    WriteLn(k, ':',  j, ' ', i, ' ', j / (4 * k + 1):2:2);
    if j / (4 * k + 1) < 0.10 then
      break;
    Inc(k);
  end;
  WriteLn('***');
  WriteLn(k, ':',  j, ' ', i, ' ', j / (4 * k + 1):2:2);
  Primes.Free;
end.
