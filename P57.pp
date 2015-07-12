program P57;
uses
  NumberTheoryUnit, SysUtils, gvector, BigInt, GenericCollectionUnit;

type

  { TFraction }

  TFraction = class(TObject)
  private
    FNumerator, FDenominator: TBigInt;

  public
    property Numerator : TBigInt read FNumerator;
    property Denominator: TBigInt read FDenominator;

    constructor Create;
    constructor Create(n, d: Int64);
    destructor Destroy; override;
    function Add(Another: TFraction): TFraction;
    {Returns Self}
    function Simplify: TFraction;
    function Revert: TFraction;

    function ToString: AnsiString;
  end;

{ TFraction }

constructor TFraction.Create;
begin
  inherited;

  FNumerator := BigIntFactory.GetNewMember.SetValue(0);
  FDenominator := BigIntFactory.GetNewMember.SetValue(1);
end;

constructor TFraction.Create(n, d: Int64);
begin
  inherited Create;

  FNumerator := BigIntFactory.GetNewMember.SetValue(n);
  FDenominator := BigIntFactory.GetNewMember.SetValue(d);
end;

destructor TFraction.Destroy;
begin
  BigIntFactory.ReleaseMember(FNumerator);
  BigIntFactory.ReleaseMember(FDenominator);

  inherited Destroy;
end;

function TFraction.Add(Another: TFraction): TFraction;
var
  tmp: TBigInt;
begin
  Result := TFraction.Create;
  Result.FDenominator := Self.Denominator.Mul(Another.Denominator);
  tmp :=  Another.Numerator.Mul(Self.Denominator);
  Result.FNumerator := Self.Numerator.Mul(Another.Denominator).Add(tmp);
  BigIntFactory.ReleaseMember(tmp);

//  Result.Simplify;
end;

function TFraction.Simplify: TFraction;
var
  d: TBigInt;
begin
  Result := TFraction.Create;
  d := Self.Numerator.gcd(Self.Denominator);

  Result.FNumerator := Self.Numerator.Divide(d);
  Result.FDenominator := Self.Denominator.Divide(d);
  d.Free;
end;

function TFraction.Revert: TFraction;
begin
  Result := TFraction.Create;

  Result.FDenominator := Self.Numerator.Copy;
  Result.FNumerator := Self.Denominator.Copy;

end;

function TFraction.ToString: AnsiString;
begin
  Result := Numerator.ToString + '/' + Denominator.ToString;
end;

var
  i: Integer;
  Count: Integer;
  Two, One, tmp, Current, Final: TFraction;

begin
  Current := TFraction.Create(1, 2);
  Two := TFraction.Create(2, 1);
  One := TFraction.Create(1, 1);
  for i := 1 to 999 do
  begin
    tmp := Two.Add(Current);
    Current := tmp.Revert;
    Current.Simplify;
    tmp.Free;
    Final := Current.Add(One);
    tmp := Final.Simplify;
    Final.Free;
    Final := tmp;

    if Length(Final.Denominator.ToString)< Length(Final.Numerator.ToString) then
    begin
      Inc(Count);
      WriteLn(Count, ' : i = ', i, ' Final = ',  Final.ToString);
    end;
    Final.Free;

  end;
end.
