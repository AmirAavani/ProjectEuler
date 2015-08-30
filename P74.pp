program P74;
uses
  fgl, dateutils, sysutils;

const
  FactorL: array [0..9] of Integer =
    (1, 1, 2, 6, 24, 120, 720, 5040, 5040 * 8,
      5040 * 8 * 9);

type
  TIntIntMap = specialize TFPGMap<Integer, Integer>;

var
  map: TIntIntMap;

function ChainLen(n: Integer): Integer;
  function Compute(n: Integer): Integer;
  begin
    Result := 0;

    while n <> 0 do
    begin
      Result += FactorL[n mod 10];
      n := n div 10;
    end;

  end;

var
  i, m: Integer;
  S: Integer;

begin
  map.Clear;

  map.Add(n, 0);

  m := Compute(n);
  i := 1;

  while map.IndexOf(m) = -1 do
  begin
    map.Add(m, i);
    m := Compute(m);
    Inc(i);
  end;

  S := map.KeyData[m];
  Result := i;
end;

var
  i, j: Integer;
  k: Integer;
  n: Integer;
  T1, T2: TDateTime;

begin
  map := TIntIntMap.Create;
  //FillChar(Cycles, SizeOf(Cycles), 255);
{  WriteLn(ChainLen(1454) = 3);
  WriteLn(ChainLen(69) = 5);
  WriteLn(ChainLen(78)= 4);
  WriteLn(ChainLen(871) = 2);
  WriteLn(ChainLen(145) = 1);
  WriteLn(ChainLen(540) = 2);
  WriteLn(ChainLen(145) = 1);
  WriteLn(ChainLen(169) = 3);
  WriteLn(ChainLen(872) = 2);
}
  T1 := Now;
  n := 0;
  for i := 0 to 1000000 do
    if ChainLen(i) = 60 then
    begin
      Inc(n);
      // WriteLn(n, ' ', i);

    end;

  WriteLn(n);

  T2 := Now;

  WriteLn('MS = ', MilliSecondsBetween(T2 , T1));
  map.Free;
end.
