program P91;
uses
  GeometryUnit, dateutils, sysutils;
const
  Max = 50;

function RightTriangle(x1, y1, x2, y2: Integer): Boolean;
var
  dx1, dy1, dx2, dy2: Integer;

begin
  if (x1 = x2) and (y1 = y2) then
    Exit(False);
  if (x1 = 0) and (y1 = 0) then
    Exit(False);
  if (x2 = 0) and (y2 = 0) then
    Exit(False);

  dx1 := x1; dy1 := y1;
  dx2 := x2 - x1; dy2 := y2 - y1;

  if dx1 * dx2 + dy1 * dy2 = 0 then
    Exit(True);

  dx1 := x2; dy1 := y2;
  dx2 := x1 - x2; dy2 := y1 - y2;

  if dx1 * dx2 + dy1 * dy2 = 0 then
    Exit(True);


  if x1 * x2 + y1 * y2 = 0 then
    Exit(True);

  Result := False;
end;

function IsOnRightSide(x2, y2, x3, y3: Integer): Boolean;
var
  Line: TLine;
  P1, P2, P3: TPoint;

begin
  P1 := CreatePoint(0, 0);
  P2 := CreatePoint(x2, y2);
  P3 := CreatePoint(x3, y3);

  Line := CreateLine(P1, P2);
  Result := PointIsOnRightSide(P3, Line);
end;

var
  x1, y1, x2, y2: Integer;
  Count: Integer;
  T1: TDateTime;

begin
  T1 := Now;
  Count := 0;
  WriteLn(RightTriangle(0, 1, 1, 0), ' ', IsOnRightSide(0, 1, 1, 0));
  WriteLn(RightTriangle(1, 0, 0, 1), ' ', IsOnRightSide(1, 0, 0, 1));

  for x1 := 0 to Max do
    for y1 := 0 to Max do
      for x2 := 0 to Max do
        for y2 := 0 to Max do
          if RightTriangle(x1, y1, x2, y2) then
          begin
            if IsOnRightSide(x1, y1, x2, y2) then
            begin
              // WriteLn(x1, ' ', y1, ' ', x2, ' ', y2);
              Inc(Count);
            end;

          end;

  WriteLn(Count);


  WriteLn('MS = ', MilliSecondsBetween(T1, Now));

end.
