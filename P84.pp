program P84;
{$assertions on}
uses
  Classes, SysUtils, strutils;
const
  Table_str: String =
    ('GO:A1:CC1:A2:T1:R1:B1:CH1:B2:B3:JAIL' +
    ':C1:U1:C2:C3:R2:D1:CC2:D2:D3:FP' +
    ':E1:CH2:E2:E3:R3:F1:F2:U2:F3:G2J' +
    ':G1:G2:CC3:G3:R4:CH3:H1:T2:H2');
  CC_Cards_str: String =
    ('GO:JAIL:*:*:*:*:*:*:*:*:*:*:*:*:*:*');
  CH_Cards_str: String =
    ('GO:JAIL:C1:E3:H2:R1:R:R:U:-3' +
    ':*:*:*:*:*:*');

type
  TCards = TStringList;

var
  Counts: array[0..39] of Integer;
  CC_Cards, CH_Cards: TCards;
  Table: TStringList;
  CC: TCards;
  CH: TCards;


function Shuffle(var Cards: TStringList): TStringList;
var
  i, j: Integer;
  n: Integer;
  Possible: array of Boolean;

begin
  SetLength(Possible, Cards.Count);
  Result := TCards.Create;
  FillChar(Possible[0], Length(Possible) * SizeOf(Possible[0]), True);

  for i := 0 to Cards.Count - 1 do
  begin
    n := Random(Cards.Count - i);

    for j := 0 to Cards.Count - 1 do
      if Possible[j] then
      begin
        if n = 0 then
        begin
          Possible[j] := False;
          Result.Add(Cards[j]);
          Break;
        end;
        Dec(n);
      end;
    Assert(n = 0, IntToStr(n));
  end;

 // WriteLn(Result.Text);
  SetLength(Possible, 0);

end;

const
  N = 4;
var
  SpecialCell: TStringList;

procedure Play(CC, CH: TCards; Table: TStringList);
  function TakeACard(Cards: TCards): AnsiString;
  begin
    Result := Cards[0];
    Cards.Delete(0);
    Cards.Add(Result);

  end;

  procedure Roll(var a, b: Integer);
  begin
    a := Random(N) + 1;
    b := Random(N) + 1;
  end;

  function FindNext(Current: Integer; Name: AnsiString): Integer;
  var
    i: Integer;
  begin
    for i := 0 to Table.Count - 1 do
      if Copy(Table[(Current + i) mod Table.Count], 1, Length(Name)) = Name then
        Exit((Current + i) mod Table.Count);
    Assert(False);
  end;

  function HandleSpecialCell(Current: Integer): Integer;
  var
    ActionCard: AnsiString;
    i: Integer;

  begin
    if Table[Current] = 'G2J' then
    begin
      Current := Table.IndexOf('JAIL');
      Inc(Counts[Current]);
    end
    else if Copy(Table[Current], 1, 2) = 'CC' then
    begin
     ActionCard := TakeACard(CC);
     if ActionCard = 'GO' then
       Current := Table.IndexOf('GO')
     else if ActionCard = 'JAIL' then
       Current := Table.IndexOf('JAIL')
     else if ActionCard = '*' then
       Exit(Current)
     else
       assert(False);
     Inc(Counts[Current]);
    end
    else if Copy(Table[Current], 1, 2) = 'CH' then
    begin
     ActionCard := TakeACard(CH);
     if ActionCard = 'GO' then
       Current := Table.IndexOf('GO')
     else if ActionCard = 'JAIL' then
       Current := Table.IndexOf('JAIL')
     else if ActionCard = 'C1' then
       Current := Table.IndexOf('C1')
     else if ActionCard = 'E3' then
       Current := Table.IndexOf('E3')
     else if ActionCard = 'H2' then
       Current := Table.IndexOf('H2')
     else if ActionCard = 'R1' then
       Current := Table.IndexOf('R1')
     else if ActionCard = 'R' then
       Current := FindNext(Current, 'R')
     else if ActionCard = 'U' then
       Current := FindNext(Current, 'U')
     else if ActionCard = '-3' then
       Current := (Current + Table.Count - 3) mod Table.Count
     else if ActionCard = '*' then
     else
       assert(False);
     if ActionCard <> '*' then
       Inc(Counts[Current]);
    end
    else
      assert(False);

    Result := Current;
  end;

var
  Pos : Integer;
  a, b: Integer;
  DoubleCount: Integer;
  i: Integer;
  Current: Integer;
begin
  DoubleCount := 0;
  Current := 0;
  for i := 1 to 1000 do
  begin
    Roll(a, b);
    // WriteLn(a, ' ', b, ' ', Current);
    if a = b then
      Inc(DoubleCount)
    else
      DoubleCount := 0;

    if DoubleCount = 3 then
    begin
      DoubleCount := 0;
      Current := Table.IndexOf('JAIL');
      assert(Current <> -1);
      Inc(Counts[Current]);
    end
    else
    begin
      Current += (a + b);
      Current := Current mod Table.Count;
      Inc(Counts[Current]);

      if SpecialCell.IndexOf(Table[Current]) <> -1 then
        Current := HandleSpecialCell(Current);

    end;

  end;

end;

var
  i, j: Integer;
  Indices: array [0..40] of Integer;

begin

  FillChar(Counts, SizeOf(Counts), 0);

  CC_Cards := TStringList.Create;
  CH_Cards := TStringList.Create;
  Table := TStringList.Create;
  ExtractStrings([':'], [], PChar(CC_Cards_str), CC_Cards);
  ExtractStrings([':'], [], PChar(CH_Cards_str), CH_Cards);
  ExtractStrings([':'], [], PChar(Table_str), Table);

  SpecialCell := TStringlist.Create;
  ExtractStrings([':'], [], PChar('G2J:CC1:CC2:CC3:CH1:CH2:CH3'), SpecialCell);

  for i := 1 to 400000 do
  begin
    if i mod 4000 = 0 then
      WRiteLn(i div 4000);

    CC := Shuffle(CC_Cards);
    CH := Shuffle(CH_Cards);

    Play(CC, CH, Table);

    CC.Free;
    CH.Free;
  end;

  for i := 0 to Table.Count - 1 do
    Indices[i] := i;

  for i := 0 to Table.Count - 1 do
    for j := i + 1 to Table.Count - 1 do
      if Counts[Indices[i]] < Counts[Indices[j]] then
      begin
       Indices[i] := Indices[i] xor Indices[j];
       Indices[j] := Indices[i] xor Indices[j];
       Indices[i] := Indices[i] xor Indices[j];
      end;

  for i := 0 to 5 do
    WriteLn(Indices[i], ' ', Table[Indices[i]], ' ', Counts[Indices[i]]);


  SpecialCell.Free;
  CC_Cards.Free;
  CH_Cards.Free;
  Table.Free;
end.
