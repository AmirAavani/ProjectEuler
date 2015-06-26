S9 = '123456789'
answers = {}
for n in range(100000):
  N = str(n)
  ia = 0
  while ia * ia <= n:
    a = ia + 1
    if (n % a) == 0:
      b = n / a
      A = str(a)
      B = str(b)
      S = N + A + B
#      print N, A, B, S
      if len(S) == 9:
        flag = True
        for c in S9:
          if S.find(c) == -1:
            flag = False
            break
      else: 
        flag = False

      if flag:
        answers[n] = A + "," + B
    ia += 1
Sum = 0
for ans in answers.items():
  print ans[0], ans[1]
  Sum += ans[0]
print Sum
      
