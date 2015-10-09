program P94;
uses
  SysUtils, dateutils;
const
  Max = 1000000000;
{
a,a, a-1
p = (3a-1)/2
S^2= p(p-a)^2(p+1-a)
 - S is an integer => a must be an odd integer.
 - gcd(3a-1, a+1) = gcd(a+1,4)
   => either both a+1 and 3a- 1 are perfect squares or
     or each of them is two times a perfect square.

a, a, a+1
p = (3a+1)/2
S^2= p(p-a)^2(p-1-a)
 - S is an integer => a must be an odd integer.
 - gcd(3a-1, a+1) = gcd(a+1,4)
      => either both a-1 and 3a + 1 are perfect squares or
     or each of them is two times a perfect square.

   }
var
  i, j: Integer;
  ia: Integer;
  a, ia2: Int64;
  S2, P: Int64;
  Count: Integer;
  Sum: Int64;
  T: TdateTime;

begin
  T := Now;

  Sum := 0;
  Count := 0;
  for ia := 2 to round(Sqrt(Max)) do
  begin
    if not Odd(ia) then
    begin
      a := Sqr(ia) - 1;
      if Max < 3 * a - 1  then
        break;

      P := (3 * a - 1) div 2;
      S2 := P * (P - (a - 1));
      if S2 = Sqr(Trunc(Sqrt(S2))) then
      begin
        Inc(Count);
        if Count < 100 then
        begin
          WriteLn(a, ' ', a, ' ', a - 1);
          Sum += (3 * a - 1);
        end;
      end;
    end;
    a := 2 * Sqr(ia) - 1;
    if Max < 3 * a - 1  then
      break;

    P := (3 * a - 1) div 2;
    S2 := P * (P - (a - 1));
    if S2 = Sqr(Trunc(Sqrt(S2))) then
    begin
      Inc(Count);
      if Count < 100 then
      begin
        Sum += (3 * a - 1);
        WriteLn(Count, ':', a, ' ', a, ' ', a - 1, ' ', Sum);
      end;
    end;

  end;

  for ia := 1 to round(Sqrt(Max)) do
  begin
    if not Odd(ia) then
    begin
      a := Sqr(ia) + 1;
      if Max < 3 * a + 1  then
        break;

      P := (3 * a + 1) div 2;
      S2 := P * (P - (a + 1));
      if S2 = Sqr(Trunc(Sqrt(S2))) then
      begin
        Inc(Count);
        if Count < 100 then
        begin
          Sum += (3 * a + 1);
          WriteLn(Count, ':', a, ' ', a, ' ', a + 1, ' ', Sum);
        end;
      end;
    end;

      a := 2 * Sqr(ia) + 1;
      if Max < 3 * a + 1  then
        break;

      P := (3 * a + 1) div 2;
      S2 := P * (P - (a + 1));
      if S2 = Sqr(Trunc(Sqrt(S2))) then
      begin
        Inc(Count);
        if Count < 100 then
        begin
          Sum += (3 * a + 1);
          WriteLn(Count, ':', a, ' ', a, ' ', a + 1, ' ', Sum);
        end;
      end;

    end;

  WriteLn('MS = ', MilliSecondsBetween(Now, T));
end.
