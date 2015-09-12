program P83;
uses
  Math, dateutils, sysutils, GPriorityQueue;
var
  Mat: array [0..81, 0..81] of Integer;
  n: Integer;

procedure ReadData;
var
  r, c: Integer;

begin
  n := 80;
  for r := 1 to n do
  begin
    for c := 1 to n do
    begin
      Read(Mat[r, c]);
    end;
    ReadLn;
  end;

end;

var
  T1: TDateTime;

type
  TNode = record
    r, c: Integer;
  end;

  { TCompare }

  TCompare = class(TObject)
  public
    class function c(a, b: TNode): Boolean;
  end;

  TMyQueue = specialize TPriorityQueue<TNode, TCompare>;
var
  Costs: array [0..80, 0..80] of Integer;
  Q: TMyQueue;

{ TCompare }

class function TCompare.c(a, b: TNode): Boolean;
begin
  Result := Costs[a.r, a.c] > Costs[b.r, b.c];
end;

const
  IncR: array [1..4] of Integer = ( 0,  0, -1, +1);
  IncC: array [1..4] of Integer = (-1, +1,  0,  0);

var
  Current, Next: TNode;
  CurCost, NextCost: Integer;
  r, c: Integer;
  i: Integer;

begin
  FillChar(Costs, SizeOf(Costs), 127);
  T1 := Now;
  ReadData;

  Q := TMyQueue.Create;

  Current.r := 1;
  Current.c := 1;
  Costs[1, 1] := Mat[1, 1];

  Q.Push(Current);

  while Q.Size <> 0 do
  begin
    Current := Q.Top;
    Q.Pop;

    r := Current.r;
    c := Current.c;
    CurCost:= Costs[r, c];
  //  WriteLn(r, ' ', c, ' ', CurCost);

    if (r = 0) or (c = 0) or (r = n + 1) or (c = n + 1) then
      continue;

    for i := 1 to 4 do
    begin
      Next := Current;
      Next.r := Next.r + IncR[i];
      Next.c := Next.c + IncC[i];
      NextCost := CurCost + Mat[Next.r, Next.c];

      if NextCost < Costs[Next.r, Next.c] then
      begin
        Costs[Next.r, Next.c] := NextCost;
        Q.Push(Next);
      end;
    end;


    if (Current.r = n) and (Current.c = n) then
      break;



  end;

  Q.Free;
  WriteLn(' Cost[80, 80] = ', Costs[80, 80]);
  WriteLn(' ms = ', MilliSecondsBetween(Now, T1));
end.
