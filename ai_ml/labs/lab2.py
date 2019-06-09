from copy import deepcopy
BASE = 5

class State:
    alpha = {}
    def __init__(self):
        self.alpha["0"] = 0;
    def assign_values (self,x):
        self.alpha = x;
    def __eq__(self, other):
        if self.alpha == other.alpha:
            return True
        else:
            return False
    def __ne__(self, other):
        return not self.__eq__(other)

class Problem:
    initial = State()
    final = State()
    num1 = []
    num2 = []
    num3 = []

    def __init__(self):
        self.read()

    def expand(self, state):
        next_states = []

        for i in state.alpha.keys():
            new_alpha = deepcopy(state.alpha)
            if new_alpha[i] < BASE-1 and i != '0':
                new_alpha[i] += 1
                s = State()
                s.assign_values(new_alpha)
                next_states.append(s)
        return next_states

    def validate(self, state):
        rest = 0;
        for x, y, z in map(None, self.num1, self.num2, self.num3):
            if x == None: x = "0"
            if y == None: y = "0"
            if z == None: z = "0"
            #print x,":",self.alpha[x],"+",y,":",self.alpha[y],"=",z,":",self.alpha[z]
            if (rest + state.alpha[x] + state.alpha[y])%BASE != state.alpha[z]:
                return False
            rest = (rest + state.alpha[x] + state.alpha[y])/BASE
        if state.alpha[self.num1[-1]] == 0 or state.alpha[self.num2[-1]] == 0 or state.alpha[self.num3[-1]] == 0:
            return False
        if rest != 0:
            return False
        return True

    def heuristic(self, state):
        score = 0
        rest = 0;
        for x, y, z in map(None, self.num1, self.num2, self.num3):
            if x == None: x = "0"
            if y == None: y = "0"
            if z == None: z = "0"
            #print x,":",self.alpha[x],"+",y,":",self.alpha[y],"=",z,":",self.alpha[z]
            if abs((rest + state.alpha[x] + state.alpha[y])%BASE - state.alpha[z]) > 1 :
                score += 1
            rest = (rest + state.alpha[x] + state.alpha[y])/BASE

        if state.alpha[self.num1[-1]] == 0:
            score += 10
        if state.alpha[self.num2[-1]] == 0:
            score += 10
        if state.alpha[self.num3[-1]] == 0:
            score += 10
        if rest != 0:
            score += 1
        return score

    def read(self):
        #self.initial.num1 = list(input("num1:"))
        #self.initial.num2 = list(input("num2:"))
        #self.initial.num3 = list(input("num3:"))

        self.num1 = list(reversed("send"))
        self.num2 = list(reversed("more"))
        self.num3 = list(reversed("money"))

        for i in self.num1:
            self.initial.alpha[i] = 0;
        for i in self.num2:
            self.initial.alpha[i] = 0;
        for i in self.num3:
            self.initial.alpha[i] = 0;

        # self.initial.alpha[self.num1[-1]] = 1;
        # self.initial.alpha[self.num2[-1]] = 1;
        # self.initial.alpha[self.num3[-1]] = 1;

        print '\n',''.join(reversed(self.num1)),'+\n',''.join(reversed(self.num2)),'=\n',''.join(reversed(self.num3))

class Controller:
    prob = Problem()

    def bfs(self):
        toVisit = [self.prob.initial]
        visited = []
        found = False
        it = 0
        while len(toVisit) != 0 and not found:
            it += 1
            state = toVisit.pop(0)
            if it%100 == 0:
                #self.print_result(self.prob.num1,self.prob.num2,self.prob.num3,state.alpha)
                print it, "iterations passed"
            if self.prob.validate(state):
                found = True
                self.print_result(self.prob.num1,self.prob.num2,self.prob.num3,state.alpha)
                break;
            else:
                children = self.prob.expand(state)
                visited.append(state)
                aux = []
                for x in children:
                    if x not in visited and x not in toVisit:
                        aux.append(x)
                toVisit = toVisit + aux
        print it, "total iterations"
        if found:
            print "found"
        else:
            print "not found"

    def goodbfs(self):
        toVisit = [self.prob.initial]
        visited = []
        found = False
        it = 0

        while len(toVisit) != 0 and not found:
            it += 1
            toVisit.sort(key=lambda x: self.prob.heuristic(x),reverse=False)
            state = toVisit.pop(0)
            if it%100 == 0:
                #print "\nscore", self.prob.heuristic(state)
                #self.print_result(self.prob.num1,self.prob.num2,self.prob.num3,state.alpha)
                print it, "iterations passed"

            if self.prob.validate(state):
                found = True
                self.print_result(self.prob.num1,self.prob.num2,self.prob.num3,state.alpha)
                break;
            else:
                children = self.prob.expand(state)
                visited.append(state)
                aux = []
                for x in children:
                    if x not in visited and x not in toVisit:
                        aux.append(x)
                toVisit = toVisit + aux


        print it, "total iterations"
        if found:
            print "found"
        else:
            print "not found"

    def print_result (self,w1,w2,w3,alpha):
        n1 = [];
        n2 = [];
        n3 = [];
        for x in reversed(w1):
            for k in alpha.keys():
                if k == x:
                    n1.append(alpha[k])
        for x in reversed(w2):
            for k in alpha.keys():
                if k == x:
                    n2.append(alpha[k])
        for x in reversed(w3):
            for k in alpha.keys():
                if k == x:
                    n3.append(alpha[k])
        print '\n',''.join(str(x) for x in n1),'+\n',''.join(str(x) for x in n2),'=\n',''.join(str(x) for x in n3),'\n';

class UI:
    con = Controller()

    def run(self):
        print "\nMENU:\n1 - uninformed\n2 - informed\n"
        ans = input('answer:')
        if(ans == 1):
            self.con.bfs()
        elif (ans == 2):
            self.con.goodbfs()
        else:
            print "exit"

ui = UI()
ui.run()
