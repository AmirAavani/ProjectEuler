{$O3}
program P110;
{
1/x + 1/y = 1/z
=>
  x=km(m+n)
  y=kn(m+n)
  z=kmn,

  where gcd(m,n) = 1.
  z= 4  = 2^2
  =>   k = 2^0 -> m = 4, n = 1
  =>   k = 2^1 -> m = 2, n = 1
  =>   k = 2^2 -> m = 1, n = 1

  num = 1 + ([Pi (2p_i + 1)] - 1) / 2


  Pi (2p_i + 1) = 2 (num - 1) + 1
  }
uses
  NumberTheoryUnit, BigInt, GenericFactoryUnit, WideStringUnit, fgl;

var
  Primes: TIntList;
const Threshold = 4000000;

function Count(Powers: TIntList): Int64;
var
  i: Integer;

begin
  Result := 1;

  for i := 0 to Powers.Count - 1 do
    Result *= (2 * Powers[i] + 1);

  Dec(Result);
  Result := Result div 2;
  Inc(Result);
end;

function Compute(Powers: TIntList; Primes: TIntList): TBigInt;
var
  i: Integer;
  pi, pi2n, tmp: TBigInt;
begin
  Result := BigIntFactory.GetNewMember.SetValue(1);

  for i := 0 to Powers.Count - 1 do
  begin
    pi := BigIntFactory.GetNewMember.SetValue(Primes.Items[i]);
    pi2n := pi.Pow(Powers[i]);
    BigIntFactory.ReleaseMember(pi);

    tmp := Result.Mul(pi2n);
    BigIntFactory.ReleaseMember(pi2n);
    BigIntFactory.ReleaseMember(Result);
    Result := tmp;
  end;

end;

type
  TIntListList = specialize TFPGList<TIntList>;

var
  Min: TBigInt;
  Possiblities: TIntListList;

function Generate(Powers, Primes: TIntList; Index: Integer = 0; LastP: Integer = 1): Boolean;
var
  i, j, k: Integer;
  tmp: TBigInt;

begin
  if Threshold < Count(Powers) then
  begin
    tmp := Compute(Powers, Primes);
    if tmp.CompareWith(Min) < 0 then
    begin
      Write('Power = ');
      for i := 0 to Powers.Count - 1 do
        Write(Powers[i], ' ');
      WriteLn;
      WriteLn('tmp = ', tmp.ToString);
      WriteLn('Count = ', Count(Powers));
      WriteLn('min = ', Min.ToString);
      BigIntFactory.ReleaseMember(Min);
      Min := tmp;
      WriteLn('New min = ', Min.ToString);
    end;
  end;

  tmp := Compute(Powers, Primes);
  if Min.CompareWith(tmp) <= 0 then
  begin
    BigIntFactory.ReleaseMember(tmp);
    Exit(False);
  end;
  BigIntFactory.ReleaseMember(tmp);

  for i := 1 to LastP do
  begin
    Powers[Index] := i;
    Generate(Powers, Primes, Index + 1, i);
    Powers[Index] := 0;
  end;

end;

var
  n : Integer;
  c: Integer;
  m: Integer;
  Factorization: TFactorization;
  i, j, k, l: Integer;
  Powers: TIntList;

begin
  Possiblities := TIntListList.Create;

  Primes := GenerateAllPrimes(1000);
  n := 2;
  m := -1;
  Powers := TIntList.Create();
  Powers.Count := 14;
  for i := 0 to Powers.Count - 1 do
    Powers[i] := 1;
  Min := Compute(Powers, Primes);
  WriteLn(Min.ToString);
  for i := 0 to Powers.Count - 1 do
    Powers[i] := 0;

  Generate(Powers, Primes, 0, 10);
  WriteLn(n);
  Primes.Free;
  BigIntFactory.ReleaseMember(Min);
end.
