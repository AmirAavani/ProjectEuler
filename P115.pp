{$O3}
program P115;
const
  N = 10000;
  M = 50;

var
  dp: array [0..N] of uInt64;

function Compute(n: Integer): uInt64;
var
  i, j: Integer;

begin
  if n < M then
    Exit(1);

  if dp[n] <> 0 then
    Exit(dp[n]);

  Result := 1;
  for i := M to n do
    for j := 1 to n - i + 1 do// j,..,j + i - 1 <= n
      Result += Compute(n - i - j);

  dp[n] := Result;;
end;

var
  i: Integer;

begin
  FillChar(Dp, SizeOf(Dp), 0);

  for i := 1 to N do
  begin
    WriteLn(i, ' ', Compute(i));
    if 1000000 < Compute(i) then
      break;


  end;
end.
