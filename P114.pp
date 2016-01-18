program P114;
const
  N : Integer = 50;

var
  dp: array [0..50] of uInt64;

function Compute(n: Integer): uInt64;
var
  i, j: Integer;

begin
  if n < 3 then
    Exit(1);

  if dp[n] <> 0 then
    Exit(dp[n]);

  Result := 1;
  for i := 3 to n do
    for j := 1 to n - i + 1 do// j,..,j + i - 1 <= n
      Result += Compute(n - i - j);

  dp[n] := Result;;
end;

begin
  FillChar(Dp, SizeOf(Dp), 0);

  WriteLn(Compute(N));
end.
