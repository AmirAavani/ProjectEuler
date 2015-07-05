program P42;
uses
  SysUtils, classes;
var
  Words: TStringList;
  Values: array [0..1000] of Integer;

procedure Initialize;
var
  i: Integer;

begin
  Words := TStringList.Create;
  Words.LoadFromFile('p042_words.txt');
  for i := 0 to High(Values) do
    Values[i] := (i * (i + 1)) div 2;

end;

function IsThere(S: AnsiString): Boolean;
var
  Value: Integer;
  i: Integer;

  Bot, Top, Mid: Integer;

begin
  Value := 0;
  for i := 2 to Length(S) - 1 do
    Value += (Ord(S[i]) - Ord('A') + 1);

  Bot := 0;
  Top := 1000;
  while Bot <= Top do
  begin
    Mid := (Bot + Top) div 2;

    if Values[Mid] < Value then
      Bot := Mid + 1
    else if Value < Values[Mid] then
      Top := Mid - 1
    else
      Exit(True);
  end;
  Result := False;
end;

var
  i: Integer;
  Count: Integer;

begin
  Initialize;

  Count := 0;
  for i := 0 to Words.Count - 1 do
    if IsThere(Words.Strings[i]) then
      Inc(Count);
  WriteLn(Count);

  Words.Free;
end.
