program P66;
uses
  NumberTheoryUnit, fgl, BigInt, GenericFactoryUnit, WideStringUnit;
(*
procedure FirstAttemp;
var
  Ds: array [0..1000] of Integer;
  NotVisitedCount: Integer;
  Primes: TIntList;

procedure Compute(x: Integer);
var
  x2: Int64;
  Factors: TFactorization;

  procedure Generate(Index: Integer; CurrentValue: Integer);
  var
    i: Integer;
    tmp: Integer;

  begin
    if High(Ds) < CurrentValue then
      Exit;

    if Index = -1 then
    begin
      if CurrentValue < 0 then
        Exit;

      if CurrentValue <= High(Ds) then
        if Ds[CurrentValue] = -1 then
        begin
          Dec(NotVisitedCount);
          Ds[CurrentValue] := x;
          WriteLn(NotVisitedCount, ' ', 'x = ', x, ' d = ', CurrentValue);
          if NotVisitedCount = 429 then
            Exit;

        end;

      Exit;
    end;

    if Odd(Factors[Index].Power) then
    begin
      CurrentValue *= Factors[Index].Base;
      Generate(Index - 1, CurrentValue);
      for i := 1 to (Factors[Index].Power div 2) do
      begin
        if High(Ds) < Sqr(Factors[Index].Base) then
          break;
        if High(Ds) < CurrentValue then
          break;

        CurrentValue *= Sqr(Factors[Index].Base);
        Generate(Index - 1, CurrentValue);
      end;
    end
    else
    begin
      Generate(Index - 1, CurrentValue);
      for i := 1 to (Factors[Index].Power div 2) do
      begin
        if High(Ds) < Sqr(Factors[Index].Base) then
          break;
        if High(Ds) < CurrentValue then
          break;
        CurrentValue *= Sqr(Factors[Index].Base);
        Generate(Index - 1, CurrentValue);
      end;
    end;
  end;

var
  i, j: Integer;
  F1, F2: TFactorization;
  a, b: Integer;

begin
  x2 := (x - 1);
  x2 *= (x + 1);
  if x2 < 0 then
    Exit;

  F1 := Factorize(x - 1, Primes);
  F2 := Factorize(x + 1, Primes);
//  Factors := F1;
  if F2[0].Base = 2 then
  begin
    F1[0].Power := F1[0].Power + F2[0].Power;
    F2[0].Power := 0;
  end;

  Factors := TFactorization.Create;
  for i := 0 to F1.Count - 1 do
    Factors.Add(TFactorizationPair.Create(F1[i].Base, F1[i].Power));
  for i := 0 to F2.Count - 1 do
    if F2[i].Base <> 2 then
      Factors.Add(TFactorizationPair.Create(F2[i].Base, F2[i].Power));
  for i := 0 to Factors.Count - 1 do
    for j := i + 1 to Factors.Count - 1 do
      if Factors[j].Base < Factors[i].Base then
      begin
        a := Factors[i].Base;
        b := Factors[i].Power;

        Factors[i].Base := Factors[j].Base;
        Factors[i].Power := Factors[j].Power;

        Factors[j].Base := a;
        Factors[j].Power := b;

      end;

{  F1.WriteLn;
  F2.WriteLn;
  Factors.WriteLn;
}
  F1.Free;
  F2.Free;

  a := 1;
  for i := 0 to Factors.Count - 1 do
    if Odd(Factors[i].Power) then
    begin
      a *= Factors[i].Base;
      if High(Ds) < a then
      begin
        Factors.Free;
        Exit;
      end;
    end;

  Generate(Factors.Count - 1, 1);
  Factors.Free;

end;

var
  x: Integer;
  MaxIndex: Integer;
  i: Integer;

begin
  FillChar(Ds, SizeOf(Ds), 255);
  NotVisitedCount := High(Ds);

  Primes := GenerateAllPrimes(100000000);
  for x := 1 to Trunc(Sqrt(High(Ds))) do
  begin
    Ds[x * x] := 0;
    Dec(NotVisitedCount);
  end;
  x := 2;

  while NotVisitedCount <> 0  do
  begin
    if x <> Sqr(Trunc(Sqrt(x))) then
      Compute(x);

{    if x mod 100000 = 0 then
      WriteLn(x, ' ', NotVisitedCount);
}
    Inc(x);

  end;
  //290

  for i := 1 to High(Ds) do
    if Ds[MaxIndex] < Ds[i] then
      MaxIndex := i;
  WriteLn(MaxIndex);

end;

*)

type
  TNumber = record
    x, y: Integer;// x + ySqrt(d)
  end;

  TFraction = class(TObject)
  public
    numerator, Denominator: TNumber;
  end;

  { TFractionValue }

  TFractionValue = class(TObject)
    Fraction : TFraction;
    Value: Integer;

    constructor Create(f: TFraction; v: Integer);
  end;

  TFractList = specialize TFPGList<TFractionValue>;

function Compute(d: Integer): Integer;
begin

end;

var
  Ds: array [0..1000] of Integer;
  MaxIndex: Integer;
  i, x: Integer;

{ TFractionValue }

constructor TFractionValue.Create(f: TFraction; v: Integer);
begin
  inherited Create;

  Fraction := f;
  Value := v;
end;

begin
  FillChar(Ds, SizeOf(Ds), 255);

  for x := 1 to Trunc(Sqrt(High(Ds))) do
    Ds[x * x] := 0;

  for i := 1 to High(Ds) do
    if Ds[i] = -1 then
      Ds[i] := Compute(i);

  MaxIndex := 2;
  for i := 1 to High(Ds) do
    if Ds[MaxIndex] < Ds[i] then
      MaxIndex := i;
  WriteLn(MaxIndex);


end.
