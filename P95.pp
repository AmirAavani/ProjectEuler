program P95;
uses
  NumberTheoryUnit, gvector, dateutils, sysutils;

var
  Divisors: array[0..1000000] of Int64;
  Primes: TIntList;

function ComputeSum(n: Integer): Int64;
var
  i: Integer;
  Powers: Int64;
  m: Integer;

begin
  m := n;
  if n < 0 then
    n:= 0;

  if n < High(Divisors) then
    if Divisors[n] <> -1 then
      Exit(Divisors[n]);

  for i := 0 to Primes.Count - 1 do
  begin
    if n < Sqr(Primes[i]) then
    begin
      Result := (n + 1);
      if n < High(Divisors) then
        Divisors[n] := Result;
      Exit;
    end
    else if n mod Primes[i] = 0 then
    begin
      Powers := Primes[i];
      while n mod Primes[i] = 0 do
      begin
        Powers *= Primes[i];
        n := n div Primes[i];
      end;
      if n = 1 then
        Result := (Powers - 1) div (Primes[i] - 1)
      else
        Result := ComputeSum(n) * ((Powers - 1) div (Primes[i] - 1));
      if m < High(Divisors) then
        Divisors[m] := Result;
      Exit;
    end;
  end;
  Result := 1;
end;

var
  CycleLen: array[0..1000000] of Integer;

function FindCycle(n: Int64): Integer;
type
  TIntVector = specialize TVector<Integer>;

  function Find(n: Integer; Values: TIntVector): Boolean;
  var
    i: Integer;
  begin
    for i := 0 to Values.Size - 1 do
      if Values[i] = n then
        Exit(True);
    Exit(False);
  end;

var
  first: Integer;
  Values: TIntVector;
  i: Integer;

begin
  if n < 0 then
    WriteLn(n);

  first := n;
  Values := TIntVector.Create;

  Values.PushBack(n);
  n := ComputeSum(n) - n;

  while not Find(n, Values) do
  begin
    if 1000000 < n  then
    begin
      for i := 0 to Values.Size - 2 do
        CycleLen[Values[i]] := 0;
      Exit(0);
    end;

    Values.PushBack(n);
    n := ComputeSum(n) - n;

  end;

  if n <= 1000000 then
    if n = first then
    begin
      for i := 0 to Values.Size - 1 do
        CycleLen[Values[i]] := Values.Size;
      Result := Values.Size;
    end;

  Values.Free;
end;

var
  i: Integer;
  MaxLen: Integer;
  tmp: Integer;
  T: TdateTime;

begin
  T := Now;
  Primes := GenerateAllPrimes(1000000);

  FillChar(Divisors, SizeOf(Divisors), 255);

  Divisors[1] := 2;
  Divisors[2] := 3;

  FillChar(CycleLen, SizeOf(CycleLen), 255);
  for i := 1 to High(Divisors) do
    if CycleLen[i] = -1 then
    begin
      if i < 0 then
        tmp := 0;

      tmp := FindCycle(i);
      if MaxLen < tmp then
      begin
        WriteLn(i, ' ', tmp, ' ', MaxLen);
        MaxLen := tmp;
      end;
    end;

  WriteLn('MS = ', MilliSecondsBetween(T, Now));
end.
