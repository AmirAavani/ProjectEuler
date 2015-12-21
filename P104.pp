program P104;
uses
  Math, sysutils, dateutils;

const
  P9 = 1000000000;

function HasAll(const n: AnsiString): Boolean;
var
  ch: Char;
  i: Integer;
  is_there: array['0'..'9'] of Integer;

begin
  FillChar(is_there, SizeOf(is_there), 0);
  for i := 1 to Length(n) do
    Inc(is_there[n[i]]);

  for ch := '1' to '9' do
    if is_there[ch] <> 1 then
      Exit(False);
  Result := True;
end;

function Pow(e: Extended; n: Integer): Extended;
begin

  if n = 0 then
    Result := 1
  else if n = 1 then
    Result := e
  else
  begin
    Result := Pow(e, n div 2);
    Result *= Result;
    if Odd(n) then
      Result *= e;
  end;
end;

const
  Phi = (1 + Sqrt(5))/ 2.0;
  S5 = Sqrt(5);
  Ln10 = ln(10);

function Select9(n: Integer): Int64;
var
  digits: Integer;
  e, Lne: Extended;

begin
  // e := Pow(phi,n)/S5;
  Lne := n * ln(phi) - ln(S5);
  digits := trunc(Lne / Ln10 + 0.999);
  if digits  <= 10 then
  begin
    Result := Round(Exp(Lne)); // E^Lne
    // WriteLn(Result, ' ', e, ' ', digits);
  end
  else
  begin
    // f = E^Lne/10^(digits - 9)
    // Lnf = Lne - (digits - 9) * Ln(10)

    Result:= Trunc(Exp(Lne - (digits - 9) * Ln10));
    // WriteLn(Result, ' ', n);
  end;

end;

var
  i: Integer;
  n1, n2, n3: uInt64;
  r: Int64;
  T1: TDateTime;

begin
  T1 := Now;

  i := 3;

  n1 := 1; n2 := 1;
  while True do
  begin
    n3 := (n1 + n2) mod P9;
    n1 := n2;
    n2 := n3;
    if HasAll(IntToStr(n3)) then
    begin
//      WriteLn(i, ': ', n3);

      r := Select9(i);
      if HasAll(IntToStr(r)) then
      begin
        WriteLn(i, ':', r);
        break;
      end;
    end;
    Inc(i);
  end;

  WriteLn('MS = ', MilliSecondsBetween(T1, Now));
end.
