program P93;
uses
  Classes, dateutils, sysutils;

type
  TBoolArray = array[-10000..10000] of Boolean;
var
  Perms: array[0..24, 1..4] of Integer;

procedure GeneratePerm(var PermIndex: Integer; Index: Integer; Current: AnsiString);
var
  i: Integer;
begin
  if Index = 5 then
  begin
    Perms[PermIndex, 1] := Ord(Current[1]) - 48;
    Perms[PermIndex, 2] := Ord(Current[2]) - 48;
    Perms[PermIndex, 3] := Ord(Current[3]) - 48;
    Perms[PermIndex, 4] := Ord(Current[4]) - 48;
    Inc(PermIndex);
    Exit;
  end;

  for i := 1 to 4 do
    if Pos(Chr(i + 48), Copy(Current, 1, Index - 1)) = 0 then
    begin
      Current[Index] := Chr(i + 48);
      GeneratePerm(PermIndex, Index + 1, Current);
    end;
end;

procedure Appraoch1;
// Not Working
//Does not consider 4 * (3 + 1 / 2)
var
  Perms: array [0..23,1..4] of Integer;


function FindLength(a, b, c, d: Integer): Integer;
var
  Nums, Ns: array [1..4] of Integer;

  function Generate(Index, Len: Integer): TBoolArray;
  var
    i, j: Integer;
    a, b: Integer;
    Right, Left: TBoolArray;

  begin
    FillChar(Result, SizeOf(Result), False);
    if Len = 0 then
      Result[0] := True
    else if Len = 1 then
      Result[Ns[Index]] := True
    else if Len = 2 then
    begin
      a := Ns[Index];
      b := Ns[Index + 1];
      Result[a + b] := True;
      Result[a - b] := True;
      Result[a * b] := True;
      if (b <> 0) and (a mod b = 0) then
        Result[a div b] := True;
    end
    else if Len = 3 then
    begin
      Left := Generate(Index, 2);
      Right := Generate(Index + 2 , 1);

      for a := Low(Left) to High(Left) do
        if Left[a] then
          for b := Low(Right) to High(Right) do
            if Right[b] then
            begin
              Result[a + b] := True;
              Result[a - b] := True;
              Result[a * b] := True;
              if (b <> 0) and (a mod b = 0) then
                Result[a div b] := True;
            end;

      Left := Generate(Index, 1);
      Right := Generate(Index + 1 , 2);

      for a := Low(Left) to High(Left) do
        if Left[a] then
          for b := Low(Right) to High(Right) do
            if Right[b] then
            begin
              Result[a + b] := True;
              Result[a - b] := True;
              Result[a * b] := True;
              if (b <> 0) and (a mod b = 0) then
                Result[a div b] := True;
            end;
    end
    else if Len = 4 then
    begin
      for i := 1 to Len - 1 do
      begin
        Left := Generate(Index, i);
        Right := Generate(Index + i, Len - i);

        for a := Low(Left) to High(Left) do
          if Left[a] then
            for b := Low(Right) to High(Right) do
              if Right[b] then
              begin
                Result[a + b] := True;
                Result[a - b] := True;
                Result[a * b] := True;
                if (b <> 0) and (a mod b = 0) then
                  Result[a div b] := True;
              end;
      end;
    end;

  end;

var
  i, j, k: Integer;
  Values: array [-100000..100000] of Boolean;
  tmp: TBoolArray;

begin
  FillChar(Values, SizeOf(Values), False);

  for i := 0 to 23 do
  begin
    Nums[1] := a; Nums[2] := b; Nums[3] := c; Nums[4]:= d;
    for j := 1 to 4 do
      Ns[j] := Nums[Perms[i, j]];
    tmp := Generate(1, 4);
    for k := Low(tmp) to High(tmp) do
      if tmp[k] then
        Values[k] := True;
  end;

  for i := 1 to High(Values) do
    if not Values[i] then
      Exit(i - 1);
end;

var
  a, b, c, d: Integer;
  Max: Integer;
  tmp: Integer;
  ma, mb, mc, md: Integer;

begin
  GeneratePerm(a, 1, '    ');
  Max := -1;
  for a := 1 to 4 do
    for b := a + 1 to 4 do
      for c := b + 1 to 4 do
        for d := c + 1 to 4 do
        begin
          tmp := FindLength(a, b, c, d);
          if Max < tmp then
          begin
            Max := tmp;
            ma := a;
            mb := b;
            mc := c;
            md := d;
            WriteLn('Max = ', Max, ' abcd = ', ma, mb, mc, md);
          end;

        end;

end;


function GenerateAllCombinations: TStringList;
const
  Vars: String = 'abcd';

  procedure Generate(nIndex, sIndex: Integer; S: AnsiString);
  begin
    if (nIndex = 4) and (sIndex = 3) then
    begin
      Result.Add(S);
      Exit;
    end;

    if 2 <= nIndex - sIndex then
    begin
      Generate(nIndex, sIndex + 1, S + '+');
      Generate(nIndex, sIndex + 1, S + '-');
      Generate(nIndex, sIndex + 1, S + '*');
      Generate(nIndex, sIndex + 1, S + '/');
    end;

    if nIndex <= 4 then
      Generate(nIndex + 1, sIndex, S + Vars[nIndex + 1]);

  end;

begin
  Result := TStringList.Create;

  Generate(0, 0, '');

end;

function FindLength(a, b, c, d: Integer; Codes: TStringList): Integer;
var
  Ns: array [0..4] of Integer;

  function Compute(const S: AnsiString): Integer;
  var
    Stack: array [0..10] of Extended;
    ToS: Integer;
    i: Integer;
  begin
    ToS := 0;
    for i := 1 to Length(S) do
    begin
      if S[i] in ['a', 'b', 'c', 'd'] then
      begin
        Stack[Tos] := Ns[Ord(S[i]) + 1 - Ord('a')];
        Inc(Tos);
      end
      else if S[i] = '+' then
      begin
        Stack[ToS - 2] := Stack[Tos - 2] + Stack[Tos - 1];
        Dec(Tos);
      end
      else if S[i] = '-' then
      begin
        Stack[ToS - 2] := Stack[Tos - 2] - Stack[Tos - 1];
        Dec(Tos);
      end
      else if S[i] = '*' then
      begin
        Stack[ToS - 2] := Stack[Tos - 2] * Stack[Tos - 1];
        Dec(Tos);
      end
      else if S[i] = '/' then
      begin
        if Stack[Tos - 1] = 0 then
          Exit(0);

        Stack[ToS - 2] := Stack[Tos - 2] / Stack[Tos - 1];
        Dec(Tos);
      end
    end;

    Assert(Tos = 1);
    if 0.1 < Abs(Round(Stack[0]) - Stack[0]) then
      Result := 0
    else
      Result := Round(Stack[0]);
  end;

var
  Values: array [-100000..100000] of Boolean;
  tmp: TBoolArray;
  i, j, k: Integer;
  Nums: array [0..4] of Integer;

begin
  FillChar(Values, SizeOf(Values), False);

  for i := 0 to 23 do
  begin
    Nums[1] := a; Nums[2] := b; Nums[3] := c; Nums[4]:= d;
    for j := 1 to 4 do
      Ns[j] := Nums[Perms[i, j]];
    for j := 0 to Codes.Count - 1 do
      Values[Compute(Codes[j])] := True;
  end;

  for i := 1 to High(Values) do
    if not Values[i] then
      Exit(i - 1);
end;

var
  a, b, c, d, i: Integer;
  Max: Integer;
  tmp: Integer;
  ma, mb, mc, md: Integer;
  Codes: TStringList;
  T1: TDateTime;

begin
  T1 := Now;

  Codes := GenerateAllCombinations;
  GeneratePerm(a, 1, '    ');
  Max := -1;
    for a := 0 to 9 do
      for b := a + 1 to 9 do
        for c := b + 1 to 9 do
          for d := c + 1 to 9 do
          begin
            tmp := FindLength(a, b, c, d, Codes);
            if Max < tmp then
            begin
              Max := tmp;
              ma := a;
              mb := b;
              mc := c;
              md := d;
              WriteLn('Max = ', Max, ' abcd = ', ma, mb, mc, md);
            end;

          end;

  Codes.Free;
  WriteLn('MS = ', MilliSecondsBetween(Now, T1));
end.
