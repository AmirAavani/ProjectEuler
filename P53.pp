program P53;
uses
  NumberTheoryUnit;

var
  i, j: Integer;
  Count: Integer;

begin
  Count := 0;

  for i := 1 to 100 do
    for j := 0 to i do
    begin
      if 1000000 < CNR(i, j) then
        Inc(Count);

      WriteLn(Count, ':', i, ' ', j,  ' ', CNR(i, j));

    end;


end.
