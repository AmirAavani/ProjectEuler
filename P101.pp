program P101;
uses sysutils, MatrixUnit, MultiVariableLinearSolver, dateutils;

var
  a: TmatrixDouble;
  b: TDoubleVector;

function Evaluate(n: Integer): Double;
var
  i: Integer;
  m: Int64;

begin
//  Exit(n * n * n);
  Result := 0;

  m := 1;
  for i := 0 to 10 do
  begin
    Result += m;
    m *= -n;
  end;

end;

const
  k = 10;
var
  c: TDoubleVector;
  i, j, l: Integer;
  x: Integer;
  xi: Double;
  Error: Double;
  T1: TDateTime;

begin
  T1 := Now;

  Error := 0;
  for l := 1 to k do
  begin
    a := TmatrixDouble.Create(l, l);
    b := TDoubleVector.Create(l);

    for x := 1 to l do
    begin
      xi := 1;
      for i := 0 to l - 1 do
      begin
        //a[i]x^i+ a[i-1]x^{i-1}+...+a0=Eval(x)
        a.Cell[x - 1, i] := xi;
        xi *= x;
      end;
      b.Item[x - 1] := Evaluate(x);
    end;

    c := Solve(a, b);
    c.Print;
    xi := 1;
    for i := 1 to l do
    begin
      Error += c.Item[i - 1] * xi;
      xi *= (l + 1);
    end;

    WriteLn('error = ', Error:0:2);
    a.Free;
    b.Free;
    c.Free;
  end;

  WriteLn(dateutils.MilliSecondsBetween(T1, Now));
end.
