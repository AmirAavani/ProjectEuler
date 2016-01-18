program P112;

var
  IncMem, DecMem: array [0..10, 0..10] of Integer;

function IsBouncy(n: Integer): Boolean;
  function IsInc(n: Integer; Dir: Integer): Boolean;
  var
    d: Integer;

  begin
    d := n mod 10;
    n := n div 10;
    Result := True;

    while 10 <= n do
    begin
      if not (((n mod 10 <= d) and (0 < Dir)) or
         ((d <= n mod 10) and (Dir < 0)))  then
         Exit(False);

      d := n mod 10;
      n := n div 10;
    end;
    Result := (((n mod 10 <= d) and (0 < Dir)) or
         ((d <= n mod 10) and (Dir < 0)));
  end;

begin
  Result := (not IsInc(n, 1)) and (not IsInc(n, -1)) ;
end;

var
  i: Integer;
  Count: Integer;

begin
   FillChar(IncMem, SizeOf(IncMem), 0);
  FillChar(DecMem, SizeOf(DecMem), 0);

  for i := 1 to 10000000 do
  begin
    if IsBouncy(i) then
    begin
      Inc(Count);

      //WriteLn(i);
    end;
    if 100 * Count = 99 * i then
    begin
      WriteLn(i, ' ', Count);
      break;
    end;

  end;


end.
