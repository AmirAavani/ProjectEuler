program P40;
 // 1000000

uses
  SysUtils;
function D(n: Integer): Integer;
var
  l: Integer;
  dCount: Integer;
  Count: Integer;
  Ten: Int64;
  FirstDigit: Integer;
  FDigit: Integer;
  S: AnsiString;
  i: Integer;

begin
  if n <= 9 then
    Exit(n);

  Ten := 1;
  Count := 0;

  for l := 1 to 8 do
  begin
    Count += (9 * Ten) * l;
    if n <= Count then
    begin
      dCount := l;
    //  WriteLn('l = ', l, ' Count = ', Count, 'n = ', n);
      Count -= (9 * Ten) * l;
      break;
    end;
    Ten *= 10;
  end;

  Ten := Ten div 10;
  for FirstDigit := 1 to 9 do
  begin         //FirstDigit dCount
    if n <= Count + dCount * (10 * Ten) then
    begin
      FDigit:= FirstDigit;
      break;
    end;
    Count +=  dCount * (10 * Ten);
  end;

  S := IntToStr((n - Count - 1) div  dCount);
  for i := Length(S) + 1 to dCount - 1 do
    S := '0' + S;
  S := IntToStr(FDigit) + S;        {count,..,n}
  Result := StrToInt(S[((n - Count - 1) mod dCount) + 1]);
end;

var
  S: AnsiString;
  Index, vIndex: Integer;
  i: Integer;
  P: Int64;
  Current: Integer;
  Values: array [0..10] of String;

begin
  S := '';
  i := 1;
  Index := 0;
  vIndex := 0;
{  D(10);
  for i := 1 to 10000 do
  begin
    if i mod 100 = 0 then
      WriteLn;
    Write(D(i));
  end;
  Exit;
}  P := 1;
  Current := 1;
  P := D(1);;
  P *= D(10);
  P *= D(100);
  P *= D(1000);
  P *= D(10000);
  P *= D(100000);
  P *= D(1000000);
  WriteLn(P);

end.
