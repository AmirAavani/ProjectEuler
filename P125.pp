program P125;
uses
  fgl, SysUtils;
const
  Max = 100000000;

function IsPalindrome(n: uInt64): Boolean;
var
  Sn: AnsiString;
  i: Integer;

begin
  Sn := IntToStr(n);
  for i := 1 to Length(Sn) do
    if Sn[i] <> Sn[Length(Sn) - i + 1] then
      Exit(False);
  Result := True;
end;

type
  TMap = specialize TFPGMap<Integer, Integer>;

var
  i, j: Integer;
  Pow2, AccSum: array [0..10000] of uInt64;
  IsThere: TMap;
  CurSum: uInt64;

begin
  AccSum[0] :=0;
  for i := 1 to High(Pow2) do
  begin
    Pow2[i] := i * i;
    AccSum[i] := AccSum[i - 1] + Pow2[i];
  end;

  IsThere := TMap.Create;
  CurSum := 0;
  for i := 1 to High(Pow2) do
    for j := i + 1 to High(Pow2) do
      if IsPalindrome(AccSum[j] - AccSum[i - 1]) and (AccSum[j] - AccSum[i - 1] <= Max)then
      begin
        if IsThere.IndexOf(AccSum[j] - AccSum[i - 1]) = -1 then
          CurSum += AccSum[j] - AccSum[i - 1];
        IsThere.Add(AccSum[j] - AccSum[i - 1], 1);// += AccSum[j] - AccSum[i - 1];

      end;

  WriteLn(CurSum);
end.
