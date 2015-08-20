program P63;
uses
  BigInt;
var
  a: Integer;
  n: Integer;
  ba, ban: TBigInt;
  Count: Integer;

begin
  Count := 0;
  for a := 1 to 10 do
    for n := 1 to 10000 do
    begin
      ba := BigIntFactory.GetNewMember.SetValue(a);
      ban := ba.Pow(n);

      if Length(ban.ToString) = n then
      begin
        Inc(Count);
        WriteLn(Count, ':', a, ' ', n, ' ', ban.ToString);
      end;
      if (n < Length(ban.ToString)) and (10 <= a) then
        break;
      if (Length(ban.ToString) < n) and (a <= 10) then
        break;

      BigIntFactory.ReleaseMemeber(ba);
      BigIntFactory.ReleaseMemeber(ban);
    end;

end.
