program P62;
uses
  SysUtils, fgl;

type
  TStringToIntMap = specialize TFPGMap<String, Integer>;

function Sorted(S: AnsiString): AnsiString;
var
  i, j: Integer;
  tmp: Char;

begin
  Result := S;

  for i := 1 to Length(Result) do
    for j := i + 1 to Length(Result) do
      if Result[j] < Result[i] then
      begin
        tmp := Result[i];
        Result [i] := Result[j];
        Result [j] := tmp;
      end;
end;

var
  i: Integer;
  n: Int64;
  S, Answer: AnsiString;
  Index: Integer;
  Maps: array [0..100] of TStringToIntMap;

begin

  FillChar(Maps, SizeOf(Maps), 0);

  for i := 1 to 10000 do
  begin
    n := i;//vs[i];
    S := IntToStr(n * n* n);
//    Write(n, ' ', Length(S), ' ', S, ' ', Sorted(S));
    S := Sorted(S);
    if Maps[Length(S)] = nil then
      Maps[Length(S)] := TStringToIntMap.Create;
    Index := -1;
    if Maps[Length(S)].IndexOf(S) <> -1 then
      Maps[Length(S)].KeyData[S] := Maps[Length(S)].KeyData[S] + 1
    else
      Maps[Length(S)].Add(S, 1);

//    WriteLn(' ', Maps[Length(S)].KeyData[S]);
    if Maps[Length(S)].KeyData[S] = 5 then
    begin
      WriteLn(i, ' ', S);
      Answer := S;
      break;
    end;
  end;

  for i := 1 to 10000 do
    if Answer = Sorted(IntToStr(i * i * i)) then
    begin
      WriteLn(i, ' ', i * i * i);
    end;

end.
