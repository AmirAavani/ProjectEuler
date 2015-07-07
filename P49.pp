program P49;
uses
  SysUtils, NumberTheoryUnit;
var
  Primes: TIntList;
  FourDigitPrimes: TIntList;
  i: Integer;

function MyCompare(const a, b: Integer): Integer;
  function Sort(S: AnsiString): AnsiString;
  var
    i, j: Integer;
    c: Char;

  begin
    Result := S;
    for i := 1 to Length(Result) do
      for j := i + 1 to Length(Result) do
        if Result[i] < Result[j] then
        begin
          c := Result[i];
          Result[i] := Result[j];
          Result[j] := c;
        end;
  end;

var
  Sa, Sb: AnsiString;
  i, j: Integer;
  c: Char;
begin
  Sa := Sort(IntToStr(a));
  Sb := Sort(IntToStr(b));

  if Sa < Sb then
    Exit(-1);
  if Sb < Sa then
    Exit(+1);

  Result := 0;
end;

var
  j, k: Integer;
  bPrimes: array [0..9999] of Boolean;
begin
  Primes := GenerateAllPrimes(9999);
// 4-digit primes
  FourDigitPrimes := TIntList.Create;

  for i := 0 to Primes.Count - 1 do
    if 1000 < Primes[i]  then
    begin
//      WriteLn(Primes[i]);
      FourDigitPrimes.Add(Primes[i]);
    end;
//  WriteLn(FourDigitPrimes.Count, ' ', Primes.Count);
  FillChar(bPrimes, SizeOf(bPrimes), 0);
  for i := 0 to FourDigitPrimes.Count - 1 do
    bPrimes[FourDigitPrimes[i]] := True;

  for i := 1000 to 9999 do
    if bPrimes[i] then
      for j := i + 1 to 9999 do
        if (MyCompare(i, j) = 0) and ((MyCompare(j, 2 * j - i) = 0)) and (2 * j - i <= 9999) and(bPrimes[j] and bPrimes[j + (j - i)]) then
        begin
          WriteLn(i, ' ', j, ' ', 2 * j - i);
          WriteLn(i, j, 2 * j - i);
        end;





end.
