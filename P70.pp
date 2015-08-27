program P70;
uses
  NumberTheoryUnit, SysUtils;


function Match(n, m: Integer): Boolean;
var
  Sn, Sm: AnsiString;
  i: Integer;

begin
  Sn := IntToStr(n);
  Sm := IntToStr(m);

  if Length(Sn) <> Length(Sm) then
    Exit(False);

  for i := 1 to Length(Sn) do
    if Pos(Sn[i], Sm) <> 0 then
      Sm[Pos(Sn[i], Sm)] := '*'
    else
      Exit(False);

  Result := True;
end;

var
  Primes: TIntList;
  n: Integer;
  Factors: TFactorization;
  m: Integer;
  Min: Extended;

begin
  Primes := GenerateAllPrimes(10000000);

  Min := 1000000;
  for n := 2 to 1000000 do
  begin
    Factors := Factorize(n, Primes);
    m := ComputePhi(n, Factors);

    if Match(n, m) then
    begin
      if n / m < Min then
      begin
        Min := n / m;
        WriteLn('n = ', n, ' m = ', m,
        ' ', Min:0:3, ' Fcount = ', Factors.Count);
      end;

    end;

    Factors.Free;
  end;
  WriteLn('Min ', Min);
end.
