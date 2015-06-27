program P36;
uses
  NumberTheoryUnit, sysutils;
var
  i: Integer;

function IsPalindromic(S: AnsiString): Boolean;
var
  i: Integer;

begin
  for i := 1 to Length(S) do
    if S[i] <> S[Length(S) + 1 - i] then
      Exit(False);
  Result := True;
end;

var
  Sum: Int64;

begin
  Sum := 0;
  for i := 1 to 1000000 - 1 do
    if IsPalindromic(IntToStr(i)) and IsPalindromic(ToBinary(i)) then
    begin
      WriteLn(i, ' ', ToBinary(i));
      Sum += i;
    end;
  WriteLn(Sum);

end.
