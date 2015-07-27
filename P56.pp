program P56;
uses
  BigInt;
var
  a, b, i: Integer;
  ba, result, tmp: TBigInt;
  S, Max: Integer;

begin

  for a := 1 to 99 do
  begin
    ba := BigIntFactory.GetNewMember.SetValue(a);
    result := ba.Copy;
    for b := 1 to 99 do
    begin
      S := 0;
      for i := 0 to result.Length - 1 do
        S+= result.Digits[i];
      if Max < S then
      begin
        Max := S;
        WriteLn(a, ' ', b, ' ', S);
      end;
      tmp := result.Mul(ba);
      BigIntFactory.ReleaseMember(result);
      result := tmp;
    end;
    BigIntFactory.ReleaseMember(result);
    BigIntFactory.ReleaseMember(ba);
  end;
end.
