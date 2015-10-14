def Pow2(pow, modulo):
  if pow == 0:
    return 1
  if pow == 1:
    return 2
  result = Pow2(pow // 2, modulo)
  result *= result
  result %= modulo
  if pow % 2 == 1:
    result *= 2
  result %= modulo
  return result

modulo = 10000000000L
print Pow2(3, modulo)
print (28433 * Pow2(7830457, modulo) + 1) % modulo

