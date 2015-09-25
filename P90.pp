program P90;
uses
  SysUtils, Classes;

procedure GenerateDices(AllDices: TStringList; CurrentDice: AnsiString; LastDigit: char);
begin
  if LastDigit = '9' then
  begin
    if Length(CurrentDice) = 6 then
       AllDices.Add(CurrentDice);
    Exit;
  end;

  Inc(LastDigit);
  GenerateDices(AllDices, CurrentDice, LastDigit);
  GenerateDices(AllDices, CurrentDice + LastDigit, LastDigit);

end;

const
  Targets : array [1..9] of AnsiString = ('01', '04', '06', '16', '25', '36', '46',
       '64', '81');

function GoodCombination(const d1, d2: AnsiString): Boolean;
var
  c1, c2: array['0'..'9'] of Boolean;
  i: Integer;

begin
  FillChar(c1, SizeOf(c1) * SizeOf(Boolean), 0);
  FillChar(c2, SizeOf(c2) * SizeOf(Boolean), 0);

  for i:= 1 to Length(d1) do
  begin
    c1[d1[i]] := True;
    c2[d2[i]] := True;
  end;
  if c1['9'] then
    c1['6'] := True;
  if c2['9'] then
    c2['6'] := True;



  Result := True;
  for i := 1 to 9 do
    if (c1[Targets[i][1]] and c2[Targets[i][2]]) or
       (c2[Targets[i][1]] and c1[Targets[i][2]]) then
    else
      Exit(False);

end;

var
  i, j: Integer;
  ValidDices: TStringList;
  Count: Integer;

  //0123456789
begin
  ValidDices := TStringList.Create;

  Count := 0;
  GenerateDices(ValidDices, '', #47);
  for i := 0 to ValidDices.Count - 1 do
    for j := i to ValidDices.Count - 1 do
      if GoodCombination(ValidDices[i], ValidDices[j]) then
      begin
        Inc(Count);

        if Count < 100 then
          WriteLn(Count, ' ',  ValidDices[i], ' ', ValidDices[j]);
      end;

  WriteLn(Count);
end.
