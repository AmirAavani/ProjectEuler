program P20;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes
  { you can add units after this };

const
  Days : array [1..12] of Integer =
    (31, 28, 31, 30,
    31, 30, 31, 31, 30, 31, 30, 31);

function CountDays(y: Integer): Integer;
  function IsLeapYear(y: Integer): Boolean;
  begin
    if y mod 4 <> 0 then
      Exit(False);
    // y mod 4 = 0
    if y mod 400 = 0 then
      Exit(True);
    if y mod 100 = 0 then
      Exit(False);
    Result := True
  end;

var
  m: Integer;

begin
  Result := 0;
  for m := 1 to 1 do
    Result += Days[m];
  m := 2;
  Result += Days[m];
  if IsLeapYear(y) then
    Inc(Result);
  for m := 3 to 12 do
    Result += Days[m];
end;

var
  y, m: Integer;
  d: Integer;

begin
  d := CountDays(1900);
  for y := 1900 to 1900 do
  begin
    for m := 1 to 1 do
      d += Days[m];
    m := 2;
    d += Days[m];
  end;


end.

