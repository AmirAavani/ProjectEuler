a = 1
b = 1
i = 3
while True:
  c = a + b
  a = b
  b = c
  c = a + b
  i += 1
  Sc = str(c)
  if len(Sc) == 1000:
    print i, c, Sc
    break
