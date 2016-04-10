program P124;
uses
 NumberTheoryUnit, HeapUnit;
const
  Max    = 100000;
  Target = 10000;

type
  TPair = class
    a, b: Integer;
  end;
  TPairHeap = specialize THeap<TPair>;
var
  Primes: TIntList;

function ComputeE(n: Integer): Integer;
var
  Fact: TFactorization;
  i: Integer;

begin
  Fact := Factorize(n, Primes);

  Result := 1;

  for i := 0 to Fact.Count - 1 do
    Result *= Fact[i].Base;

  Fact.Free;
end;

function Compare(const P1: TPair; const P2: TPair): Boolean;
begin
  if P1.b < P2.b then
    Exit(False);
  if P1.b > P2.b then
    Exit(True);
  Result := P1.a > P2.a;
end;

var
  i: Integer;
  E: TPairHeap;
  p: TPair;

begin
  Primes := GenerateAllPrimes(Max);
  E := TPairHeap.Create(@Compare, 0);

  for i := 1 to Max do
  begin
    p := TPair.Create;
    p.a := i;
    p.b := ComputeE(i);
    E.Insert(p);
  end;

  p := nil;
  for i := 1 to Target do
  begin
    p.Free;
    p := E.Min;
    E.DeleteMin;
  end;
  WriteLn(p.a, ' ', p.b);
  E.Free;
  Primes.Free;

end.
