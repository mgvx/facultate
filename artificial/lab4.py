import random
import numpy
MAXN = 99999
E = 2.7182818284
class Particle:
    pos = 0
    vel = 0
    fit = MAXN
    best_pos = 0
    best_fit = MAXN

    def __init__(self):
        self.pos = random.randint(0,1)
        self.vel = random.random()

    def evaluate(self, particles, neigh):
        self.fit = 0
        for i in neigh:
            if particles[i].pos != self.pos:
                self.fit += 1

    def update(self, p):
        prob = 1/(1+E**-(self.vel))
        if random.random() < prob:
            self.pos = (p.pos+1)%2
            self.vel = (p.vel+self.vel)%2



class Swarm:
    particles = []

    def __init__(self, elem):
        self.particles = []
        for i in range(0,elem):
            self.particles.append(Particle())

    def get_best_neighbour(self, neigh):
        x = Particle()
        for i in neigh:
            if x.fit > self.particles[i].fit:
                x = self.particles[i]
        return x

    def best_particles(self, neigh):
        x = 0
        for p in self.particles:
            p.evaluate(self.particles, neigh[x])
            x += 1

        x = 0
        for p in self.particles:
            best = self.get_best_neighbour(neigh[x])
            if p != best:
                p.update(best)
            x += 1

    def fitness(self, subsets):
        fit = 0
        for subset in subsets:
            s = 0
            for i in subset:
                s += self.particles[i].pos
            if len(subset) == s or s == 0:
                fit += 1
        return fit


class Problem:
    elements = []
    subsets = []
    neighbours = []
    no_elements = 0
    no_subsets = 0

    def __init__(self):
        self.read()

    def read(self):
        # self.elements = [0,1,2,3,4,5,6,7,8,9]
        # self.subsets = [[1,2],[2,4,7],[3,9,4],[4,1],[8,9,3],[7,4]]

        N = random.randint(20,50)
        S = random.randint(5,30)
        for i in range(0,N):
            self.elements.append(i)
        for i in range(0,S):
            subs = []
            for i in range(2,6):
                subs.append(random.randint(0,N-1))
            self.subsets.append(subs)

        print "Elements:\n", self.elements
        print "Subsets:\n", self.subsets

        self.no_elements = len(self.elements)
        self.no_subsets = len(self.subsets)

        for x in range (0,self.no_elements):
            self.neighbours.append([])
            for s in self.subsets:
                if x in s:
                    self.neighbours[x].extend(s)

        for x in range (0,self.no_elements):
            self.neighbours[x] = list(set(self.neighbours[x]))
            if x in self.neighbours[x]:
                self.neighbours[x].remove(x)
        # print self.neighbours


class Controller:
    p = Problem()
    sw = Swarm(p.no_elements)

    def iteration(self):
        self.sw.best_particles(self.p.neighbours)

    def run(self):
        i = 0
        fit = self.sw.fitness(self.p.subsets)
        while  fit != 0:
            if i%1 == 0:
                print '\niteration',i,'\nfitness',fit
                self.printer()
            self.iteration()
            if i%300 == 0:
                self.sw = Swarm(self.p.no_elements)
            i += 1
            fit = self.sw.fitness(self.p.subsets)

        print '\ntotal iterations',i,'\n\nSOLUTION:'
        self.printer()
        self.statistics()

    def printer(self):
        s1 = []
        s2 = []
        x = 0
        for p in self.sw.particles:
            # print x, p.fit
            if p.pos == 0:
                s1.append(x)
            else:
                s2.append(x)
            x += 1
        print "0:",s1
        print "1:",s2

    def statistics (self):
        fit_scores = []
        for run in range(0,1000):
            best_score = MAXN
            self.sw = Swarm(self.p.no_elements)

            i = 0
            fit = self.sw.fitness(self.p.subsets)
            while  fit != 0 and i<10:
                if best_score > fit:
                    best_score = fit
                self.iteration()
                if i%300 == 0 and i>0:
                    self.sw = Swarm(self.p.no_elements)
                i += 1
                fit = self.sw.fitness(self.p.subsets)
            if best_score > fit:
                best_score = fit
            fit_scores.append(best_score)

        print "\nSTATISTICS:"
        print "average fitness score: ", numpy.mean(fit_scores)
        print "standard deviation: ", numpy.std(fit_scores)

c = Controller()
c.run()
