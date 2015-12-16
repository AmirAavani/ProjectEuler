{$O3}
program P103;
uses
  fgl, Math, sysutils, dateutils;

const
  N = 7;
type
  TIntBoolMap = specialize TFPGMap<Integer, Boolean>;
  TIntList = specialize TFPGList<Integer>;

var
  MinSum: Integer;
  MinAnswer: AnsiString;


function Generate(Index: Integer; LastValue: Integer; Answer: AnsiString;
                  AllSums: TIntBoolMap;
                  MinSums, MaxSums: TIntList;
                  CurrentSum: Integer): Boolean;
  function Check(v: Integer): Boolean;
  var
    i: Integer;
    key, data: Integer;
    m1, m2: Integer;
  begin

    if AllSums.IndexOf(v) <> -1 then
      Exit(False);

    Result := True;
    for i := 0 to AllSums.Count - 1 do
      if AllSums.IndexOf(AllSums.Keys[i] + v) <> -1 then
        Exit(False);

    for i := 0 to Index do
    begin
      m1 := MinSums[i + 2];
      m2 := MaxSums[i] + v;
      if MinSums[i + 2] <= MaxSums[i] + v  then
        Exit(False);
    end;
    Result := True;
  end;

var
  v, key: Integer;
  i: Integer;
  Flag: Boolean;
  NextSums: TIntBoolMap;
  NextMinSums, NextMaxSums: TIntList;

begin
  if Index = N  then
  begin
    if CurrentSum <= MinSum then
    begin
      MinSum := CurrentSum;
      MinAnswer := Answer;
      WriteLn('Updating Min', MinSum, ':', MinAnswer);
    end;
    // WriteLn(CurrentSum, ':', Answer);
    Exit(True);
  end;

  v := LastValue;
  key := MinSums[2];
  while v < MinSums[2] do
  begin
    Inc(v);
    if Check(v) then
    begin
      NextSums := TIntBoolMap.Create;

      NextSums.Add(v, True);
      for i := 0 to AllSums.Count - 1 do
      begin
        NextSums.Add(AllSums.Keys[i], True);
        NextSums.Add(AllSums.Keys[i] + v, True);
      end;

      NextMinSums := TIntList.Create;
      NextMaxSums := TIntList.Create;
      NextMinSums.Count := MinSums.Count;
      NextMaxSums.Count := MaxSums.Count;

      NextMinSums[0] := 0;
      NextMaxSums[0] := 0;

      for i := 1 to NextMaxSums.Count - 1 do
      begin
       NextMinSums[i] := Math.Min(MinSums[i - 1] + v, MinSums[i]);
       NextMaxSums[i] := Math.Max(MaxSums[i - 1] + v, MaxSums[i]);
      end;

      Generate(Index + 1, v, Answer + ':' + IntToStr(v), NextSums,
      NextMinSums, NextMaxSums, CurrentSum + v);
      NextSums.Free;
      NextMinSums.Free;
      NextMaxSums.Free;
    end;
  end;

  Result := False;
end;

var
  SumMap: TIntBoolMap;
  MinSumMap, MaxSumMap: TIntList;
  i: Integer;
  first, second: Integer;

  T1: TDateTime;
begin

  T1 := Now;

  MinSum:= MaxInt;

  for first := 1 to 10000 do
  begin
    if MinSum < n * first  then
      break;

    for second := first + 1 to 1000 do
    begin
      if MinSum < first + (n - 1) * second  then
        break;
  //   WriteLn('fs : ', first, ' ', second);

     SumMap := TIntBoolMap.Create;
     MinSumMap := TIntList.Create;
     MaxSumMap := TIntList.Create;

     MinSumMap.Count:= 10;
     MaxSumMap.Count:= 10;
     for i := 1 to MinSumMap.Count - 1 do
     begin
      MinSumMap[i] := MaxInt div 2;
      MaxSumMap[i] := -MaxInt div 2;
     end;
     MinSumMap[0] := 0;
     MaxSumMap[0] := 0;
     MinSumMap[1] := first;
     MaxSumMap[1] := second;
     MinSumMap[2] := first + second;
     MaxSumMap[2] := first + second;
     SumMap.Add(first, True);
     SumMap.Add(second, True);
     SumMap.Add(first + second, True);

     if Generate(2, second, IntToStr(first) + ':' + IntToStr(second),
              SumMap, MinSumMap, MaxSumMap, first + second) then
     begin
       SumMap.Free;
       MinSumMap.Free;
       MaxSumMap.Free;
       Break;
     end;

     SumMap.Free;
     MinSumMap.Free;
     MaxSumMap.Free;
    end;
  end;
  WriteLn('Final Answer = ', MinAnswer);
  WriteLn('MS = ', MilliSecondsBetween(T1, Now));
end.
