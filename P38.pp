program P38;
uses
  SysUtils;
var
  i, n: Integer;
  CurrentStr: AnsiString;
  Max: AnsiString;

function IsValid(var S: AnsiString): Boolean;
var
  i, j: Integer;

begin
  for i := 1 to Length(S) do
    for j := i + 1 to Length(S) do
      if S[i] = S[j] then
        Exit(False);
  Result := True;
end;

function IsGood(var S: AnsiString): Boolean;
var
  c: Char;
  i: Integer;
  Flag: Boolean;

begin
  if Length(S) <> 9 then
    Exit(False);

  for c := '1' to '9' do
  begin
    Flag := False;
    for i := 1 to Length(S) do
      if S[i] = c then
      begin
        Flag := True;
        break;
      end;
    if not Flag then
      Exit(False);
  end;

  Result := True;
end;

begin
  Max := '918273645';

  for i := 9 to 1000000 do
  begin
    CurrentStr:= IntToStr(i);
    for n := 2 to 9 do
    begin
      if 9 < Length(IntToStr(i)) * n then
        Break;
      CurrentStr += IntToStr(i * n);
      if not IsValid(CurrentStr) then
        break;
      if IsGood(CurrentStr) then
      begin
        if Max < CurrentStr then
        begin
          WriteLn(i, ' ', n, ' ', CurrentStr);
          Max := CurrentStr;
        end;
        break;

      end;



    end;
  end;
end.
