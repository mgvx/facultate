import random
import math

learn_rate = 0.8

class Neuron:
    def __init__(self, noI):
        self.noI = noI
        self.weights = [(random.random()*2-1) for _ in range(self.noI)]
        self.err = 0
        self.output = 0

    def activate(self, info):
      net = sum([self.weights[i] * info[i] for i in range(self.noI)])
      #  self.output = net # liniar
      self.output = 1 / (1 + math.exp(-net)) # sigmoid

    def setErr(self, value):
      #  self.err = value # liniar
      self.err = self.output * (1 - self.output) * value # sigmoid


class Layer:
    def __init__(self, noN, noI):
        self.noN = noN
        self.neurons = [Neuron(noI) for i in range(self.noN)]


class Network:
    def __init__(self, m, r, p, h):
        self.noI = m # no input neurons
        self.noO = r # no output neurons
        self.noH = p # no hidden layers
        self.noNPHL = h # neurons per hidden layer
        self.layers = [Layer(self.noI, 0)]
        self.layers += [Layer(self.noNPHL, self.noI)]
        self.layers += [Layer(self.noNPHL, self.self.noNPHL) for i in range (self.noH - 1)]
        self.layers += [Layer(self.noO, self.noNPHL)]

    def activate(self, inputs):
        i = 0
        for n in self.layers[0].neurons:
            n.output = inputs[i]
            i += 1
        for l in range(1, self.noH + 2):
            info = [(self.layers[l-1].neurons[i].output) for i in range (self.layers[l - 1].noN)]
            for n in self.layers[l].neurons:
                n.activate(info)

    def backprop(self, err):
        for l in range(self.noH + 1, 0, -1):
            i = 0
            for n1 in self.layers[l].neurons:
                if l == self.noH + 1:
                    n1.setErr(err[i])
                else:
                    sumEr = sum([n2.weights[i] * n2.err for n2 in self.layers[l + 1].neurons])
                    n1.setErr(sumEr)
                for j in range(n1.noI):
                    n1.weights[j] = n1.weights[j] + learn_rate * n1.err * self.layers[l - 1].neurons[j].output
                i += 1

    def errorComp(self,target, err):
        globalErr = 0.0
        for i in range(self.layers[self.noH + 1].noN):
            err.append(target[i] - self.layers[self.noH + 1].neurons[i].output)
            globalErr += err[i] * err[i]
        return(globalErr)


class Problem:
    n = Network(7,1,1,4)
    v_min = [999]*30
    v_max = [-999]*30
    data = []

    def __init__(self):
        self.read()
        # random.shuffle(self.data);

    def minmax(self):
        f = open('data.txt', 'r')
        for line in f:
            v = map(float, line.split())
            for i in range(len(v)):
                self.v_min[i] = min(self.v_min[i],v[i])
                self.v_max[i] = max(self.v_max[i],v[i])

    def norm(self,x,xmin,xmax):
        return (x-xmin)/(xmax-xmin)

    def read(self):
        self.minmax()
        f = open('data.txt', 'r')
        for line in f:
            nums = map(float, line.split())
            v = [self.norm(x,xmin,xmax) for x,xmin,xmax in zip(nums,self.v_min,self.v_max)]
            x = [v[-1],v[-2],v[-3],v[-4],v[-5],v[-6],v[1], [v[5]]]
            self.data.append(x)

    def learn(self, data):
        print "Learning..."
        stop = False
        k = 0
        while (not stop) and (k < 100):
            errors = [0]*6000
            for i in range(len(data)):
                self.n.activate(data[i])
                err = []
                errors[i] = self.n.errorComp(data[i][-1], err)
                self.n.backprop(err)

            median_err=sum(errors)/len(data)
            if not k%10:
                print median_err
            if (abs(median_err)<1/(10**4)):
                stop = True
            k+=1

    def test(self, data):
        print "Testing..."
        errors = [0]*6000
        for i in range(len(data)):
            self.n.activate(data[i])
            err=[]
            errors[i] = self.n.errorComp(data[i][-1], err)
        median_err=sum(errors)/len(data)
        print median_err

    def run(self):
        self.learn(self.data[:-200]);
        self.test(self.data[-200:]);

p = Problem()
p.run()
