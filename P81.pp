program P81;
uses
  Math, dateutils, sysutils;
var
  Mat: array [0..80, 0..80] of Integer;
  DP:  array [0..80, 0..80] of Integer;
  n: Integer;

procedure ReadData;
var
  r, c: Integer;

begin
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
  r, c: Integer;
begin
  T1 := Now;
  n := 80;
  ReadData;

  FillChar(Dp, SizeOf(DP), 127);
  Dp[1, 0] := 0;
  for c := 1 to n do
    Dp[1, c] := Dp[1, c - 1] + Mat[1, c];


  for r := 1 to n do
    for c := 1 to n do
      DP[r, c] := Min(DP[r - 1, c], DP[r, c - 1]) + Mat[r, c];

  WriteLn(DP[n, n]);


  WriteLn(' ms = ', MilliSecondsBetween(Now, T1));
end.
