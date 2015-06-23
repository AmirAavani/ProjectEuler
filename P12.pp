program P12;
uses
  NumberTheoryUnit, fgl;
const
  Max = 2000000;
var
  AllPrimes : TIntList;

  i, j: Integer;
  n, Count: Int64;
  Factors: TFactorization;

begin
  AllPrimes := GenerateAllPrimes(Max);
{  for i := 0 to 1000 do
    WriteLn(AllPrimes[i]);
}
  for i := 1 to Max do
  begin
    n := i;
    n := (n * (n + 1)) div 2;

    Factors := Factorize(n);
//    Write(n, ':');
//    Factors.WriteLn;

    Count := 1;
    for j := 0 to Factors.Count - 1 do
      Count *= (Factors[j].Power + 1);
    Writeln(n, ' ', Count);
    if 500 < Count  then
      Break;


    Factors.Free;

  end;


  AllPrimes.Free;
end.
