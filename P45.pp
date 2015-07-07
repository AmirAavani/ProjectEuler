program P45;
 uses
   Math;

function Triangle(n: Int64): Int64;
begin
  Result := n * (n + 1) div 2;
end;

function Pentagonal(n: Int64): Int64;
begin
  Result := n * (3 * n - 1) div 2;
end;

function Hexagonal(n: Int64): Int64;
begin
  Result := n * (2 * n - 1);
end;

var
  t, p, h: Integer;
  i: Integer;
  m: Int64;
begin
  t := 1; p := 1; h := 1;

  for i := 1 to 3 do
  begin
    while True do
    begin
      m := Max(Triangle(t), Pentagonal(p));
      m := Max(m, Hexagonal(h));

      if (Triangle(t) = Pentagonal(p)) and (Triangle(t) = Hexagonal(h)) then
        break;

      if Triangle(t) < m then
        Inc(t);
      if Hexagonal(h) < m then
        Inc(h);
      if Pentagonal(p) < m then
        Inc(p);
    end;
    WriteLn(m);
    Inc(p);

  end;
end.
