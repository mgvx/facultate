from copy import deepcopy
import random
import numpy

class Individ:
    word = []
    f = 0 # fitness value
    x = 0 # DOWN
    y = 0 # RIGHT
    l = 0 # word length
    s = 0 # 0-oriz 1-vert

    def __init__(self,w,p):
        self.word = w
        self.l = len(self.word)
        self.x = p[0]
        self.y = p[1]
        self.s = p[2]

    def fitness (self,score):
        self.f = score

    def mutate (self, pscore, min_chance):
        return random.randint(0,100) < self.f*100/pscore + min_chance

    def crossover (self, other):
        self.x , other.x = other.x, self.x
        self.y , other.y = other.y, self.y
        self.s , other.s = other.s, self.s


class Population:
    individs = []

    def __init__(self,words,pos):
        self.individs = []
        for w in words:
            i = Individ(w,pos.pop(0))
            self.individs.append(i)

    def evaluate (self, clean_table):
        table = deepcopy(clean_table)
        score = 0
        for i in self.individs:
            word_score = 0
            if i.s == 1:
                if i.x+i.l <= len(table) and i.y <= len(table):
                    y = i.y
                    for x in range(i.x,i.x+i.l):
                        if table[x][y] == ' ' or table[x][y] == i.word[x-i.x]:
                            table[x][y] = i.word[x-i.x]
                        else:
                            word_score += 1
                else:
                    word_score += i.l
            if i.s == 0:
                if i.y+i.l <= len(table) and i.x <= len(table):
                    x = i.x
                    for y in range(i.y,i.y+i.l):
                        if table[x][y] == ' ' or table[x][y] == i.word[y-i.y]:
                            table[x][y] = i.word[y-i.y]
                        else:
                            word_score += 1
                else:
                    word_score += i.l
            score += word_score
            i.fitness(word_score)
        return [score, table]

    def selection (self, score):
        # self.individs.sort(key=lambda x: x.f,reverse=True)
        min_chance = 10
        affected = []
        unaffected = []
        for i in self.individs:
            # print i.f, ''.join(i.word),i.x,i.y,i.s
            if i.mutate(score,min_chance):
                affected.append(i)
            else:
                unaffected.append(i)
        random.shuffle(affected)
        for i in range(0,len(affected)-1,2):
                affected[i].crossover(affected[i+1])
        self.individs = affected + unaffected
        # print 'res:'
        # for i in self.individs:
        #     print i.word, i.x, i.y


class Problem:
    table = []
    words = []
    pos = []

    def __init__(self):
        self.read()
        self.get_pos()

    def read(self):
        str_words = ['cinci','unde','re','rac','fa','fiz','za','arde','dud']
        for w in str_words:
            self.words.append(list(w))
        print str_words
        table = [
                "* ** *",
                "* *   ",
                "    **",
                "* ** *",
                "   * *",
                "**    "]
        for w in table:
            print w
            self.table.append(list(w))

    def get_pos(self):
        t = self.table
        for x in range(0,len(self.table)):
            for y in range(0,len(self.table)):
                if t[x][y]==' ' and x==0 and t[x+1][y]==' ':
                    self.pos.append([x,y,1])
                elif t[x][y]==' ' and x+1< len(self.table) and t[x+1][y]==' ' and t[x-1][y]!=' ':
                    self.pos.append([x,y,1])
                if t[x][y]==' ' and y==0 and t[x][y+1]==' ':
                    self.pos.append([x,y,0])
                elif t[x][y]==' ' and y+1< len(self.table) and t[x][y+1]==' ' and t[x][y-1]!=' ':
                    self.pos.append([x,y,0])
        random.shuffle(self.pos)
        # print self.pos;


class Algorithm:
    p = Problem()
    w = Population(p.words,p.pos)

    def __init__(self):
        print ""

    def iteration (self, score, table):
        self.w.selection(score)
        [new_score , new_table] = self.w.evaluate(self.p.table)
        return [new_score, new_table]

    def run (self):
        i = 0;
        [score , table] = self.w.evaluate(self.p.table)
        while  score != 0:
            [score, table] = self.iteration(score, table)
            if i%500 == 0:
                print '\niteration',i,'\nscore',score
                for x in table:
                    print x
            i += 1
        print '\ntotal iterations',i,'\n\nSOLUTION:'
        for x in table:
            print ' '.join(x)
        self.statistics()

    def statistics (self):
        fit_scores = []
        for run in range(0,10):
            best_score = 999999
            self.p.get_pos()
            self.w = Population(self.p.words,self.p.pos)
            i = 0;
            [score , table] = self.w.evaluate(self.p.table)
            while  score != 0 and i<100:
                [score, table] = self.iteration(score, table)
                if best_score > score:
                    best_score = score
                i += 1
            fit_scores.append(best_score)
        print "\nSTATISTICS:"
        print "average fitness score: ", numpy.mean(fit_scores)
        print "standard deviation: ", numpy.std(fit_scores)

class UI:
    algo = Algorithm()

    def run(self):
        self.algo.run()

ui = UI()
ui.run()
