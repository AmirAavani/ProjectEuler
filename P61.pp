program P61;
uses
  NumberTheoryUnit;
var
  Numbers: array[0..8] of TIntList;

function Generate(n: Integer; CurrentMask: Integer; TargetMask: Integer;
            Values: TIntList): Boolean;
var
  i, j: Integer;

begin
  if CurrentMask = TargetMask then
  begin
    if Values.Last mod 100 = Values[0] div 100 then
      Exit(True)
    else
      Exit(False);
  end;

  for i := 3 to 8 do
    if ((TargetMask and (1 shl i)) <> 0) and ((CurrentMask and (1 shl i)) = 0) then
      if Numbers[i].IndexOf(n) <> -1 then
      begin
        for j := 0 to 99 do
        begin
          Values.Add(n);
          if Generate(100 * (n mod 100) + j, CurrentMask or (1 shl i), TargetMask, Values) then
          begin
            Exit(True);
          end
          else
            Values.Delete(Values.Count - 1);
        end;
      end;
  Result := False;
end;

var
  Values: TIntList;

  i, j: Integer;
  n: Integer;
  Sum: Integer;

begin
  for i := 3 to 8 do
  begin
    Numbers[i] := TIntList.Create;
    for j := 1 to 1000 do
    begin
      n := j * ((i - 2) * j + 4 - i) div 2;
      if (1000 <= n) and (n <= 9999) then
      begin
        //WriteLn(n);
        Numbers[i].Add(n);
      end;
      if 9999 < n then
        break;
    end;
  end;

  Values := TIntList.Create;
//  Generate(8281, 0, 8 + 16 + 32, Values);

  for i := 1000 to 9999 do
  begin
    if Generate(i, 0, 8 + 16 + 32 + 64 + 128+ 256, Values) then
    begin
      Sum := 0;
      for j := 0 to Values.Count - 1 do
      begin
        Sum += Values[j];
        Write(Values[j], ' ');

      end;
      WriteLn;
      WriteLn('Sum = ', Sum);
      Values.Clear;
    end;

  end;


end.
