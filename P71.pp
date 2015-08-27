program P71;
var
  d: Integer;
  Max: Extended;
  MaxD: Integer;

begin
  MAx := -1;

  for d := 2 to 1000000 do
  begin
    if d mod 7 <> 0 then
      if Max < (Trunc((3 / 7) * d)) / d then
      begin
         Max := (Trunc((3 / 7) * d)) / d;
         MaxD := d;
         // WriteLn(d, ' ', Trunc((3 / 7) * d), ' ', Max);
      end;

    if d mod 10000 = 0 then
      WriteLn(d, ' ', Trunc((3 / 7) * d), ' ', Max);

  end;
  WriteLn(Maxd, ' ', Trunc((3 / 7) * Maxd), ' ', Max);

end.
