program P31;
var
  T : array [0..200, 1..10] of Int64;

function CalcT(n: Integer; LastCoin: Integer = 8): Int64;
const
  Coins : array [1..8] of Integer = (1, 2, 5, 10, 20, 50, 100, 200);
var
  i: Integer;

begin
  if n < 0 then
    Exit(0);
  if n = 0 then
    Exit(1);
  if LastCoin = 1 then
    Exit(1);
  if T[n, LastCoin] <> -1 then
    Exit(T[n, LastCoin]);

  Result := 0;
  for i := 0 to n div Coins[LastCoin] do
    Result += CalcT(n - i * Coins[LastCoin], LastCoin - 1);
  T[n, LastCoin] := Result;
end;

var
  i: Integer;
begin
  FillChar(T, SizeOf(T), 255);

  for i := 1 to 200 do
    WriteLn(i, ',', CalcT(i, 8));
end.
