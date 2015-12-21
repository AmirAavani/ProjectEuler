{$O3}
program P105;
uses
  fgl, Math, sysutils, dateutils, Classes;

type
  TIntBoolMap = specialize TFPGMap<Integer, Boolean>;
  TIntList = specialize TFPGList<Integer>;

function Check(const S: AnsiString): Integer;
var
  tmp: TStringList;
  Vals: TIntList;
  i, j: Integer;
  SumMap, tmpMap: TIntBoolMap;
  MaxSum, MinSum: TIntList;

begin
  tmp := TStringList.Create;
  ExtractStrings([','], [], PChar(S), tmp);

  SumMap := TIntBoolMap.Create;
  MinSum := TIntList.Create;
  MaxSum := TIntList.Create;

  Vals := TIntList.Create;
  Result := 0;
  for i := 0 to tmp.Count - 1 do
  begin
    Vals.Add(StrToInt(tmp.Strings[i]));
    Result += Vals[i];
  end;

  SumMap.Add(0, True);

  for i := 0 to Vals.Count - 1 do
  begin
   tmpMap := TIntBoolMap.Create;
   for j := 0 to SumMap.Count - 1 do
   begin
    if tmpMap.IndexOf(SumMap.Keys[j]) <> -1 then
    begin
      Result := 0;
      break;
    end;
    tmpMap.Add(SumMap.Keys[j], True);
    if tmpMap.IndexOf(SumMap.Keys[j] + Vals[i]) <> -1 then
    begin
      Result := 0;
      break;
    end;
    tmpMap.Add(SumMap.Keys[j] + Vals[i], True);
   end;
   SumMap.Free;
   SumMap := tmpMap;

    if Result = 0 then
      Exit;
  end;

  MinSum := TIntList.Create;
  MaxSum := TIntList.Create;
  MinSum.Add(0);
  MaxSum.Add(0);
  MinSum.Add(Vals[0]);
  MaxSum.Add(Vals[0]);

  for i := 1 to Vals.Count - 1 do
  begin
   MinSum.Add(MinSum[i] + Vals[i]);
   MaxSum.Add(MaxSum[i] + Vals[i]);
   for j := i downto 1 do
   begin
     MinSum[j] := Min(MinSum[j - 1] + Vals[i], MinSum[j]);
     MaxSum[j] := Max(MaxSum[j - 1] + Vals[i], MaxSum[j]);
   end;
//   WriteLn(MinSum[i + 1], ' ', MaxSum[i + 1], ' ', Vals[i]);
  end;
  for i := 1 to Vals.Count do
  begin
   if MinSum[i] <= MaxSum[i - 1] then
   begin
     Result := 0;
     break;
   end;
  end;

  MinSum.Free;
  MaxSum.Free;

  Vals.Free;
  tmp.Free;

end;

var
  StrList: TStringList;
  i: Integer;
  S: AnsiString;
  Sum: Integer;
  T1: TDateTime;

begin

  T1 := Now;

  StrList := TStringList.Create;
  StrList.LoadFromFile('p105_sets.txt');

  Sum := 0;
  for i := 0 to StrList.Count - 1 do
  begin
   S := StrList.Strings[i];
   Sum += Check(S);
  end;
  StrList.Free;

  WriteLn('Final Answer = ', Sum);
  WriteLn('MS = ', MilliSecondsBetween(T1, Now));
end.
