for ia in range(9):
  a = ia + 1
  for ib in range(9):
    b = ib + 1
    for ic in range(9):
      c = ic + 1
      n = 10 * a + b
      d = 10 * c + b
      if n < d:
        if n * c == a * d:
          print "n", n, "d", d, "a", a, "c", c
      n = 10 * b + a
      d = 10 * c + b
      if n < d:
        if n * c == a * d:
          print "n", n, "d", d, "a", a, "c", c
      n = 10 * b + c
      d = 10 * a + b
      if n < d:
        if n * a == c * d:
          print "n", n, "d", d, "a", a, "c", c
      n = 10 * a + b
      d = 10 * b + c
      if n < d:
        if n * c == a * d:
          print "n", n, "d", d, "a", a, "c", c

