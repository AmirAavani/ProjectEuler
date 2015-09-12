program P78;
uses
  dateutils, sysutils;
const
  Max = 100000;
  Modulo = 1000000;
var
  dp: array [0..2, 0..Max] of Integer;

var
  i, j, k: Integer;
  tmp: Int64;
  T1, T2: TDateTime;

procedure FirstApproach;
begin
  T1 := Now;
  FillChar(dp[i], SizeOf(dp[i]), 0);

  tmp := 1;
  for j := 0 to Max do
    dp[1, j] := 1;

  for i := 2 to Max do
  begin
    for j := 0 to Max do
    begin
      tmp := dp[(i and 1) xor 1, j];
      if j >= i then
        tmp += dp[(i and 1), j - i];
      dp[i and 1, j] := tmp mod Modulo;
    end;
    //Inc(dp[i and 1, i]);

    // WriteLn(i, ' ', dp[i and 1, i]);
    if dp[i and 1, i] mod 1000000 = 0 then
    begin
      WriteLn(i);
      break;
    end;



  end;

  WriteLn('MS = ',  MilliSecondsBetween(Now, T1));
end;

var
  p: array [0..Max] of Integer;

procedure SecondApproach;
var
  i, j, m, n: Integer;

begin
  T1 := Now;
  FillChar(p, SizeOf(p), 0);

  p[0] := 1;
  p[1] := 1;
  for i := 1 to Max do
  begin
    tmp := 0;
    for m := 2 to 2 * i do
    begin
      if not Odd(m) then
        n := m div 2
      else
        n := - (m div 2);
      j := n * (3 * n - 1) div 2;
      if i < j then
        break;
      // Write(j, ' ' );
      if not Odd(Abs(n)) then
        tmp -= p[i - j]
      else
        tmp += p[i - j];
      tmp := tmp mod Modulo;
    end;
    // WriteLn(i, ' ', tmp);
    p[i] := tmp;
    if p[i] = 0 then
    begin
      WriteLn(i);
      break;
    end;

  end;

  WriteLn('MS = ',  MilliSecondsBetween(Now, T1));
end;

begin
  SecondApproach
end.
