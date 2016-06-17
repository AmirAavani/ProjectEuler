program P131;
{
m^3 = n^3 + pn^2.
    = n^2(n + p)
n = p1^m1 p2^m2... pk^mk
m^3 = p1^(2m1) p2^(2m2)... pk^(2mk) (n+ p)
if 3 does not count mi,
  pi^(3[mi/3]+1) | m^3 => pi | n+ p => pi | p.

  So, either n^2 is a cubic number (which means that n itself is a cubic number)
  or pn^2 is a cubic number. But then pn^2(n+p) is not a perfect cube.

  We have n + p is a perfect cube.
  k^3= n + p.
  l^3= n^2.
  o^3 = n
  m^3= n^2(n+p)

  p = k^3 - o^3
    = (k-o)(k^2+o^2+ko)
    => k-o = 1
}
uses
  NumberTheoryUnit;
const
  Max : uInt64 = 1000000;

var
  Primes: TIntList;

function Cube(n: UInt64): uInt64;
begin
  Result := Sqr(n);
  Result *= n;
end;

function IsPerfectCube(n: uInt64): Boolean;
var
  Top, Bot, Mid: uInt64;

begin
  Top := 1;
  while Cube(Top) < n do
    Top *= 2;
  Bot := 0;

  while Bot <= Top do
  begin
    Mid := (Bot + Top) div 2;
    if Cube(Mid) < n then
      Bot := Mid + 1
    else if n < Cube(Mid) then
      Top := Mid - 1
    else
      Exit(True);
  end;
  Result := False;
end;

var
  i: Integer;
  a, p: Integer;
  Count: Integer;
  n: UInt64;

begin
  Primes := GenerateAllPrimes(1000000);
{
  Count := 0;
  for p := 1 to Max * Max do
    if IsPrime(p) then
      for n := 1 to 10 * Max do
        if IsPerfectCube(Cube(n) + p * Sqr(n)) then
        begin
          Inc(Count);
          WriteLn(Count, ':', n, ' ', p);
        end;
 }
  Count := 0;
  for n := 2 to Max do
  begin
    if Max < Cube(n) - Cube(n - 1) then
      break;
    if IsPrime(Cube(n) - Cube(n - 1)) then
    begin
      Inc(Count);
      WriteLn(Count, ':', n, ' ', Cube(n) - Cube(n - 1));
    end;
  end;
  WriteLn(Count);

  Primes.Free;
end.
