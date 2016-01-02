program P107;
uses
  SpanningTreeUnit, HeapUnit, classes, sysutils;

const
  Inf = 1e100;

var
  StrList, MatSegments: TStringList;
  S: AnsiString;
  i, j: Integer;
  Mat: TAdjMat;
  n: Integer;
  Sum: Extended;

  Tree: TTree;

begin

  StrList := TStringList.Create;
  StrList.LoadFromFile('p107_network.txt');

  SetLength(Tree, 0);
  n := StrList.Count;
  SetLength(Mat, n);
  for i := 0 to n - 1 do
  begin
    MatSegments := TStringList.Create;
    if ExtractStrings([','], [], PChar(StrList.Strings[i]), MatSegments) <> n then
      WriteLn('Error Line ', i);
    SetLength(Mat[i], n);

    for j := 0 to n - 1 do
      if MatSegments[j] = '-' then
        Mat[i, j] := Inf
      else
        Mat[i, j] := StrToFloat(MatSegments[j]);
    MatSegments.Free;
  end;
  StrList.Free;
  Sum := 0;

  for i := 0 to n - 1 do
  begin
    for j := 0 to n - 1 do
      if Mat[i, j] < Inf  then
        Sum += Mat[i, j];
  end;
  Sum /= 2;
  WriteLn(Sum:0:4);
  MinWeightSpanningTree(Mat, n, Tree);
  for j := 0 to n - 2 do
  begin
    WriteLn(j, ' ', Tree[j].Node, ' ', Tree[j].Parent, ' ', Tree[j].Weight:0:1);
    Sum -= Tree[j].Weight;
  end;

  SetLength(Tree, 0);
  WriteLn(Sum:0:4);

end.
