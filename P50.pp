program P50;
uses
  NumberTheoryUnit, fgl;
type
  TInt64List = specialize TFPGList<Int64>;

var
  Primes: TIntList;
  Sums: TInt64List;
  IsReachable: array[0..1000000] of Integer;

  i, j: Integer;
  ni, nj: Int64;
  Max, Sum: Int64;

begin
  Primes := GenerateAllPrimes(1000000);
  FillChar(IsReachable, SizeOf(IsReachable), 0);

  Sums:= TInt64List.Create;
  Sum := 0;
  Sums.Add(Sum);
  for i := 0 to Primes.Count - 1 do
  begin
    Sum += Primes[i];
    Sums.Add(Sum);
  end;

  for i := 0 to Sums.Count - 1 do
  begin
    ni := Sums[i];
    for j := i - 1 downto 0 do
    begin
      nj := Sums[j];
      if ni - nj <= High(IsReachable) then
      begin
        if IsReachable[ni - nj] < i - j then
          IsReachable[ni - nj] := i - j;
      end
      else
        break;
    end;
  end;

  WriteLn(41, ' ', IsReachable[41]);
  WriteLn(953, ' ', IsReachable[953]);
  Max := -1;
  for i := 0 to Primes.Count - 1 do
    if Max < IsReachable[Primes[i]] then
    begin
      Max := IsReachable[Primes[i]];
      WriteLn(Primes[i], ' ', Max);
    end;

  WriteLn(Max);
end.
