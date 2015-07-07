Modulo = 10000000000

def Pow(a, b):
  if b == 0:
    return 1
  if b == 1:
    return a;
  global Modulo
  r = Pow(a,  b // 2); 

  r *= r
  r = r % Modulo
  if b % 2 == 1:
    r *= a;
  r = r % Modulo

  return r;

S = 0
for i in range(1000):
  n = i + 1
  S += Pow(n, n)
  S = S % Modulo
print S
