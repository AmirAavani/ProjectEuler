program P35;
uses
  NumberTheoryUnit, SysUtils;

function IsCircular(p: Integer; Primes: TIntList): Boolean;
var
  S: AnsiString;
  i: Integer;
  pi: Integer;

begin
  Result := False;
  S := IntToStr(p);

  for i := 1 to Length(S) do
  begin
    pi := StrToInt(S);
    if not IsPrime(pi, Primes) then
      Exit;

    S := Copy(S, 2, Length(S)) + S[1];
  end;

  Result := True;

end;

var
  Primes: TIntList;
  i: Integer;
  Count: Integer;

begin
  Primes := GenerateAllPrimes(1000000);

  Count := 0;
  for i := 0 to Primes.Count - 1 do
    if IsCircular(Primes[i], Primes) then
      Inc(Count);
  WriteLn(Count);

end.
