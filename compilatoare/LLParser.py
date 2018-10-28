import sys

grammars = open("grammar.txt")

G = {}
AG = []
C = {}
start = ""
terminals = []
nonterminals = []
symbols = []


def do_grammar():
    global G, start, terminals, nonterminals, symbols

    for line in grammars:
        line = " ".join(line.split())
        if line == '\n':
            break
        head = line[:line.index("->")].strip()
        prods = [l.strip().split(' ') for l in ''.join(line[line.index("->") + 2:]).split('|')]
        if not start:
            start = head #+ "'"
            G[start] = []#[head]]
            nonterminals.append(start)
        if head not in G:
            G[head] = []
        if head not in nonterminals:
            nonterminals.append(head)
        for prod in prods:
            G[head].append(prod)
            AG.append((head,prod))
            for char in prod:
                if not char.isupper() and char != '^' and char not in terminals:
                    terminals.append(char)
                elif char.isupper() and char not in nonterminals:
                    nonterminals.append(char)
                    G[char] = []
    terminals.append('$')
    symbols = terminals + nonterminals


first_seen = []


def do_first(X):
    global first_seen
    first = []

    first_seen.append(X)
    if X in terminals:  # CASE 1
        first.append(X)
    elif X in nonterminals:
        for prods in G[X]:  # CASE 2
            if prods[0] in terminals and prods[0] not in first:
                first.append(prods[0])
            elif '^' in prods and '^' not in first:
                first.append('^')
            else:  # CASE 3
                found_null = False
                for nonterm in prods:
                    found_null = False
                    if nonterm not in first_seen:
                        for terms in do_first(nonterm):
                            if terms == '^':
                                found_null = True
                            elif terms not in first:
                                first.append(terms)
                    if not found_null:
                        break
                if found_null:
                    first.append('^')
                    for Gprods in G[X]:
                        if X in Gprods and Gprods.index(X) + 1 < len(Gprods):
                            for terms in do_first(Gprods[Gprods.index(X) + 1]):
                                if terms not in first:
                                    first.append(terms)
    first_seen.remove(X)
    return first


follow_seen = []


def do_follow(A):
    global follow_seen
    follow = []

    follow_seen.append(A)
    if A == start:  # CASE 1
        follow.append('$')
    for heads in G.keys():
        for prods in G[heads]:
            follow_head = False
            if A in prods:
                next_symbol_pos = prods.index(A) + 1
                if next_symbol_pos < len(prods):  # CASE 2
                    for terms in do_first(prods[next_symbol_pos]):
                        if terms != '^':
                            if terms not in follow:
                                follow.append(terms)
                        else:  # CASE 3
                            follow_head = True
                else:  # CASE 3
                    follow_head = True
                if follow_head and heads not in follow_seen:
                    for terms in do_follow(heads):
                        if terms not in follow:
                            follow.append(terms)
    follow_seen.remove(A)
    return follow

def do_something(i, s):
    if i[0]=="$" and s[0]=="$":
        return "acc"
    if i[0]==s[0]:
        return "pop"
    if parse_table[nonterminals.index(s[0])][terminals.index(i[0])]!=0:
        return "p"+str(parse_table[nonterminals.index(s[0])][terminals.index(i[0])])
    
    return "err"

def table():
    i = 1
    for item in AG:
        # print(i,item)
        for x in do_first(item[1][0]):
            # print (i," ",x)
            if x != '^':
                parse_table[nonterminals.index(item[0])][terminals.index(x)] = i
        if(item[1][0]=='^'):
            for y in do_follow(item[1][0]):
                if parse_table[nonterminals.index(item[0])][terminals.index(y)] == 0:
                    parse_table[nonterminals.index(item[0])][terminals.index(y)] = i
        i += 1


def print_info():
    print ("GRAMMAR:")
    for head in G.keys():
        #if head == start:
        #    continue
        print ("{:>{width}} ->".format(head, width=len(max(G.keys(), key=len))),end="")
        num_prods = 0
        for prods in G[head]:
            if num_prods > 0:
                print ("|",end="")
            for prod in prods:
                print (prod,end="")
            num_prods += 1
        print()
    print ("\nAUGMENTED GRAMMAR:")
    i = 1
    for item in AG:
        print(i,": ",item[0]," -> ",''.join(item[1]))
        i += 1
    print ("\nTERMINALS   :", terminals)
    print ("NONTERMINALS:", nonterminals)
    print ("SYMBOLS     :", symbols)
    print ("\ndo_first:")
    for head in G:
        print ("{:>{width}} =".format(head, width=len(max(G.keys(), key=len))),end="")
        print ("{",end="")
        num_terms = 0
        for terms in do_first(head):
            if num_terms > 0:
                print (", ",end="")
            print (terms,end="")
            num_terms += 1
        print ("}")
    print ("\ndo_follow:")
    for head in G:
        print ("{:>{width}} =".format(head, width=len(max(G.keys(), key=len))),end="")
        print ("{",end="")
        num_terms = 0
        for terms in do_follow(head):
            if num_terms > 0:
                print (", ",end="")
            print (terms,end="")
            num_terms += 1
        print ("}")

    print ("PARSING TABLE:")
    print ("+" + "--------+" * (len(terminals) +1))
    print ("|{:^8}|".format('Terminal'),end="")
    for terms in terminals:
        print ("{:^8}|".format(terms),end="")

    print ("\n+" + "--------+" * (len(terminals)  + 1))
    for i in range(len(parse_table)):
        print ("|{:^8}|".format(nonterminals[i]),end="")
        for j in range(len(parse_table[i]) ):
            print ("{:^8}|".format(parse_table[i][j]),end="")
        print()
    print ("+" + "--------+" * (len(terminals) + 1))


def process_input(get_input):
    to_parse = " ".join((get_input + " $").split()).split(" ")

    pointer = 0
    stack = [start,"$"]

    print(to_parse)
    print ("|{:^8}|{:^28}|{:^28}|{:^11}|".format("STEP", "INPUT", "STACK", "do_something"))

    step = 1
    input_tape = to_parse
    output_tape = ""

    ha = 0
    while ha<100:
        ha += 1
        curr_symbol = to_parse[pointer]
        stack_content = ""
        input_content = ""

        print ("|{:^8}|".format(step),"{:27}|".format(''.join(stack)),"{:>26} | ".format(''.join(input_tape)),end="")
        # print ("|{:^8}|".format(step),"{:27}|".format(''.join(stack)),"{:>26} | ".format(''.join(input_tape)),end="")

        step += 1
        if(stack[0]=='^'):
            stack = stack[1:]
        get_action = do_something(input_tape, stack)
        if "p" in get_action and get_action!="pop":
            print ("{:^9}|".format(get_action))
            output_tape += get_action[1:]
            stack = AG[int(get_action[1:])-1][1]+stack[1:]
        elif get_action == "pop":
            print ("{:^9}|".format(get_action))
            i = 0
            input_tape = input_tape[1:]
            stack = stack[1:]
        elif get_action == "acc":
            print ("{:^9}|".format("ACCEPTED"))
            break
        else:
            print ("ERROR: Unrecognized symbol", input_tape[0], "|")
            break



if __name__ == "__main__":
  do_grammar()
  parse_table = [[0 for c in range(len(terminals) )] for r in range(len(nonterminals))]
  table()
  print_info()
  # text = input("secv: ")
  # process_input(text)
  # print(sys.argv)
  # process_input(sys.argv[1])
  process_input(open("test.txt", "r").read())
