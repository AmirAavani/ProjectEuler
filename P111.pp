program P111;
{$R+}
uses
  NumberTheoryUnit, classes, sysutils, dateutils;
const
  N = 10;

var
  PrimeList: TIntList;
  i: Integer;
  d: Integer;
  Mnd, Nnd, Snd: array[0..9] of Int64;
  Values: array[0..9] of TIntList;
  Sum: Int64;

function Find(d: Integer): Int64;

  function IsThere(d, nd, nnd: Integer; CurrentVal: Int64; var Count: Integer; var Sum: Int64): Boolean;
  var
    i: Integer;

  begin
    if (nd = 0) and (nnd = 0) then
    begin
      if Length(IntToStr(CurrentVal)) < N then
        Exit(False);

      Result := IsPrime(CurrentVal, PrimeList);
      if Result then
      begin
        Sum += CurrentVal;
        Inc(Count);
      end;
      Exit;

    end;

    Result := False;
    if 0 < nd then
      if IsThere(d, nd - 1, nnd, CurrentVal * 10 + d, Count, Sum) then
        Result := True;
    if 0 < nnd then
      for i := 0 to 9 do
        if (i <> 0) or (CurrentVal <> 0) then
           if IsThere(d, nd, nnd - 1, CurrentVal * 10 + i, Count, Sum) then
             Result := True;
  end;

var
  m: Integer;
  c: Integer;

begin
  Result := 0;
  c := 0;
  for m := N downto 1 do
    if IsThere(d, m, N - m, 0, c, Result) then
    begin
      WriteLn(d, ' ', m, ' ', c, ' ', Result);
      Exit;
    end;

end;

var
  MS: TDateTime;

begin
  MS := Now;

  PrimeList := GenerateAllPrimes(Trunc(Sqrt(Exp(ln(10) * N) + 1)));
  WriteLn(PrimeList.Count);

  Sum := 0;
  for d := 0 to 9 do
  begin
    Sum += Find(d);

  end;

  WriteLn('The answer is ', Sum);


  WriteLn('MS = ', MilliSecondsBetween(Now, MS));
end.
