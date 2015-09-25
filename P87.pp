program P87;
uses
  NumberTheoryUnit, dateutils, sysutils;
const
  Max = 50000000;

var
  Primes: TIntList;
  a, b, c: Integer;
  pa, pb, pc: Integer;
  pa2, pb3, pc4: Integer;
  Filled: array [0..Max] of Boolean;

  T1 : TDateTime;

begin
  T1 := Now;

  FillChar(Filled, Length(Filled) * SizeOf(Filled[0]), 0);
  Primes := GenerateAllPrimes(Trunc(Sqrt(Max)));

  for a := 0 to Primes.Count - 1 do
  begin
    pa := Primes[a];
    pa *= pa;
    if Max < pa then
      continue;

    for b := 0 to Primes.Count - 1 do
    begin
      pb := Primes[b];

      pb *= Sqr(pb);
      if Max < pa + pb then
        break;

      for c := 0 to Primes.Count - 1 do
      begin
        pc := Primes[c];

        pc := Sqr(pc) * Sqr(pc);
        if Max < pa + pb + pc then
          break;
        Filled[pa + pb + pc] := True;
      end;
    end;
  end;

  c := 0;
  for a := 1 to Max do
    if Filled[a] then
      Inc(c);

  WriteLn(c);

  Primes.Free;
  WriteLn(' MS = ', MilliSecondsBetween(T1, Now));
end.
