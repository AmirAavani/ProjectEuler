program P68;
uses
  SysUtils;

const
  Triples : array [1..5, 1..3] of Integer = (
    (1, 2, 3),
    (4, 3, 5),
    (6, 5, 7),
    (8, 7, 9),
    (10, 9, 2)
  );
  TopCell : array [1..10] of Boolean =
    (False, False, False, True, False, True, False, True, False, True);
  MidCell : array [1..10] of Boolean =
    (False, True, True, False, True, False, True, False, True, False);

var
  Values: array[0..10] of Integer;
  Max: AnsiString;
  IsUsed: array[0..10] of Boolean;

procedure Generate(Index: Integer);
var
  i, j: Integer;
  S: AnsiString;
  Sum, Tmp: Integer;
  Flag: Boolean;

begin
  if Index = 11 then
  begin
    S := '';
    for i := 1 to 5 do
      for j := 1 to 3 do
        S += IntToStr(Values[Triples[i, j]]);
    if Length(S) = Length(Max) then
      if Max < S then
      begin
        Max := S;
        WriteLn(Max);
      end;
    Exit;
  end;

  if 3 < Index  then
  begin
    Sum := Values[1] + Values[2] + Values[3];
    for i := 2 to 5 do
    begin
      Flag := False;

      Tmp := 0;

      for j := 1 to 3 do
      begin
        if Values[Triples[i, j]] = 0 then
        begin
          Flag := True;
          break;
        end;
        Tmp += Values[Triples[i, j]];
      end;
      if not Flag then
        if Tmp <> Sum then
          Exit;
    end;
  end;

  for i := 1 to 10 do
    if not IsUsed[i] then
    begin
      if Index = 1 then
        WriteLn;

      if MidCell[Index] and (i = 10) then
        Continue;

      IsUsed[i] := True;
      Values[Index] := i;

      if TopCell[Index] then
        if i < Values[1] then
        begin
          Values[Index] := 0;
          IsUsed[i] := False;
          Continue;
        end;

      Generate(Index + 1);

      Values[Index] := 0;
      IsUsed[i] := False;
    end;

end;

begin
  Max := '0000000000000000';

  FillChar(IsUsed, SizeOf(IsUsed), 0);

  Generate(1);
end.
