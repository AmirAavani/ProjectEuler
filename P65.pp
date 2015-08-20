program P65;
uses
  BigInt, FractionUnit, GenericStackUnit, WideStringUnit;

function Compute(n: Integer): TBigInt;
  function GetD(Index: Integer): Integer;
  begin
    if Index = 1 then
      Result := 2
    else if (Index - 2) mod 3 = 0 then
      Result := 1
    else if (Index - 2) mod 3 = 1 then
      Result := (Index div 3) * 2
    else
      Result := 1;
  end;

var
  i: Integer;
  d: Integer;
  tmp, di: TBigInt;
  Num, Den: TBigInt;
  NewNum, NewDen: TBigInt;
begin
 { Result := TFraction.Create(GetD(n), 1);
  for i := n - 1 downto 1 do
  begin
    tmp := TFraction.Create(GetD(i), 1);
    Result.Reverse;
    Result.Add(tmp);
    tmp.Free;
   // WriteLn(Result.ToString);
  end;
  }
  Num := BigIntFactory.GetNewMember.SetValue(GetD(n));
  Den := BigIntFactory.GetNewMember.SetValue(1);
  for i := n - 1 downto 1 do
  begin
    di := BigIntFactory.GetNewMember.SetValue(getD(i));
    tmp := Num;
    Num := Den;
    Den := tmp;

    // add Num/Den and di;
    tmp := di.Mul(Den);
    Num.Add(tmp);
    BigIntFactory.ReleaseMemeber(tmp);

  end;

  Result := Num;
end;

var
  e: TBigInt;
  i: Integer;
  Sum: Int64;
begin
  e := Compute(100);

  Sum := 0;
  for i := 1 to Length(e.ToString) do
    Sum += e.Digits[i - 1];
  WriteLn(Sum);
end.
