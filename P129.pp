program P129;
const
  Threshold : Integer = 1000000;

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
  MaxTillNow: Integer;


begin
  WriteLn(Count(7));
  WriteLn(Count(41));
  WriteLn(Count(17));

  MaxTillNow := -1;
  UpdateCounter := 0;
  n := 1000000;
  while True do
  begin
    Inc(n);
    if (n mod 2 = 0) or (n mod 5 = 0) then
      Continue;

    if MaxTillNow < Count(n) then
    begin
      MaxTillNow := Count(n);
      Inc(UpdateCounter);
      if UpdateCounter mod 100 = 0 then
        WriteLn(UpdateCounter, ':', n, ' ', MaxTillNow);
    end;
    if Threshold < MaxTillNow then
    begin
      WriteLn(n, ' ', MaxTillNow);
      break;
    end;
  end;
end.
