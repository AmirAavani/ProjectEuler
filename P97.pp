program P97;
uses
  sysutils, dateutils, NumberTheoryUnit;

const
  Modulo : uInt64 = 9765625; // 5^10

function Pow2(n: Integer): uInt64;
begin
  if n = 0 then
    Exit(1)
  else if n = 1 then
    Exit(2);
  Result := Pow2(n div 2);
  Result := (Result * Result) mod Modulo;
  if n mod 2 = 1 then
    Result *= 2;

  Result := Result mod Modulo;
end;

var
  a, b: uInt64;
  T: TDateTime;
  ms, rs: TIntList;

begin
  a := 10000000000;
  WriteLn(a * a);
  Exit;
  T := Now;

  a := Pow2(7830457);
  WriteLn(a);

  a *= 28433;
  WriteLn(a);

  a := a mod Modulo;
  WriteLn(a);

  a := (a + 1) mod Modulo;
  WriteLn('Res mod 5^10 = ', a);
  b := 1;
  WriteLn('Res mod 2^10 = ', b);

  ms := TIntList.Create;
  ms.Add(Modulo);
  ms.Add(1024);
  rs := TIntList.Create;
  rs.Add(a);
  rs.Add(1);

  WriteLn(ChineseRemainderTheorem(ms, rs));

  WriteLn('MS = ', MilliSecondsBetween(T, Now));
end.
