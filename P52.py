def IsOK(n):
  Digits = [0] * 10
  for d in str(n):
    Digits[int(d[0])] += 1
    
  for i in range(6):
    for d in str((i + 1) * n):
      Digits[int(d[0])] -= 1

    for d in range(10):
      if not (Digits[d] == 0):
        return False

    for d in str((i + 1) * n):
      Digits[int(d[0])] += 1
 
  return True

T = 1
Flag = False
for t in range(8):
  for I in range(T, 4 * T, 1):
    i = I + 1
    if IsOK(i):
      print(i)
      Flag = True
      break
  if Flag:
    break
  T *= 10
for j in range(6): 
  print(i * (j + 1))
