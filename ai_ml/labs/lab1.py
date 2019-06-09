
import random
import numpy

def gen(n,k):
   x = [[random.randint(0,n),random.randint(0,n)] for i in range(n)]
   random.shuffle(x)
   x=x[:k]
   return x

def check(n,x):
    ok = 0
    for i in range(n-1):
        if x[i][0] < x[i+1][0]:
            ok+=1
        if x[i][1] == x[i+1][1]:
            ok+=1
    return ok

n = input('n:')
k = input('k:')
print "\nEXAMPLE:"
print "cube: [edge,color]"
x = gen(n,k)
print "solution:",x
ok = check(k,x)
print "solution quality:",ok
if ok == 0:
    print "valid solution"
else:
    print "invalid solution"

print "\nSTATISTICS:"
okarr = []
for i in range(n):
    x = gen(n,k)
    okarr.append(check(k,x))
print "mean", numpy.mean(okarr, axis=0)
print "stddev", numpy.std(okarr, axis=0)
