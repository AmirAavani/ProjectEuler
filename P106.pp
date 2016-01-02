{O3}
{$Mode OBJFPC}
program P106;
uses
  SysUtils, MatchingUnit, dateutils, Classes;

const
  N = 12;

var
  SbCount: Integer;
function GenerateSubsets(S1, S2: AnsiString; Index: Integer): Integer;

  function NeedCompare(S1, S2: AnsiString): Boolean;
  var
    Mat: TAdjMartix;
    i, j: Integer;
    Matching: Integer;
    Left,Right: TIntList;


    procedure Clear;
    var
      i: Integer;

    begin
      Left.Free;
      Right.Free;
      for i := 0 to Length(S1) - 1 do
        SetLength(Mat[i], 0);
      SetLength(Mat, 0);

    end;

  begin

    if Length(S1) <> Length(S2) then
      Exit(False);

    SetLength(Mat, Length(S1));
    for i := 0 to Length(S1) - 1 do
    begin
      SetLength(Mat[i], Length(S2));
      for j := 0 to Length(S2)- 1 do
        Mat[i][j] := S1[i + 1] < S2[j + 1];
    end;
    Left := TIntList.Create;
    Right := TIntList.Create;

    Matching:= MaximumBipartiteMatching(Mat, Length(S1), Left, Right);
    // WriteLn(S1, ' ', S2, ' ', Matching);

    Result := Matching = Length(S1);

    if Result then
    begin
      Clear;
      Exit(False);
    end;
    for i := 0 to Length(S1) - 1 do
    begin
      for j := 0 to Length(S2) - 1 do
        Mat[i][j] := not Mat[i][j];
    end;

    Matching:= MaximumBipartiteMatching(Mat, Length(S1), Left, Right);
     // WriteLn(S1, ' ', S2, ' ', Matching);

    Result := Matching < Length(S1);

    Clear;
  end;

var
  NewChar: Char;

begin
  if Index = N + 1 then
  begin
    if (s1 = '')  or (s2 = '') or (s2 < s1) then
      Exit(0);

    Inc(SbCount);
    if Length(S1) <> Length(S2) then
      Exit(0);

    if NeedCompare(s1, s2) then
    begin
   //   WriteLn(S1, ' ', S2, NeedCompare(S1, S2));
      Result := 1
    end
    else
      Result := 0;
    Exit;
  end;
  {if (1 <= Length(s1)) and (1 < Length(s2)) and (S2[1] < S1[1]) then
    Exit(0);
  }
  NewChar := Chr(64 + index);
  Result := GenerateSubsets(s1 + NewChar, s2, Index + 1);
  Result += GenerateSubsets(s1, s2 + NewChar, Index + 1);
  Result += GenerateSubsets(s1, s2, Index + 1);

end;

var
  T1: TDateTime;

begin
  T1 := Now;

  WriteLn(GenerateSubsets('', '', 1));

  WriteLn(SbCount);
  WriteLn('MS = ', MilliSecondsBetween(T1, Now));
end.
