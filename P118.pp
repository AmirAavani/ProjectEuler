{$O3}
program P118;
uses
  NumberTheoryUnit, sysutils, dateutils, Classes;

var
  Primes: TIntList;

function Generate(const CurrentSet: AnsiString; CurrentNum: AnsiString; Count: Integer): Integer;
  function IsSorted(const S: AnsiString): Boolean;
  var
    S1: TStringList;
    i: Integer;

  begin
    S1 := TStringList.Create;

    ExtractStrings([','], [' '], PChar(S), S1);
    Result := True;
    for i := 0 to S1.Count - 2 do
      if S1[i] > S1[i + 1] then
        Exit(False);

    S1.Free;

  end;

var
  i: Integer;

begin
  if (CurrentSet <> '')  and (not IsSorted(CurrentSet)) then
    Exit(0);

  if Count = 9 then
  begin
    // WriteLn(CurrentSet, ' ', CurrentNum);
    Exit(1);
  end;

  Result := 0;
  if IsPrime(StrToInt(CurrentNum), Primes) then
    Result += Generate(CurrentSet + ',' + CurrentNum, '0', Count + Length(CurrentNum));

  for i := 1 to 9 do
    if (Pos(Chr(48 + i), CurrentSet) = 0) and (Pos(Chr(48 + i), CurrentNum) = 0) then
      Result += Generate(CurrentSet, IntToStr(StrToInt(CurrentNum) * 10 + i), Count);
end;

var
  MS: TDateTime;

begin
  MS := Now;
  Primes := GenerateAllPrimes(100000);

  WriteLn(Generate('', '0', 0));

  WriteLn('MS = ', MilliSecondsBetween(MS, Now));

end.
