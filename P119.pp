program P119;
uses
  SysUtils, dateutils, fgl;

type
  TIntList = specialize TFPGList<Int64>;

const
  Num =30;

function ThereAre30(n: UInt64): TIntList;
  function SumDigits(n: UInt64): Integer;
  begin
    Result := 0;

    while n <> 0 do
    begin
      Result += n mod 10;
      n := n div 10;
    end;

  end;

var
  Sum, p: Integer;
  Sump: UInt64;
  Counter: Integer;

begin
{  WriteLn;
  WriteLn(n);
  WriteLn;
}
//  WriteLn(n);
  Result := TIntList.Create;

  Sump := 1;
  Counter:= 0;
  for Sum := 2 to Round(Sqrt(n)) do
  begin
    SumP := Sum ;
    p := 1;
    while SumP <= n do
    begin
      if (SumDigits(Sump) = Sum) and (10 <= SumP) then
      begin
        Inc(Counter);
        Result.Add(SumP);
        if Num <= Counter then
          WriteLn(n, ' ', Counter);
      end;
      if (n + Sum - 1) div Sum <= SumP then
        Break;
      Sump *= Sum;
      if SumP = 0 then
        break;
    end;
  end;

end;

function IntCompare(const a, b: Int64): Integer;
begin
  if a < b then
    Result:= -1
  else if b < a then
    Result := 1
  else
    Result := 0;
end;

var
  i, j: Integer;
  Bot, Top, Mid: UInt64;
  Last: UInt64;
  MS: TDateTime;
  Values: TIntList;

begin
  Ms := Now;

  Top := 1;
  Values := TIntList.Create;
  Values := ThereAre30(Top);
  while Values.Count < Num do
  begin
    Values.Free;
    Values := ThereAre30(Top);
    Top *= 16;
  end;
  Values.Sort(@IntCompare);
  WriteLn(Values[Num - 1]);

{  Bot := Top div 2;
  Last := Top;
  while Bot <= Top do
  begin
    Mid := (Bot + Top) div 2;
    if ThereAre30(Mid) then
    begin
      Last := Mid;
      Top := Mid - 1;
    end
    else
      Bot := Mid + 1;
  end;
  WriteLn(Last);
  }
  WriteLn('MS = ', MilliSecondsBetween(Now, Ms));
end.
