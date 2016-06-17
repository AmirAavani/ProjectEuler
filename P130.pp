program P130;
uses
 NumberTheoryUnit;

function Count(n: Integer): Integer;
var
  Remainder: Integer;

begin
  Result := 1;
  Remainder := 1;

  while Remainder <> 0 do
  begin
    Remainder *= 10;
    Inc(Remainder);
    Remainder := Remainder mod n;
    Inc(Result);
  end;
end;

var
  n: Integer;
  UpdateCounter: Integer;
  Sum: Integer;

begin
  WriteLn(Count(7));
  WriteLn(Count(41));

  UpdateCounter := 0;
  n := 1;
  while True do
  begin
    Inc(n);
    if (n mod 2 = 0) or (n mod 5 = 0) then
      Continue;
    if IsPrime(n) then
      Continue;
    if (n - 1) mod Count(n) = 0 then
    begin
      Inc(UpdateCounter);
      WriteLn(UpdateCounter, ':', n, ' ', Count(n));
      Sum += n;
      if UpdateCounter  = 25 then
        Break;
    end;
  end;
  WriteLn(Sum);
end.
