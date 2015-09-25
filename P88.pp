program P88;
uses
  sysutils, NumberTheoryUnit, dateutils, gvector;

type
  TIntVector = specialize TVector<Integer>;
const
  Max = 12000;

var
  dp: array [0..100 * Max] of TIntVector;
  Primes: TIntList;

function Compute(n: Integer): TIntVector;
  function Find(vec: TIntVector; n: Integer): Boolean;
  var
    i: Integer;

  begin
    for i := 0 to vec.Size - 1 do
      if vec[i] = n then
        Exit(True);
    Result := False;
  end;

var
  i, j: Integer;
  Factors: TFactorization;
  Multipliers: TIntList;
  S: Integer;
  m: Integer;
  tmp: TIntVector;

begin
  if Max < n then
    tmp := nil;
  if dp[n] <> nil then
    Exit(dp[n]);

  Result := TIntVector.Create;
  dp[n] := Result;
  Result.PushBack(1);

  Factors := Factorize(n);
  Multipliers := GenerateAllDivisors(Factors);
  for i := 0 to Multipliers.Count - 1 do
  begin
    if Multipliers[i] = 1 then
      Continue;
    if Multipliers[i] = n then
      Continue;

    m := Multipliers[i];
    tmp := Compute(n div m);

    for j := 0 to tmp.Size - 1 do
    begin
      if (0 <= n - m - n div m) and (not Find(Result, tmp[j] + 1 + n - (m + n div m))) then
        Result.PushBack(tmp[j] + 1 + n - (m + n div m));
    end;
  end;
end;

var
  T1: TDateTime;
  Filled: array [0..10 * Max] of Integer;
  Count : Integer;
  i, j, k: Integer;
  Answer: TIntVector;
  Sum: Integer;
  Values: TIntList;

begin
  T1 := Now;

  FillChar(Filled[0], Length(Filled) * SizeOf(Filled[0]), 0);
  Filled[0]:= 0;
  Primes := GenerateAllPrimes(Max);

  dp[1] := TIntVector.Create;
  dp[1].PushBack(1);
  Filled[1] := 1;
  Count:= 1;

  i := 1;
  while Count <> Max do
  begin
    Answer := Compute(i);

    for j := 0 to Answer.Size - 1 do
    begin
      if Max < Answer[j]  then
        continue;

      if Filled[Answer[j]] = 0 then
      begin
        Inc(Count);
        Filled[Answer[j]] := i;
      end;
    end;

    Inc(i);
  end;

  Values := TIntList.Create;
  Sum := 0;
  for i := 2 to Max do
    if Values.IndexOf(Filled[i]) = -1 then
    begin
      Values.Add(Filled[i]);
      Sum += Filled[i];
      WriteLn(i, ' ', Filled[i], ' ', Sum);
    end;
  Writeln('Sum = ', Sum);




  Primes.Free;

  WriteLn('Count = ', Count);
  WriteLn('Now = ', MilliSecondsBetween(Now, T1));

end.
