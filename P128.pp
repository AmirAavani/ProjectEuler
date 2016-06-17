program P128;
uses
  fgl, NumberTheoryUnit;

const
  Max = 2000;
  Size = 100000;

var
  Primes: TIntList;

function GetStartingCell(n: Int64): Int64;
begin
  if n = 0 then
    Exit(1)
  else
    Result := 2 + 3 * n * (n - 1);
end;

{
function GetCell(n, r: Integer): Int64;
begin
  Result := 2 + 3 * n * (n - 1) + r * n;
end;
}

function GetLastCell(n: Integer): Int64;
begin
  if n = 0 then
    Exit(2)
  else
    Result := 1 + 3 * n * (n + 1);
end;

function CountAdjacents(n, r: Integer): Integer;
var
  Source: Integer;

  function PrimeDiff(v: Integer): Integer;
  begin
    //Write(v, ' ');
    if IsPrime(Abs(v - Source), Primes) then
      Result := 1
    else
      Result := 0;
  end;

begin
  if r = 1 then
  begin
    Source := GetStartingCell(n);

    Result :=
      PrimeDiff(GetStartingCell(n + 1)) +
      PrimeDiff(GetStartingCell(n + 1) + 1) +
      PrimeDiff(GetLastCell(n + 1)) +
      PrimeDiff(GetLastCell(n)) +
      PrimeDiff(GetStartingCell(n) + 1) +
      PrimeDiff(GetStartingCell(n - 1));
    end
  else
  begin
    Source := GetLastCell(n);
    if Source = 7 then
      Exit(2);

    Result :=
      PrimeDiff(GetLastCell(n + 1)) +
      PrimeDiff(GetLastCell(n + 1) - 1) +
      PrimeDiff(GetStartingCell(n)) +
      PrimeDiff(GetLastCell(n) - 1) +
      PrimeDiff(GetStartingCell(n - 1)) +
      PrimeDiff(GetLastCell(n - 1));

  end;
end;

var
  c: Integer;
  n, r: Integer;

begin
  Primes := GenerateAllPrimes(1000000);
  c := 1;

//  WriteLn(CountAdjacents(2, 0));
  for n := 1 to Size - 1 do
  begin
    for r := 1 to  2 do
    begin
      if CountAdjacents(n, r) = 3 then
      begin
        Inc(c);
      end;
      if c = Max then
      begin
        if r = 1 then
          WriteLn(GetStartingCell(n))
        else
          WriteLn(GetLastCell(n));
        Exit;
      end;
    end;
  end;

  Primes.Free;

end.
