import re

class State:
    def __init__(self, x, y):
        self.n = x
        self.name = "q" + str(x)
        self.type = y

class Transition:
    def __init__(self, x, y, a):
        self.x = x
        self.y = y
        self.a = a

# input file automata model format:
# first line: at index i the type of qi: 1 for start, 0 for end, 10 for start and end, 2 for normal
# the rest n lines of form: x y a1 a2 a3 ... where x is qx, y is qy and a1, a2 ... are the value of that transition

class Automata:
    def __init__(self, filepath):
        self.states = []
        self.transitions = []
        self.alphabet = []

        self.read_model(filepath);
        # self.print_model();

    def read_model(self, filepath):
        lines = open(filepath, "r").readlines()

        for i,x in enumerate(lines):
            lines[i] = lines[i].replace("\n"," ")
            lines[i] = lines[i].split(" ")
            lines[i] = list(filter(lambda x: x != "", lines[i]))
            # print(lines[i])

        for i in range(0,len(lines[0])):
            self.states.append( State(i,int(lines[0][i])))
            # print(lines[1][i])

        for i in range(1,len(lines)):
            x = int(lines[i][0])
            y = int(lines[i][1])
            for j in range(2,len(lines[i])):
                self.transitions.append( Transition(x, y, lines[i][j]))
                self.alphabet.append(lines[i][2])

        self.alphabet = set(self.alphabet)

    def print_model(self):
        print("\nAlphabet:", self.alphabet)
        all_states = ""
        final_states = ""
        for s in self.states:
            all_states += s.name + ", "
            if(self.is_terminal_state(s.n)):
                final_states += s.name + ", "
        print("Automata States:", all_states[:-2])
        print("Final States:", final_states[:-2])
        print("\nTransitions:")
        for t in self.transitions:
            print("q"+str(t.x),"-" + t.a + "->", "q"+str(t.y))

    def get_next_state(self, x, a):
        for t in self.transitions:
            if t.x == x and t.a == a:
                return t.y
        return -1

    def get_start_state(self, ):
        for s in self.states:
            if s.type == 1 or s.type == 10:
                return s.n
        return -1

    def is_terminal_state(self, x):
        for s in self.states:
            if s.n == x and (s.type == 0 or s.type == 10):
                return True
        return False


    def check(self, s):
        next_state = self.get_start_state()
        i = 0
        k = 0
        while(next_state != -1 and i<len(s)):
            this_state = next_state
            next_state = self.get_next_state(this_state, s[i])
            if self.is_terminal_state(next_state):
                k = i+1
                # print("got",s[:i+1])
            i+=1
        return k

    def input_seq(self, s):
        print("\ninput:",s)
        k = self.check(s)
        if k == len(s):
            print("accepted")
        else:
            print("not accepted\nmax prefix:",s[:k])

# a = Automata("utils/constants_automata.txt")
# a.input_seq("123456789")
# a.input_seq("123456789")
# a.input_seq("014353")
# a.input_seq("10000")
# a.input_seq("0")
# a.input_seq("1")
