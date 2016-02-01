program P121;
const
  Max = 16;
var
  dp: array [0..Max, 0..Max] of uInt64;
  i, j: Integer;
  Total: Extended;
  Sum: Extended;

begin
  FillChar(dp, SizeOf(Dp), 0);
  dp[2, 0] := 1;
  dp[2, 1] := 1;
  //dp[2, 1] := 0.5;


  Total := 2;
  for i := 3 to Max do
  begin
    Total *= i;
    dp[i, 0] := dp[i - 1, 0] * (i - 1);
    for j := 1 to i do
    begin
     dp[i, j] := dp[i - 1, j - 1] * 1 +
                dp[i - 1, j ] * (i - 1);
    end;
  end;
  Sum := 0;

  for i := (Max - 1) div 2 + 1 to Max do
      Sum += dp[Max, i];

  WriteLn('Chance of winning: ', Sum:0:0, ' ', total:0:0, ' ', (Sum / total):0:4);
  WriteLn('Answer: ', Trunc(Total / Sum));

  for i := 2 to Max do
  begin
    for j := i downto 0 do
      Write(dp[i, j], ' ');
    WriteLn;
  end;


end.
