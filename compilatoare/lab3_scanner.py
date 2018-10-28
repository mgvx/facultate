import re
from bintree import *
from automata import *

# reading atom file
filepath = "utils/p3.cpp"
keywords = open("utils/keys.txt", "r").read()
keywords = keywords.split()

def parse_automata():
    constants_automata = Automata("utils/constants_automata.txt")
    identifiers_automata = Automata("utils/identifiers_automata.txt")
    keywords_automata = Automata("utils/keywords_automata.txt")

    lines = open(filepath, "r").read()

    i = 0
    row = 1
    errors = 0

    words = ""
    while i<len(lines):
        if lines[i]==" ":
            j = 1
        elif lines[i]=="\n":
            row += 1
            j = 1
        else: # ignore space and newline
            j = keywords_automata.check(lines[i:])
            if j!=0: # if its a key sign
                word = lines[i:(i+j)]
                words += " " + word
            else:
                j = identifiers_automata.check(lines[i:])
                if j!=0: # if its a word
                    word = lines[i:(i+j)]
                    if word in keywords: # if its a key word
                        words += " " + word
                    else: # if its an identifier
                        words += " " + word
                else:
                    j = constants_automata.check(lines[i:])
                    if j!=0: # if its a constant
                        word = lines[i:(i+j)]
                        words += " " + word
        if j>0:
            i += j
        else:
            errors += 1
            i+=1
    print(words)

parse_automata()
