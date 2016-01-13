program P109;
uses
  SysUtils;
var
  Cards: array [0..62] of Integer;
  SCards: array [0..62] of AnsiString;
  IsDouble: array [0..62] of Boolean;

procedure SetUp;
var
  i: Integer;

begin
  Cards[0] := 0;
  SCards[0] := '0';
  for i := 1 to 20 do
  begin
    Cards[i] := i;
    SCards[i] := 'S' + IntToStr(i);
  end;
  for i := 21 to 40 do
  begin
    Cards[i] := 3 * (i - 20);
    SCards[i] := 'T' + IntToStr(i - 20);
  end;
  Cards[41] := 25;
  SCards[41]:= 'S25';
  for i := 42 to 61 do
  begin
    Cards[i] := 2 * (i - 41);
    SCards[i] := 'D' + IntToStr(i - 41);
  end;
  Cards[62] := 50;
  SCards[62] := 'S50';
  FillChar(IsDouble, SizeOf(IsDouble), 0);
  IsDouble[0] := True;
  for i := 42 to 62 do
    IsDouble[i] := True;
end;


var
  i, j, k: Integer;
  Counts: array [0..100] of Integer;
  Sum : Integer;

begin
  SetUp;
  FillChar(Counts, SizeOf(Counts), 0);
  i := 0; j := 0;
  for k := 1 to High(Cards) do
    if IsDouble[k] then
    begin
      if Cards[i] + Cards[j] + Cards[k] <= High(Counts) then
        Inc(Counts[Cards[i] + Cards[j] + Cards[k]]);
    end;

  i := 0;
  for j := 1 to High(Cards) do
    for k := 1 to High(Cards) do
      if IsDouble[k] then
      begin
        if Cards[i] + Cards[j] + Cards[k] <= High(Counts) then
          Inc(Counts[Cards[i] + Cards[j] + Cards[k]]);
      end;


  for i := 1 to High(Cards) do
    for j := i to High(Cards) do
      for k := 1 to High(Cards) do
        if IsDouble[k] then
        begin
          if Cards[i] + Cards[j] + Cards[k] <= High(Counts) then
            Inc(Counts[Cards[i] + Cards[j] + Cards[k]]);
        end;

  Sum := 0;
  for i := 1 to 99 do
  begin
    WriteLn(i, ':', Counts[i]);
    Inc(Sum, Counts[i]);
  end;
  WriteLn(Sum);


end.
