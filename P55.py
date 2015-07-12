def IsPalindrome(n):
  Sn = str(n)
  for i in range(len(Sn)):
    if Sn[i] != Sn[len(Sn) - 1 - i]:
      return False
  return True

Count = 0
for i in range(10000):
  n = i
  flag = False
  for j in range(50):
    sn = str(n)
    rev_sn = ''
    for c in sn:
      rev_sn = c + rev_sn
    rev_n = int(rev_sn)
    n = int(n + rev_n)
    if IsPalindrome(n):
      flag = True
      break
  if not flag:
    Count += 1
    print Count, i
    
