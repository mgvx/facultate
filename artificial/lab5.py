import random

class Problem:
    input1 = []
    input2 = []
    param1 = []
    param2 = []
    output = []
    rules = []

    def __init__(self):
        self.read()

    def read(self):
        self.input1 = ['cold  ','cool  ','moderate','hot   ','very hot']
        self.input2 = ['small ','medium','high  ']
        self.param1 = [[20,20,30,50],
                        [30,50,70],
                        [60,70,80],
                        [70,90,110],
                        [90,110,120,120]]
        self.param2 = [[0,0,5],
                        [3,5,7],
                        [5,10,10]]
        self.output = ['small','medium','high']
        self.rules = [[0,1,2],
                    [0,1,2],
                    [0,1,2],
                    [0,0,0],
                    [0,0,0]]

    def triangle(self,x,a,b,c):
        X = (x-a)/((b-a)*1.0) if a!=b else 1
        Y = (c-x)/((c-b)*1.0) if b!=c else 1
        return max(0,min(1,min(X,Y)))

    def trapez(self,x,a,b,c,d):
        X = (x-a)/((b-a)*1.0) if a!=b else 1
        Y = (d-x)/((d-c)*1.0) if d!=c else 1
        return max(0,min(1,min(X,Y)))


class Controller:
    p = Problem()

    def run(self):
        for i in range(100):
            self.solve();
            print ''

    def solve(self):
        i1 = round(random.uniform(20.0,121.0), 1)
        i2 = round(random.uniform(0.0,11.0), 1)

        v1 = self.eval_domain(i1, self.p.param1)
        v2 = self.eval_domain(i2, self.p.param2)

        r1 = self.get_max(v1)
        r2 = self.get_max(v2)

        v = self.sum_prob(v1,v2)
        r = self.p.rules[r1][r2]

        print 'input 1: ',i1,'  \tdomain: ',self.p.input1[r1],'\tprob: ',v1
        print 'input 2: ',i2,'  \tdomain: ',self.p.input2[r2],'\tprob: ',v2
        print 'RESULT:\t\t\toutput: ',self.p.output[r],'  \tprob: ',v[r]

    def sum_prob(self,v1,v2):
        v = [0,0,0,0,0]
        j = 0;
        for line in self.p.rules:
            i = 0;
            for x in line:
                v[x] += v2[i]*v1[j]
                i += 1
            j += 1
        return v

    def get_max(self,x):
        j = 0
        for i in range(len(x)):
            if x[i]>x[j]:
                j = i
        return j

    def eval_domain(self,x,p):
        v = []
        for i in range(0,len(p)):
            r = 0
            if len(p[i]) == 3:
                r = self.p.triangle(x,p[i][0],p[i][1],p[i][2])
            if len(p[i]) == 4:
                r = self.p.trapez(x,p[i][0],p[i][1],p[i][2],p[i][3])
            v.append(round(r, 2))
        return v
        

c = Controller()
c.run()
