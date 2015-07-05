program P43;
uses
  SysUtils;

var
  Primes: array[0..10] of Integer;

  C: Integer;

function Count(S: AnsiString): uInt64;
var
  i: Char;
  n: Integer;

begin
  n := Length(S);
  if n = 10 then
  begin
    Inc(C);
    if (StrToInt(Copy(S, n - 2, 3)) mod Primes[n]) = 0 then
    begin
      WriteLn(S);
      Exit(StrToInt(S))
    end
    else
      Exit(0);
  end;
//143095   2867
  Result := 0;
  if (n < 4) or ((StrToInt(Copy(S, n - 2, 3)) mod Primes[n]) = 0) then
    for i := '0' to '9' do
      if Pos(i, S) = 0 then
        Result += Count(S + i);
end;

begin
  Primes[4] := 2;
  Primes[5] := 3;
  Primes[6] := 5;
  Primes[7] := 7;
  Primes[8] := 11;
  Primes[9] := 13;
  Primes[10] := 17;

  C:= 0;
  WriteLn(Count(''));
  WriteLn(C);
end.
