program P34;
uses
  SysUtils;

var
  Fact: array [0..9] of Int64;

function SumFact(Sn: AnsiString; Debug: Boolean = False): Int64;
var
  i: Integer;
begin
  Result := 0;
  for i := 1 to Length(Sn) do
  begin
    if Debug then
      WriteLn(Result, ' ', Fact[Ord(Sn[i]) - 48], ' ', Sn[i]);
    Result += Fact[Ord(Sn[i]) - 48];
  end;
end;

var
  i: Integer;
  Sum: Int64;
  Sn: AnsiString;

begin
  Fact[0] := 1;
  for i := 1 to 9 do
    Fact[i] := Fact[i - 1] * i;
  i := 40730;
  Sn := IntToStr(i);
  if i = SumFact(Sn) then
    WriteLn(SumFact(IntToStr(40730), True));
  Sum := 0;
  for i := 3 to Fact[9] * 1000 do
  begin
    Sn := IntToStr(i);
    if i = SumFact(Sn) then
    begin
      Sum += i;
      WriteLn('***');
      WriteLn(Sum, ' ', i, ' ');
      SumFact(Sn, True);
    end; 
  end; 
  WriteLn(Sum);
end.    
