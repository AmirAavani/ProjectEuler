program P26;
uses
  fgl;

function ComputeReciprocalCycleLength(n: Integer): Integer;
type
  TIntIntMap = specialize TFPGMap<Integer, Integer>;
var
  Remainder : TIntIntMap;
  Current: Integer;
  Index: Integer;
  i: Integer;

begin
  Remainder := TIntIntMap.Create;

  i := 0;
  Current := 1;
//  WriteLn(n);
  while Remainder.IndexOf(Current) = -1 do
  begin
    //WriteLn(i, ':', Current);
    Remainder.Add(Current, i);
    Current *= 10;
    Current := Current mod n;
    Inc(i);
  end;
  if Current = 0 then
    Exit(0);
  Index := Remainder.IndexOf(Current);
  Result := i - Index;
end;

var
  i: Integer;
  Max, MaxIndex: Integer;


begin
  for i := 2 to 1000 do
    if Max < ComputeReciprocalCycleLength(i) then
    begin
      WriteLn(i, ':', ComputeReciprocalCycleLength(i));
      Max := ComputeReciprocalCycleLength(i);
      MaxIndex := i;
    end;

end.
