program P132;
{$cassertion on}

{$mode objfpc}{$H+}

uses
  NumberTheoryUnit, fgl,
  Classes;
const
  Target = 10000000000;
  PrimeCount = 40;

type
  TIntMap = specialize TFPGMap<Integer, Int64>;
var
  Map: array [0..1000000] of Integer;

function FindMod(n: Int64; m: Integer): Int64;
var
  i: Integer;
  //map: TIntMap;

  Last: Integer;
  Index, LastI: Integer;
  CycleLen: Integer;
  HasZero: Boolean;

begin
  //map := TIntMap.Create;
  FillChar(map, SizeOf(Map), 255);
  HasZero := False;

  LastI := -1;
  Last := 0;
  for i := 1 to 2 * m  do
  begin
    Last := (10 * Last + 1) mod m;
    if Last = 0 then
      HasZero := True;
    Index := map[Last];
    if Index <> -1 then
    begin
      LastI := i;
      Break;
    end;
    map[Last] := i;
  end;
  Assert(LastI <= m);
  if not HasZero then
  begin
    //Map.Free;
    Exit(1);
  end;
  if LastI = -1 then
  begin
    Result := 0;
    Exit(Last);
  end;

  CycleLen := LastI - map[Index];
  Result := Last;
//  Write(CycleLen);
  for i := 1 to (n - map[Index]) mod Cyclelen do
    Result := (10 * Result + 1) mod m;
  //Map.Free;
end;

var
  Primes: TIntList;
  i, j: Integer;
  Sum, Count: Integer;
begin
  Primes := GenerateAllPrimes(1000000);
  WriteLn(Primes.Count);

  Count := 0;
  for i := 0 to Primes.Count - 1 do
  begin
    {Count := 0;
    for j := 0 to Primes[i] do
      Inc(Count);
    }
    if i mod 1000 = 0 then
      WriteLn(i, ' ', Primes[i]);


    if FindMod(Target, Primes[i]) = 0 then
    begin
      Inc(Count);
      Sum += Primes[i];
      WriteLn(Count, ':', Primes[i], ' ', Sum);
      if Count = PrimeCount then
        break;
    end;
  end;
  WriteLn(Count, ' ', Sum);
  primes.Free;

end.

