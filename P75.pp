program P75;
uses
  fgl, dateutils, sysutils;
const
  Max = 1500000;
  //Max = 18078;

function gcd(a, b: Integer): Integer;
begin
  if a < b then
    Exit(gcd(b, a));

  while a mod b <> 0 do
  begin
    Result := a mod b;
    a := b;
    b := Result;

  end;
  Result := b;

end;
var
  Counts: array [0..Max] of Integer;

procedure Approach1;
var
  m, n: Int64;
  a, b, c : Int64;
  i: Integer;
  l: Int64;
  Ans: Integer;
  T1, T2: TDateTime;

begin
  T1 := Now;
  FillChar(Counts, SizeOf(Counts), 0);

  for m := 1 to Trunc(Sqrt(Max)) do
  begin
    for n := 1 to m - 1 do
      if (gcd(n, m) = 1) and Odd(m - n) then
      begin
{        a := m * m - n * n;
        b := 2 * m * n;
        c := m * m+ n * n;

        l := a + b + c;
 }
        l := 2;
        l *= m * (m + n);
        if Max < l then
          break;

        for i := 1 to (Max div l) do
        begin
          Inc(Counts[i * l]);
          //WriteLN(i * a, ' ', i * b, ' ', i * c, ' ', i * l);

        end;
      end;

  end;

  Ans := 0;
  for i := 1 to Max do
    if Counts[i] = 1 then
      Inc(Ans);
  WriteLn(Ans);
  T2 := Now;
  WriteLn('MS = ', MilliSecondsBetween(T2, T1));
end;

begin
  Approach1;
end.
{
12221
MS = 476289
}
