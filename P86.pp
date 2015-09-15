program P86;
uses
  dateutils, sysutils, Math;

function IsPerfectSquare(n: Integer): Boolean;
var
  tmp: Integer;

begin
  tmp := Trunc(Sqrt(n));
  Exit(Sqr(tmp) = n);

end;

function IsAnswer(a, b, c: Integer): Boolean;
begin
  Result := IsPerfectSquare(Sqr(c) + Sqr(a + b));
end;

function SolCount(Sum, z: integer): integer;
var
  x, y: integer;
begin
  Result := 0;

  for x := 1 to Sum div 2 do
  begin
    y := Sum - x;
    if y <= z then
      Inc(Result);
  end;

end;

function SolCount(m: Integer): Integer;
var
  c, a_b: Integer;
begin
  Result := 0;
  for c := 1 to m do
    for a_b := 2 to 2 * c do
      if IsAnswer(a_b, 0, c) then
        Result += SolCount(a_b, c);
end;

var
  m: Integer;
  Count: Integer;
  T1: TDateTime;

  Top, Bot, Mid: Integer;


begin
  T1 := Now;

  Top := 1;
  while SolCount(top) < 1000000 do
    Top *= 2;
  Bot := Top div 2;

  while Bot <= Top do
  begin
    Mid := (Bot + Top) div 2;
    Count := SolCount(Mid);

    if Count <= 1000000 then
      Bot := Mid + 1
    else
    begin
      Top := Mid - 1;
      m := Mid;
    end;
  end;

  WriteLn(m, ' ', SolCount(m));
  WriteLn('MS = ', MilliSecondsBetween(Now, T1));

end.
