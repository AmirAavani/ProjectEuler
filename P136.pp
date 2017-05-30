program P136;
uses
  NumberTheoryUnit, classes, SysUtils, Math;

const
  Max = 50000000;

var
  y, d: Int64;
  n: Int64;
  Count : Integer;
  Counts: TIntList;

begin
  Counts:= TIntList.Create;
  Counts.Count:= Max + 1;

  {
    n = (y + 2d)^2 - (y + d)^2 - y^2.
   n = -y^2 + 3d^2 + 2yd.
   n > 0 => -y^2 + 2yd +3d^2 >= 0
        => d = (-2y -/+ 4y) / +6
        => d =      -y ... +y/3
           n =   +++ 0 ---  0 +++
  }
  for y := 1 to Max do
  begin
    for d := (y + 2) div 3 to Max do
    begin
      n := 3 * Sqr(d) + (2 * y * d) - Sqr(y);
      if n < 0 then
      begin
        WriteLn('ERROR');
        break;
      end;
      if n < Max then
        Counts[n] := Counts[n] + 1
      else
        Break;
    end;
    if y mod 1000000 = 0 then
      WriteLn(y);
  end;
  Count := 0;
  for n := 1 to Max do
    if Counts[n] = 1 then
      Inc(Count);
  WriteLn('Final Count = ', Count);
  Counts.Free;
end.
