program P29;
uses
  NumberTheoryUnit, fgl;

const
   N = 100;
type
  TFactorizationList = specialize TFPGList<TFactorization>;

function GenerateAllNumbers: TFactorizationList;
var
  Tmp, Factorization: TFactorization;
  a, b: Integer;
  i: Integer;

begin
  Result := TFactorizationList.Create;

  for a := 2 to N do
  begin
    Factorization := Factorize(a);

    for b := 2 to N do
    begin
      Tmp := TFactorization.Create;
      for i := 0 to Factorization.Count - 1 do
      begin
        Tmp.Add(TFactorizationPair.Create(Factorization[i].Base,
                           Factorization[i].Power * b));
      end;
      Result.Add(Tmp);
    end;
  end;

end;

function IsLessThan(Fact1, Fact2: TFactorization): Boolean;
var
  i: Integer;

begin
  if Fact1.Count < Fact2.Count then
    Exit(True)
  else if Fact2.Count< Fact1.Count then
    Exit(False);

  for i := 0 to Fact1.Count - 1 do
  begin
    if Fact1[i].Base < Fact2[i].Base then
      Exit(True)
    else if Fact2[i].Base < Fact1[i].Base then
      Exit(False);

    if Fact1[i].Power < Fact2[i].Power then
      Exit(True)
    else if Fact2[i].Power < Fact1[i].Power then
      Exit(False);
  end;
  Exit(False);
end;

procedure Sort(Factorizations: TFactorizationList);

var
  i, j, k: Integer;
  Fact1, Fact2: TFactorization;

begin
  for i := 0 to Factorizations.Count - 1 do
  begin
    Fact1 := Factorizations[i];

    for j := i + 1 to Factorizations.Count - 1 do
    begin
      Fact2 := Factorizations[j];

      if IsLessThan(Fact2, Fact1) then
      begin
        Factorizations[i] := Factorizations[j];
        Factorizations[j] := Fact1;
        Fact1 := Factorizations[i];
      end;
    end;
  end;

end;

function IsEqual(Fact1, Fact2: TFactorization): Boolean;
begin
  Result := (not IsLessThan(Fact1, Fact2)) and (not IsLessThan(Fact2, Fact1));
end;

var
  FactList: TFactorizationList;
  i: Integer;
  Result: Integer;

begin

  FactList := GenerateAllNumbers;
  Sort(FactList);
{  WriteLn('Sorted');
  for i := 0 to FactList.Count - 1 do
    FactList[i].WriteLn;
}

  Result := 1;
  FactList[0].WriteLn;
  for i := 1 to FactList.Count - 1 do
  begin
    if not IsEqual(FactList[i - 1], FactList[i]) then
    begin
      FactList[i].WriteLn;
      Inc(Result);
    end;
  end;



  WriteLn(Result);
end.
