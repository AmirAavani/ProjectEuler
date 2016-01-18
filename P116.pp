program P116;
const
  N = 50;

var
  Dp: array [0..50,0..10] of UInt64;

function Compute(N: Integer; s: Integer): UInt64;
var
  i: Integer;

begin
  if N = 0 then
   Exit(1);

  if Dp[n, s] <> 0 then
   Exit(Dp[n, s]);

  Result := 1;
  for i := 1 to N - s + 1 do   // i..,i+ s - 1 <= N
    Result += Compute(N - i - s + 1, s);

  Dp[n, s] := Result;
end;

function Compute(N: Integer): UInt64;
begin
  Result := Compute(N, 2) + Compute(N, 3) + Compute(N, 4) - 3;
end;

begin
  FillChar(Dp, SizeOf(DP), 0);

  WriteLn(Compute(N));
end.
