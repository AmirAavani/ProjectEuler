program P117;
const N = 50;

var
  DP: array [0..N] of UInt64;

function Compute(n: Integer): UInt64;
begin
  if n < 0 then
    Exit(0);

  if n <= 1 then
    Exit(1);

  if Dp[n] <> 0 then
    Exit(Dp[n]);

  Result := Compute(n - 1);
  Result += Compute(n - 2);
  Result += Compute(n - 3);
  Result += Compute(n - 4);

  Dp[n] := Result;
end;

begin
  WriteLn(Compute(N));

end.
bbb
brr
rrb
ggg
