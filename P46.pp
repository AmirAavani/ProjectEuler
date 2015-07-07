program P46;
uses
  NumberTheoryUnit;

var
  Primes: TIntList;
  Squares: TIntList;
  i, j: Integer;
  n: Integer;
  Possible: array [0..10000000] of Boolean;


begin
  Primes := GenerateAllPrimes(1000000);
  Squares := TIntList.Create;
  for i := 0 to 1000 do
    Squares.Add(i * i);
  FillChar(Possible, SizeOf(Possible), 0);

  for i := 0 to Squares.Count - 1 do
    for j := 0 to Primes.Count - 1 do
      if 2 * Squares[i] + Primes[j] <= High(Possible) then
      begin
        if (j = 3) and (i = 2) then
          n := 2 * Squares[i] + Primes[j];
        Possible[2 * Squares[i] + Primes[j]] := True;
      end;

  i := 3;
  j := 1;
  while True do
  begin
    if Primes[j] = i then
    begin
      Inc(i, 2);
      Inc(j);
    end
    else if Possible[i] then
      Inc(i, 2)
    else
    begin
      WriteLn(i);
      Inc(i, 2);
    end;
  end;


end.
