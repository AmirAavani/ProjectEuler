program P126;
const
  Target: Integer = 1000;
  Max: Integer = 50000;

  function C(x,y,z,n: uInt64): uInt64;
  begin
    Result := 2 * (x*y + y*z +  x*z) + 4* (x + y + z + n - 2 ) * (n - 1);
  end;

var
  Cn: array[0..100000] of Integer;
  na, nb, nc, n: Integer;
  Count: UInt64;
  Min: Integer;
  i: Integer;

begin
  FillChar(Cn, SizeOf(Cn), 0);
  Min := MaxInt;
  for na := 1 to Max do
    for nb := na to Max do
      for nc := nb to Max do
      begin
        for n := 1 to Max do
        begin
          Count := C(na, nb, nc, n);
          if High(Cn) < Count then
            break;

          Inc(Cn[Count]);

          if Cn[Count] = Target then
          begin
            if Count < Min then
            begin
              WriteLn(Min, ' ', Count, ' ', Cn[Count]);
              Min := Count;
            end;

          end;
        end;
        if High(Cn) < C(na, nb, nb, 1) then
          break;
      end;

  for i := 0 to High(Cn) do
    if Cn[i] = Target then
      WriteLn(i);

              {
  WriteLn(22, ' ', Cn[22]);
  WriteLn(46, ' ', Cn[46]);
  WriteLn(78, ' ', Cn[78]);
  }
end.
