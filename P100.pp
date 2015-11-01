program P100;
uses
  BigInt, GenericFactoryUnit, WideStringUnit;

var
  b0, n0, b, n: Int64;

begin
  {
  n^2 + 0 nb -2b^2 - n + 2b + 0 = 0
  A = 1
  B = 0
  C = -2
  D = -1
  E = 2
  }
  b0 := 15;
  n0 := 21;

  n := n0;
  b := b0;
  while n < 1000000000000 do
  begin
     b0 := 3 * b + 2 * n - 2;
     n0 := 4 * b + 3 * n - 3;
     b := b0;
     n := n0;
  end;
  WriteLn(b, ' ', n);
end.
