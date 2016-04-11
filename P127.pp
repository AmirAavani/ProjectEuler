program P127;
uses
  NumberTheoryUnit, fgl, dateutils, sysutils;

const
   MaxC = 120000 - 1;

function Rad(Factors_n: TFactorization): Integer;
var
  i: Integer;

begin
  Result := 1;
  for i := 0 to Factors_n.Count - 1 do
    Result *= Factors_n[i].Base;
end;

function AreCoPrimes(Fact_a, Fact_b: TFactorization): Boolean;
var
  i, j: Integer;

begin
  i := 0; j := 0;

  while (i < Fact_a.Count) and (j < Fact_b.Count) do
  begin
    if Fact_a[i].Base = Fact_b[j].Base then
      Exit(False)
    else if Fact_a[i].Base < Fact_b[j].Base then
      Inc(i)
    else if Fact_a[i].Base > Fact_b[j].Base then
      Inc(j);
  end;
  Result := True;
end;

var
  MS: TDateTime;

type
  TListOfFactorization = specialize TFPGList<TFactorization>;

procedure Sort(l,r: Integer; Values, Indices: TIntList);
  function Partition(l, r: Integer): Integer; 
  var
    pivot: Integer;
    i, j: Integer;

  begin
    pivot := l;
    i := l - 1; 
    j := r + 1; 

    while True do
    begin
      repeat
        Inc(i);
      until Values[Indices[i]] >= Values[Indices[pivot]];
      repeat
        Dec(j);
      until Values[Indices[j]] <= Values[Indices[pivot]];
      if i >= j then
        Exit(j);

      Indices[i] := Indices[i] xor Indices[j];
      Indices[j] := Indices[i] xor Indices[j];
      Indices[i] := Indices[i] xor Indices[j];
    end;
  end;

var
  p: Integer;
  i: Integer;
begin
  if l < r then
  begin
    p := Partition(l, r);
    Sort(l, p, Values, Indices);
    Sort(p + 1, r, Values, Indices);
  end;
end;

var
  Primes: TIntList;
  Factorizations: TListOfFactorization;
  Rads: TIntList;
  Rads_Indices: TIntList;
  a, b, c: Integer;
  ia: Integer;
  Sum, Count: UInt64;
  Rad_c: Integer;
  i, j: Integer;

begin
  MS := Now;
  Primes := GenerateAllPrimes(MaxC);
  Factorizations := TListOfFactorization.Create;
  Factorizations.Count := MaxC + 1;
  Factorizations[0] := nil;
  for a := 1 to MaxC do
    Factorizations[a] := Factorize(a, Primes);
  WriteLn(Primes.Count);

  Rads := TIntList.Create;
  Rads_Indices := TIntList.Create;
  Rads.Count := MaxC + 1;
  Rads_Indices.Count := MaxC + 1;
  Rads[0] := MaxInt;
  Rads_Indices[0] := 0;
  for c := 1 to MaxC do
  begin
    Rad_c := Rad(Factorizations[c]);
    Rads[c] := Rad_c;
    Rads_Indices[c] := c;
  end;
  Sort(0, MaxC, Rads, Rads_Indices);
  WriteLn(Rads_Indices[MaxC]);

  for ia := 0 to MaxC - 1 do
  begin
    if Rads[Rads_Indices[ia]] > Rads[Rads_Indices[ia + 1]] then
    begin

WriteLn(Rads[Rads_Indices[ia]], ':', Rads[Rads_Indices[ia + 1]] , ' ia :', ia);
Exit;
    end;
    end;
  for c := 1 to MaxC do
    for ia := 0 to MaxC - 1 do
    begin
      a := Rads_Indices[ia];
      if c <= Rads[a] * Rads[c] then
        break;
      b := c - a;
      if (a < b) and AreCoPrimes(Factorizations[a], Factorizations[c]) and 
        (Rads[a] * Rads[b] * Rads[c] < c) then
      begin
        Inc(Count);
        Sum += c;
        if Count mod 100 = 0 then
        begin
          b := c - a;
          WriteLn(Count, ' c =', c, 'a = ', a, ' b= ', b,
           ' Sum = ', Sum, ' MS = ', MilliSecondsBetween(Now, MS));
        end;
      end;

    end;

  Primes.Free;
  Rads.Free;
  Rads_Indices.Free;

  for i := 0 to Factorizations.Count - 1 do
    Factorizations[i].Free;
  Factorizations.Free;

  WriteLn(Count, ' ', Sum);
  WriteLn(' MS = ', MilliSecondsBetween(Now, MS));
end.
