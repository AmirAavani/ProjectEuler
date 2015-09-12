program P82;
uses
  Math, dateutils, sysutils;
var
  Mat: array [0..80, 0..80] of Integer;
  n: Integer;

procedure ReadData;
var
  r, c: Integer;

begin
  n := 80;
  for r := 1 to n do
  begin
    for c := 1 to n do
    begin
      Read(Mat[r, c]);
    end;
    ReadLn;
  end;

end;

var
  T1: TDateTime;
  r, c, r2: Integer;
  MinRes: Integer;
  S: Integer;
  DP:  array [0..80, 0..80] of Integer;
  Path:  array [0..80, 0..80] of Integer;
  SumRow: array [0..80] of Integer;

begin
  T1 := Now;
  ReadData;

  FillChar(Dp, SizeOf(DP), 127);
  for r := 1 to n do
    Dp[r, n] := Mat[r, n];

  for c := n - 1 downto 1 do
  begin
    FillChar(SumRow, SizeOf(SumRow), 0);

    for r := 1 to n do
      SumRow[r] := SumRow[r - 1] + Mat[r, c];

    for r := 1 to n do
    begin
      DP[r, c] := DP[r, c + 1] + Mat[r, c];
      Path[r, c] := r;

      for r2 := 1 to r - 1 do
        if  DP[r2, c + 1] + (SumRow[r] - SumRow[r2 - 1]) < DP[r, c] then
          DP[r, c] := DP[r2, c + 1] + (SumRow[r] - SumRow[r2 - 1]);
      for r2 := r + 1 to n do
        if  DP[r2, c + 1] + (SumRow[r2] - SumRow[r - 1]) < DP[r, c] then
          DP[r, c] := DP[r2, c + 1] + (SumRow[r2] - SumRow[r - 1]);

    end;
  end;

  MinRes := MaxInt;
  for r := 1 to n do
    if DP[r, 1] < MinRes then
    begin
      MinRes := Dp[r , 1];
      WriteLn(r, ':', MinRes);
    end;
  WriteLn('Min = ', MinRes);


  WriteLn(' ms = ', MilliSecondsBetween(Now, T1));
end.
