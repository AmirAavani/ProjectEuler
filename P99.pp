program P99;
uses
  SysUtils, Classes;
var
  i: Integer;
  a, b: Int64;
  v, max: Extended;
  MaxIndex: Integer;
  S: AnsiString;
  ab: TStringList;
begin
  AssignFile(Input, 'p099_base_exp.txt');
  Reset(Input);

  i := 1;
  Max := -1;

  while not Eof do
  begin
    ReadLn(S);

    ab := TStringList.Create;
    ExtractStrings([','], [], @S[1], ab);

    a := StrToInt(ab[0]);
    b := StrToInt(ab[1]);

    v := b * ln(a);

    if Max < v then
    begin
      Max := v;
      MaxIndex:= i;
      WriteLn(i, ' ', a, ' ', b);
    end;

    ab.Free;
    Inc(i);
  end;
  CloseFile(Input);
end.
