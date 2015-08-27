program P73;
uses
  NumberTheoryUnit;

var
  Primes: TIntList;

function Count(d: Integer): Integer;
var
  Factors: TFactorization;
  a, b: Integer;
  i, j: Integer;
  tmp: Integer;
  Num: Integer;

begin
  Factors := Factorize(d, Primes);

  a := (d + 2)  div 3; //
  if d mod 3 = 0 then
    Inc(a);

  b := (d - 1) div 2;
  if b < a then
    Exit(0);

  WriteLn(d, ' ', a, ' ', b);

  Result := b - a + 1;
  for i := 1 to (1 shl Factors.Count) - 1 do
  begin
    Num := 0;
    tmp := 1;
    for j := 0 to Factors.Count - 1 do
    begin
      if (i and (1 shl j)) <> 0 then
      begin
        tmp *= Factors[j].Base;
        Inc(Num);
      end;
    end;

      if Odd(Num) then
        Result -= b div tmp - (a - 1) div tmp
      else
        Result += b div tmp - (a - 1) div tmp;

//      WriteLn('tmp = ', tmp, ' Result = ', Result);
  end;
   //1,2,3
  Factors.Free;

end;

var
  d: Integer;
  n: Integer;

begin
  Primes := GenerateAllPrimes(12000);
  n := 0;
  for d := 3 to 12000 do
  begin
    n += Count(d);
//    if Count(d) <> 0 then
//      WRiteLn('d = ', d, ' Count = ', Count(d));

  end;

  WriteLn(n);
end.
