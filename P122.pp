program P122;
uses
  fgl, Math, SysUtils, dateutils;

const
  Max = 200;

type
  TIntList = array [0..21] of Integer;

var
  MinValues: array [0..Max] of Integer;
  Vals: TIntList;

function Generate(Index: Integer): Integer;
var
  i, j: Integer;

  function ToString(Vals: TIntList; Depth: Integer): AnsiString;
  var
    i: Integer;

  begin
    Result := '';
    for i := 0 to Depth - 1 do
      Result += ':' + IntToStr(Vals[i]);

  end;

begin
  if 12 <= Index then
    Exit;
  if Max < Vals[Index]  then
    Exit;


  if Index < MinValues[Vals[Index]] then
  begin
    //WriteLn('Updating ', Vals[Index], ' to ', Index, ' ', ToString(Vals, Index));
    MinValues[Vals[Index]] := Index;

  end;

  for i := 0 to Index do
  begin
    Vals[Index + 1] := Vals[i] + Vals[Index];
    Generate(Index + 1);
  end;
end;

var
  Start: TDateTime;
  i: Integer;
  Sum: Integer;

begin
  Start := Now;

  FillChar(MinValues, SizeOf(MinValues), 127);
  FillChar(Vals, SizeOf(Vals), 0);
  Vals[0] := 1;
  Vals[1] := 2;
  MinValues[0] := 0;
  MinValues[1] := 0;
  //MinValues[2] := 1;

  Generate(1);
  WriteLn('Done');
  Sum := 0;

  for i := 0 to Max do
    Sum += MinValues[i];
  WriteLn(Sum);
  WriteLn('TS = ', MilliSecondsBetween(Now, Start));

end.
