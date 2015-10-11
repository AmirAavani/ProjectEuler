program P96;
uses
  sysutils, dateutils;
var
  Table: array [0..9] of AnsiString;

procedure ReadData;
var
  r: Integer;
  S: AnsiString;

begin
  ReadLn(S);
  if Copy(S, 1, 4) <> 'Grid' then
    Halt(1);
  for r := 1 to 9 do
    ReadLn(Table[r]);
end;

function Solve: Integer;
  function IsValid: Boolean;
  var
    r, c: Integer;
    Visited: array ['0'..'9'] of Integer;
    Ch: Char;
    ir, ic: Integer;

  begin
    for r := 1 to 9 do
    begin
      FillChar(Visited, SizeOf(Visited), 0);

      for c := 1 to 9 do
        Inc(Visited[Table[r, c]]);
      for ch := '1' to '9' do
        if 1 < Visited[ch]  then
          Exit(False);
    end;

    for c := 1 to 9 do
    begin
      FillChar(Visited, SizeOf(Visited), 0);

      for r := 1 to 9 do
        Inc(Visited[Table[r, c]]);
      for ch := '1' to '9' do
        if 1 < Visited[ch]  then
          Exit(False);
    end;

    for ic := 1 to 3 do
      for ir := 1 to 3 do
      begin
        FillChar(Visited, SizeOf(Visited), 0);

        for r := 1 to 3 do
          for c := 1 to 3 do
            Inc(Visited[Table[3 * ir + r - 3, 3 * ic + c - 3]]);
      for ch := '1' to '9' do
        if 1 < Visited[ch]  then
          Exit(False);
    end;

    Result := True;
  end;

  function Fill(r, c: Integer): Boolean;
  var
    ch: char;

  begin

    if c = 10 then
      Exit(Fill(r + 1, 1));
    if r = 10 then
      Exit(True);

    if Table[r, c] = '0' then
    begin
      for ch := '1' to '9' do
      begin
        Table[r][c] := ch;
        if IsValid then
          if Fill(r, c + 1) then
            Exit(True);

      end;
      Table[r, c] := '0';
      Result := False;
    end
    else
      Exit(Fill(r, c + 1));

  end;

begin
  Result := 0;

  if Fill(1, 1) then
    Result := StrToInt(Copy(Table[1], 1, 3))
  else
    Result := -1;
end;

var
  T: TDateTime;
  Sum: Integer;

begin
  T := Now;
  AssignFile(Input, 'p096_sudoku.txt');
  Reset(Input);

  Sum := 0;
  while not Eof do
  begin
    ReadData;
    Inc(Sum, Solve);
    WriteLn(Sum);
  end;

  CloseFile(Input);
  WriteLn('MS = ', MilliSecondsBetween(T, Now));
end.
