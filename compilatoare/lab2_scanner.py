import re
from bintree import *
from automata import *

# reading atom file
filepath = "utils/p1.cpp"
keywordspath = "utils/keys.txt"
keywords = open(keywordspath, "r").read()
keywords = keywords.split()

atom_code = {}
pif_table = []
id_table = binTree(300,100)
const_table = binTree(300,500)

print("\nATOMS TABLE INPUT")
for i, x in enumerate(keywords):
    atom_code[x] = i
    print(x, i)

def parse_automata():
    constants_automata = Automata("utils/constants_automata.txt")
    identifiers_automata = Automata("utils/identifiers_automata.txt")
    keywords_automata = Automata("utils/keywords_automata.txt")

    lines = open(filepath, "r").read()
    print("\nPROGRAM:")
    print(lines)

    i = 0
    row = 1
    errors = 0
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
                add_to_atoms(word)
            else:
                j = identifiers_automata.check(lines[i:])
                if j!=0: # if its a word
                    word = lines[i:(i+j)]
                    if word in keywords: # if its a key word
                        add_to_atoms(word)
                    else: # if its an identifier
                        add_to_identifiers(word)
                else:
                    j = constants_automata.check(lines[i:])
                    if j!=0: # if its a constant
                        word = lines[i:(i+j)]
                        add_to_constants(word)
        if j>0:
            i += j
        else:
            print("ERROR in row", row, "at \""+lines[i]+"\"")
            errors += 1
            i+=1

    if errors:
        print("Program parse FAILED:", errors, "errors")
    else:
        print("Program parse PASSED")

def add_to_atoms(x):
    # print("ky ",x)
    pif_table.append([atom_code[x],"-"])

def add_to_constants(x):
    # print("co ",x)
    uid = const_table.find(x)
    if uid:
        pif_table.append([atom_code["CONST"],uid])
    else:
        const_table.add(x)
        pif_table.append([atom_code["CONST"],const_table.n])

def add_to_identifiers(x):
    # print("id ",x)
    uid = id_table.find(x)
    if uid:
        pif_table.append([atom_code["ID"],uid])
    else:
        id_table.add(x)
        pif_table.append([atom_code["ID"],id_table.n])

def print_all():
    print("\nPROGRAM INTERNAL FORM (PIF)")
    for x in pif_table:
        print(x)
    print("")
    print("SYMBOL TABLE (ST): IDENTIFIERS")
    id_table.print_data()
    print("SYMBOL TABLE (ST): CONSTANTS")
    const_table.print_data()

parse_automata()
print_all()
