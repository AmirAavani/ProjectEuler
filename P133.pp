program P133;
{$cassertion on}

{$mode objfpc}{$H+}

uses
  NumberTheoryUnit, fgl, SysUtils,
  Classes;
const
  Target = 100000;

var
  Map: array [0..Target] of Integer;

function HasZero(m: Integer): Boolean;
  function IsThereAnyTenToN(CycleLen, ZeroIndex: Integer): Boolean;
  {
  ZeroIndex+ K*CycleLen = 10^n
  ZeroIndex = 10^n (Mod CycleLen)
  }
  var
    i: Integer;
    TenToN: Int64;

  begin
    Result := True;

    ZeroIndex := ZeroIndex mod CycleLen;
    TenToN := 1;
    for i := 1 to 2 * CycleLen do
    begin
      if ZeroIndex = TenToN then
        Exit;
      TenToN := (TenToN * 10) mod CycleLen;
    end;
    Result := False;

  end;

var
  i: Integer;
  n: Integer;
  Last: Integer;
  Index, LastI: Integer;
  CycleLen, ZeroIndex: Integer;
  S: AnsiString;
begin
  //map := TIntMap.Create;
  FillChar(map, SizeOf(Map), 255);
  Result := False;

  LastI := -1;
  Last := 0;
  ZeroIndex := -1;
  for i := 1 to 2 * m  do
  begin
    Last := (10 * Last + 1) mod m;
    if Last = 0 then
    begin
      ZeroIndex := i;
    end;
    Index := map[Last];
    if Index <> -1 then
    begin
      LastI := i;
      Break;
    end;
    map[Last] := i;
  end;

  if ZeroIndex = -1 then
    Exit;

  CycleLen := LastI - map[Index];
  Result := IsThereAnyTenToN(CycleLen, ZeroIndex);
end;

var
  Primes: TIntList;
  i, j: Integer;
  Sum, Count: Int64;

begin
  Primes := GenerateAllPrimes(Target);
  WriteLn(Primes.Count);

  Count := 0;
  for i := 0 to Primes.Count - 1 do
  begin
    if i mod 1000 = 0 then
      WriteLn(i, ' ', Primes[i]);

    if not HasZero(Primes[i]) then
    begin
      Inc(Count);
      Sum += Primes[i];
      WriteLn(Count, ':', Primes[i], ' ', Sum);
    end;
  end;
  WriteLn(Count, ' ', Sum);
  primes.Free;

end.

