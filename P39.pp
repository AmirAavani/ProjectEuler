program P39;

function IsValid(a, b: Integer; var c: Integer): Boolean;
begin
  c := Round(Sqrt(a * a + b * b));
  if a * a + b * b = c * c then
    Result := True
  else
    Result := False;
end;

var
  a, b, c: Integer;
  p: Integer;
  Count: array [0..1000] of Integer;
  Max, MaxIndex: Integer;

begin
  for a := 1 to 400 do
    for b := a to 400 do
    begin
      if (IsValid(a, b, c)) and (a + b + c <= 1000) then
      begin
        Inc(Count[a + b + c]);
      end;
    end;

  Max := -1;
  for p := 0 to 1000 do
    if Max < Count[p]  then
    begin
      Max := Count[p];
      WriteLn(p, ' ', Max, ' ', a, ' ', b, ' ', c);
    end;
end.
