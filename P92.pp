program P92;
uses
  gvector, dateutils, sysutils;

function ComputeSum(n: Integer): Integer;
var
  d: Integer;

begin
  Result := 0;
  while n <> 0 do
  begin
    d := n mod 10;
    Result += d * d;
    n := n div 10;
  end;

end;

type
  TIntVector = specialize TVector<Integer>;

var
  dp: array[0..10000000] of Byte;

function Compute(n: Integer): Integer;
var
  i: Integer;
  s: Integer;
  Values: TIntVector;

begin
  if dp[n] <> 0 then
    Exit(dp[n]);

  Values := TIntVector.Create;

  while (dp[n] = 0) do
  begin
    Values.PushBack(n);
    s := ComputeSum(n);
    n := S;
  end;

  for i := 0 to Values.Size - 1 do
    dp[Values[i]] := dp[n];
end;

var
  i: Integer;
  Count: Integer;
  T1 : TDateTime;

begin
  T1 := Now;

  FillChar(dp, SizeOf(dp) * SizeOf(Byte), 0);

  dp[1] := 1;
  dp[89] := 89;

  for i := 1 to High(dp) do
    if dp[i] = 0 then
      Compute(i);

  Count := 0;
  for i := 1 to High(dp) do
    if dp[i] = 89 then
      Inc(Count);
  WriteLn(Count);

  WriteLn('MS = ', MilliSecondsBetween(T1, Now));
end.
