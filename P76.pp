program P76;
uses
  fgl, sysutils, dateutils;

var
  dp: array[0..100, 0..100] of Int64;

function Compute(n: Integer; Num: Integer): Int64;
var
  i: Integer;
begin
  if n = 0 then
    Exit(1);
  if n < Num then
    Exit(0);
  if dp[n, Num] <> -1 then
    Exit(dp[n, Num]);


  Result := 0;
  for i := 0 to n div Num do
    Result += Compute(n - i * Num, Num + 1);

  dp[n, Num] := Result;
end;

var
  T1, T2: TDateTime;

begin
  T1 := Now;
  FillChar(dp, SizeOf(dp), 255);

  WriteLn(Compute(100, 1) - 1);


  T2 := Now;

  WriteLn('MS = ', MilliSecondsBetween(T2, T1));
end.
