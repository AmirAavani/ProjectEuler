program P41;
uses
  NumberTheoryUnit, sysutils;

var
  Primes: TIntList;

function Pandigital(n: Integer; S: AnsiString = ''): Integer;
var
  i : char;

begin
  if Length(S) = n then
  begin
    if IsPrime(StrToInt(S)) then
      Exit(StrToInt(S))
    else
      Exit(-1);
  end;

  for i := Char(48 + n) downto '1' do
    if Pos(i, S) = 0 then
    begin
      Result := Pandigital(n, S + i);
      if Result <> -1 then
        Exit;
    end;

end;

var
  i: Integer;

begin
  Primes := GenerateAllPrimes(10000);

  for i := 7 downto 1 do
  begin
    WriteLn(i, ' ', Pandigital(i));
  end;

end.
