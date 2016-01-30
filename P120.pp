{
S=(a-1)^n + (a+1)^n mod a^2
}
program P120;
uses
  fgl, dateutils, sysutils;
type
  TIntList = specialize TFPGList<Int64>;

function ComputeMax(a: Integer): Integer;
var
  n, an: Integer;
  S1, S2: TIntList;
  Modulo: Integer;
  i, j: Integer;

begin
  S1 := TIntList.Create;

  Modulo := a * a;
  n := 0;
  an := 1;
  while S1.IndexOf(an) < 0 do
  begin
    S1.Add(an);
    an *= (a - 1);
    an := an mod Modulo;
  end;

  n := 0;
  an := 1;
  S2 := TIntList.Create;
  while S2.IndexOf(an) < 0 do
  begin
    S2.Add(an);
    an *= (a + 1);
    an := an mod Modulo;
  end;

  i := 0;
  j := 0;
  Result := S1[i] + S2[j];
  i := (i + 1) mod S1.Count;
  j := (j + 1) mod S2.Count;

  while (i <> 0) or (j <> 0) do
  begin
    if Result < (S1[i] + S2[j]) mod Modulo then
      Result := (S1[i] + S2[j]) mod Modulo;

    i := (i + 1) mod S1.Count;
    j := (j + 1) mod S2.Count;
  end;


  // WriteLn('S1.Count = ', S1.Count, ' S2.Count = ', S2.Count);
  S1.Free;
  S2.Free;

end;

var
  Sum: Integer;
  a: Integer;
  T1: TDateTime;

begin
  T1 := Now;
  Sum := 0;
  WriteLn(ComputeMax(7));

  for a := 3 to 1000 do
  begin
 //   WriteLn(ComputeMax(a));
    Sum += ComputeMax(a);
  end;
  WriteLn(Sum);
  WriteLn('MS = ', MilliSecondsBetween(Now, T1));
end.
