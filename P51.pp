program P51;
uses
  NumberTheoryUnit, SysUtils, Classes;

var
  Primes: TIntList;
  InterestingPrimes: TStringList;
  pIndex: Integer;
  p: AnsiString;
  i, j, k, l, m, n, o: Integer;
  d: Integer;
  Count: Integer;
  Values: array[0..1000] of String;
  Candid: String;
  AllPrimes: array[0..999999] of Boolean;

begin
  Primes := GenerateAllPrimes(999999);//99);

  InterestingPrimes := TStringList.Create;
  for i := 0 to Primes.Count - 1 do
  begin
    InterestingPrimes.Add(IntToStr(Primes[i]));
    AllPrimes[Primes[i]] := True;
  end;
  //InterestingPrimes.Sort;

  for pIndex := 0 to InterestingPrimes.Count - 1 do
  begin
    p := InterestingPrimes[pIndex];
    Candid := p;
    for i := 1 to Length(InterestingPrimes[pIndex]) do
    begin
      p := InterestingPrimes[pIndex];
      Count := 0;
      for d := 0 to 9 do
        if (i <> 1) or (d <> 0) then
        begin
          p[i] := Chr(48 + d);

          if AllPrimes[StrToInt(p)] then
            Inc(Count);
        end;
      if (Values[Count] = '') or (StrToInt(Candid) < StrToInt(Copy(Values[Count], 1, Pos('.', Values[Count]) - 1))) then
      begin
        Values[Count] := Candid + '.' + IntToStr(i)
//        WriteLn(Candid, ' ', i, ' ', Count);
      end;

    end;

  end;

  for pIndex := 0 to InterestingPrimes.Count - 1 do
  begin
    p := InterestingPrimes[pIndex];
    Candid := p;
    for i := 1 to Length(p) do
      for j := i + 1 to Length(p)  do
      if p[i] = p[j] then
      begin
        p := InterestingPrimes[pIndex];
        Count := 0;
        for d := 0 to 9 do
          if (i <> 1) or (d <> 0) then
          begin
            p[i] := Chr(48 + d);
            p[j] := Chr(48 + d);

            if AllPrimes[StrToInt(p)] then
              Inc(Count);
          end;
        if (Values[Count] = '') or (StrToInt(Candid) <  StrToInt(Copy(Values[Count], 1, Pos('.', Values[Count]) - 1))) then
        begin
          Values[Count] := Candid + '.' + IntToStr(i) + IntToStr(j);
//          WriteLn(Candid, ' ', i, ' ', Count);
        end;
      end;

  end;
  for pIndex := 0 to InterestingPrimes.Count - 1 do
  begin
    p := InterestingPrimes[pIndex];
    Candid := p;
    for i := 1 to Length(p) do
      for j := i + 1 to Length(p)  do
        if p[i] = p[j] then
        for k := j + 1 to Length(p)  do
          if p[i] = p[k] then
        begin
          p := InterestingPrimes[pIndex];
          Count := 0;
          for d := 0 to 9 do
            if (i <> 1) or (d <> 0) then
            begin
              p[i] := Chr(48 + d);
              p[j] := Chr(48 + d);
              p[k] := Chr(48 + d);

              if AllPrimes[StrToInt(p)] then
              begin
                Inc(Count);
                if Candid = '120383' then
                  Count := (Count * 2) div 2;

              end;
            end;
          if (Values[Count] = '') or (StrToInt(Candid) <  StrToInt(Copy(Values[Count], 1, Pos('.', Values[Count]) - 1))) then
          begin
            Values[Count] := Candid + '.' + IntToStr(i) + IntToStr(j) + IntToStr(k);
  //          WriteLn(Candid, ' ', i, ' ', Count);
          end;
        end;

  end;

  for i := 0 to High(Values) do
    if Values[i] <> '' then
      WRiteLn(i, ' : ', Values[i]);



end.
