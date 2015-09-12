program P80;
uses
  BigInt, GenericFactoryUnit, WideStringUnit, dateutils, sysutils;
var
  i, j: Integer;
  n, t10To200, tmp: TBigInt;
  S: Integer;

  Str: AnsiString;

  T1: TDateTime;

begin
  T1 := Now;
  tmp := BigIntFactory.GetNewMember.SetValue(10);
  t10To200 := tmp.Pow(200);
  BigIntFactory.ReleaseMember(tmp);

  S := 0;
  for i := 2 to 99 do
  begin
    if Sqr(Trunc(Sqrt(i))) = i then
      Continue;

    tmp := BigIntFactory.GetNewMember.SetValue(i);
    n := tmp.NewMul(t10To200);
    BigIntFactory.ReleaseMember(tmp);

    tmp := n.SQRT();
    WriteLn(tmp.ToString);
    BigIntFactory.ReleaseMember(n);

    Str := tmp.ToString;
    for j := 1 to 100 do
      S += Ord(Str[j]) - 48;
    WriteLn(i, ' ', S);
  end;

  WriteLn('MS = ', MilliSecondsBetween(Now, T1));
end.
