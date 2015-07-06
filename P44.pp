program P44;
var
  i, j, k: Integer;
  ni, nj, nk: Int64;

function Pantagonal(n: Integer): Int64;
begin
  Result := (n * (3 * n - 1)) div 2;
end;

function IsPantagonal(x: Double): Int64;
var
  v: Double;

begin
  Result := -1;
  v := (Sqrt(1 + 24.0 * x) + 1.0) / 6.0;;
  if Abs(v - Round(v)) < 1e-6 then
      Result := Round(v);
end;

const N = 100000;
 {
 D = pi
 pk = pi + pj
 \exists l: pl = pk + pj
 }
begin
  IsPantagonal(5482660);
  for i := 1912 to N do
  begin
    ni := Pantagonal(i);
    j := 1020;
    //for j := i to 20 * N do
    while True do
    begin
      nj := Pantagonal(j);

      if (0 < IsPantagonal(ni + nj)) and (0 < IsPantagonal(ni + 2 * nj)) then
      begin
        WriteLn(i, ' ', j, ' ni = ', ni, ' nj = ', nj, ' index =', IsPantagonal(ni + nj), ' ni + nj = ', ni + nj);
        Exit;
      end;
      if ni < Pantagonal(j + 1) - Pantagonal(j)  then
        break;
      Inc(j);
    end;
  end;

end.
