program P113;
var
  IncMemory, DecMemory: array[0..100, 0..100] of Int64;

  function ComputeInc(len, digit: Integer): uInt64;
  var
    d: Integer;

  begin
    if 0 < IncMemory[Len, Digit] then
      Exit(IncMemory[Len, Digit]);

    if len = 1 then
      Exit(1);

    Result := 0;
    for d := digit to 9 do
      Result += ComputeInc(len - 1, d);
    IncMemory[Len, digit] := Result;
  end;

function ComputeDec(len, digit: Integer): uInt64;
var
  d: Integer;

begin
  if 0 < DecMemory[Len, Digit] then
    Exit(DecMemory[Len, Digit]);

  if len = 1 then
    Exit(1);

  Result := 0;
  for d := digit downto 0 do
    Result += ComputeDec(len - 1, d);
  DecMemory[Len, digit] := Result;
end;

const
  Max : Integer = 100;
var
  i, d: Integer;
  Sum : uInt64;

begin
  FillChar(IncMemory, SizeOf(IncMemory), 255);
  FillChar(DecMemory, SizeOf(DecMemory), 255);

  Sum := 0;
  for i := 1 to Max do //1000000
  begin
    for d := 1 to 9 do
    begin
      Sum += ComputeInc(i, d) + ComputeDec(i, d) - 1;
      WriteLn(i, ' ', d, ' ', ComputeInc(i, d), ':', ComputeDec(i, d));
    end;
    WriteLn(Sum);
  end;

//  WriteLn(Round(Exp(ln(10) * Max)) - 1 - Sum);

end.
