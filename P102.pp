program P102;
{$assertion on}
uses
  classes, SysUtils, strings, GeomertyUnit;



var
  Str : TStringList;
  i: Integer;
  Count: Integer;
  Polygon: TPolygon;
  Center: TPoint;

begin
  Str := TStringList.Create;
  Str.LoadFromFile('p102_triangles.txt');

  Count := 0;

  Center := TPoint.Create(0, 0);

  for i := 0 to Str.Count - 1 do
  begin
    Polygon := TPolygon.Create(Str[i]);
    if 0 < Polygon.IsInside(Center) then
      Inc(Count);
   Polygon.Free;
  end;
  WriteLn(Count);
  Center.Free;

  Str.Free;
end.
