# binary tree data structure
class binTree:
    def __init__(self, N, code):
        self.deft = [0,0]
        self.v = [self.deft]*N
        self.n = code

    def add(self, token):
        x = [token, self.n]
        i = 1
        while self.v[i] != self.deft:
            if x[0] > self.v[i][0]:
                i = i*2+1
            else:
                i = i*2
        self.v[i] = x
        self.n += 1

    def find(self, token):
        i = 1
        while self.v[i] != self.deft:
            if token == self.v[i][0]:
                return 1
            elif token > self.v[i][0]:
                i = i*2+1
            elif token < self.v[i][0]:
                i = i*2
            else:
                return 0
        return 0

    def print_data(self):
        s = ""
        for x in self.v:
            if x != self.deft:
                s += str(x)+'\n'
        print(s)
