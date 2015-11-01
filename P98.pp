program P98;
uses
  classes, sysutils, dateutils, strings, Math;

function ReadData: TStringList;
  function Sort(const s: AnsiString): AnsiString;
  var
    i, j: Integer;
    tmp: char;
  begin
    Result := S;

    for i := 1 to Length(S) do
      for j := i + 1 to Length(S) do
        if Result[j] < Result[i] then
        begin
          tmp := Result[i];
          Result[i] := Result[j];
          Result[j] := tmp;
        end;
  end;

var
  tmp: TStringList;
  S: AnsiString;
  i: Integer;
  PStr: PString;
begin

  tmp := TStringList.Create;

  tmp.LoadFromFile('p098_words.txt');
  S := tmp[0];
  tmp.Free;

  tmp := TStringList.Create;
  ExtractStrings([','], [], @S[1], tmp);

  for i := 0 to tmp.Count - 1 do
    tmp[i] := Copy(tmp[i], 2, Length(tmp[i]) - 2);

  Result := TStringList.Create;
  for i := 0 to tmp.Count - 1 do
  begin
    New(PStr);
    PStr^ := tmp[i];
    Result.AddObject(Sort(tmp[i]), TObject(PStr));
  end;

end;

function Solve(Words: TStringList): Integer;
var
  Pow2: TStringList;

  function Reverse(const S: AnsiString): AnsiString;
  var
    i: Integer;

  begin
    Result := S;
    for i := Length(S) downto 1 do
      Result[Length(S) + 1 - i] := S[i];
  end;

  function BothAreSquares(const S1, S2: AnsiString): Integer;
  var
    i, j: Integer;
    p1, S: AnsiString;
    Mapping: array['A'..'Z'] of Char;
    ic, jc: Char;
    IsValid: Boolean;

  begin
    if S1 = Reverse(S2) then
      Exit(-1);

    Result := -1;

    for i := 0 to Pow2.Count - 1 do
    begin
      if Length(Pow2[i]) <> Length(S1) then
        Continue;
      if Length(S2) < Length(Pow2[i]) then
        break;
      p1 := Pow2[i];
      FillChar(Mapping, SizeOf(Mapping), 255);

      for j := 1 to Length(S1) do
        Mapping[S1[j]] := P1[j];
      S := '';
      for j := 1 to Length(S2) do
        S += Mapping[S2[j]];
      IsValid:= True;
      for ic := 'A' to 'Z' do
        if Mapping[ic] <> #$FF then
        begin
          for jc := Succ(ic) to 'Z' do
            if Mapping[ic] = Mapping[jc] then
            begin
              IsValid := False;
              Break;
            end;
          if not IsValid then
            Break;
        end;

      if not IsValid then
        Continue;



      if Pow2.IndexOf(S) <> -1 then
        if Result < StrToInt(S) then
        begin
          WriteLn(S1, ' ', P1,  ' ',S2, ' ', S);
          Result := Max(StrToInt(S), StrToInt(P1));
        end;
    end;

  end;

var
  i, j, k, l: Integer;
  tmp: Integer;


begin
  Result := -1;
  Words.Sort;

  Pow2 := TStringList.Create;
  for i := 1 to 10000 do
    Pow2.Add(IntToStr(i * i));
  Pow2.Sort;

  i := 0;
  while i < Words.Count - 1do
    if Words.Strings[i] = Words.Strings[i + 1] then
    begin
      j := i;
      while Words.Strings[i] = Words.Strings[j] do
      begin
        Inc(j);
        if j = Words.Count then
          break;
      end;
      for k := i to j - 1 do
        for l := k + 1 to j - 1do
        begin
        tmp := BothAreSquares(PString(Words.Objects[k])^, PString(Words.Objects[l])^);

          if Result < tmp then
          begin
            WriteLn(tmp, ' ', Result);
            Result := tmp;
          end;
        end;
      i := j;
    end
    else
      Inc(i);

end;

var
  SList: TStringList;
  T: TDateTime;

begin
  T := Now;

  SList := ReadData;

  WriteLn(Solve(SList));


  SList.Free;

  WriteLn('MS = ', MilliSecondsBetween(T, Now));
end.
