def Pow(n):
  result = n * n;
  result *= result;
  return result * n

S = 0
for n in range(1000000):
  s = str(n)
  sum = 0
  for d in s:
    sum += Pow(int(d[0]))
  if sum == n:
    S += n
    print n
print "S = ", S
