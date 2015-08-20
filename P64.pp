program P64;
uses
 Classes, SysUtils;
{https://en.wikipedia.org/wiki/Methods_of_computing_square_roots#Continued_fraction_expansion}

function SquareRoot(n: Integer): TStringList;
var
  i, j: Integer;
  m0, d0, a0,
  mn, dn, an, mn__1, dn__1, an__1: Integer;

begin
  Result := TStringList.Create;

  m0 := 0; d0 := 1; a0 := Trunc(Sqrt(n));

  mn := m0;
  dn := d0;
  an := a0;

  repeat
    mn__1 := dn * an - mn;
    dn__1 := (n - mn__1 * mn__1) div dn;
    an__1 := (a0 + mn__1) div dn__1;

    Result.Add(IntToStr(an));

    an := an__1;
    dn := dn__1;
    mn := mn__1;

  until an__1 = 2 * a0;
  Result.Add(IntToStr(an__1));

end;

var
  i: Integer;
  tmp: TStringList;
  Count: Integer;

begin
  Count := 0;
  for i := 1 to 10000 do
  begin
    if Sqr(Trunc(Sqrt(i))) = i then
      continue;

    tmp := SquareRoot(i);
    if tmp.Count mod 2 = 0 then
      Inc(Count);
    tmp.Free;
  end;
  WriteLn(Count);

end.
