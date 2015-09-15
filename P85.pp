program P85;
uses
  sysutils, dateutils;

var
  m, n: Integer;
  MinArea: Integer;

function Cn2(n: Integer): Int64;
begin
  Result := n * (n - 1) div 2;
end;

function Compute(n, m: Integer): Int64;
begin
  Result := Cn2(n + 1) * Cn2(m + 1);
end;

var
  T1: TDateTime;

begin
  T1 := Now;
  WriteLn(Compute(3, 2));
  MinArea:= 2000000;
  for m := 1 to 1000 do
    for n := 1 to 1000 do
      if abs(Compute(n, m) - 2000000) < MinArea then
      begin
        MinArea:= abs(Compute(n, m) - 2000000);
        WriteLn('m = ', m, ' n = ', n, ' ', m * n, ' ', Compute(n, m), ' ', MinArea);
      end;

  WriteLn('MS = ', MilliSecondsBetween(T1, Now));
end.
