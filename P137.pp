program P137;
{
a = (1 + Sqrt(5)) / 2
b = (1 - Sqrt(5)) / 2
Fi = a^i - b^i/ Sqrt(5)
F1 = 1
F2 = [6 + 2 S(5)]/4 - [6 - 2S(5)]/4/S(5)
   = [S(5)]/S(5)] = 1

AF(x)= \Sum_i x^iFi
     = ...
     = x / (1 - x - x^2)

 AF(x) = N => x = N (1- x - x^2).
          Nx^2 + (N + 1) x - N = 0.
    x > 0:
    x = -(N+1) + Sqrt((N+1)^2 + 4N^2) / 2N
    x in R => (N+1)^2 + (2N)^2 is perfect square.
     => 5N^2+1+2N = M^2
     => (5N+1)^2 - 5M^2= -4
     Let x= (5N+1) and y = M and . Then,
       x^2 - 5y^2 = -4,
(+1, +1)
0<= y <= 2
(+1, -1)
(+2, +2)
}

var
  i: Integer;
  xCur, yCur, xNext, yNext: uInt64;
  N, M: Int64;
  x: Double;
begin
  xCur := 11; yCur := 5;
  i := 0;
  while i <= 15 do
  begin
    xNext := 9 * xCur + 20 * yCur;
    yNext := 4 * xCur + 9 * yCur;
    if  (2 * xNext - 1) mod 5 = 0 then
    begin
//     x= (5N+1)/2 and y = M/2 
      N := (2 * xNext - 1) div 5;
      M := 2 * yNext;
      x := (-(N+1) + Sqrt(Sqr(N+1) + 4 * Sqr(N))) / 2.0 /N;
     // WriteLn('x:', xNext ,' y:', yNext);
      WriteLn('N:', N,' M:', M, ' x:', x:0:10);
      //WriteLn(Sqr(xNext) - 5 * Sqr(yNext));
      Inc(i);
    end;

    xCur := xNext;
    yCur := yNext;
  end;
end.
