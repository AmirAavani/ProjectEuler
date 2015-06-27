program P37;
uses
  SysUtils, NumberTheoryUnit;

function IsTruncatable(n: Int64; Primes: TIntList): Boolean;
var
  Sn, T: AnsiString;
  i: Integer;
begin
  Result := False;
  Sn := IntToStr(n);

  for i := 1 to Length(Sn) do
  begin
    if not IsPrime(StrToInt(Copy(Sn, i, Length(Sn))), Primes) then
      Exit;
  end;
  for i := Length(Sn) downto 1 do
  begin
    if not IsPrime(StrToInt(Copy(Sn, 1, i)), Primes) then
      Exit;
  end;

  Result := True;
end;
var
  n: Integer;
  Count: Integer;
  Primes: TIntList;
  Sum: Int64;
begin
  Primes := GenerateAllPrimes(10000000);

  n := 4;
  Count := 0;
  while Count < 11 do
  begin
    if IsTruncatable(Primes[n], Primes) then
    begin
      Sum += Primes[n];
      WriteLn(Count, ' ', Primes[n], ' ', Sum);
      Inc(Count);
    end;
    Inc(n);

  end;
  WriteLn(Sum);
end.
