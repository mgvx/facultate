import re
from bintree import *

# reading atom file
filepath = "utils/p1.cpp"
keywordspath = "utils/keys.txt"
keywords = open(keywordspath, "r").read()
keywords = keywords.split()

atom_code = {}
pif_table = []
id_table = binTree(100,100)
const_table = binTree(100,500)

print("\nATOMS TABLE INPUT")
for i, x in enumerate(keywords):
    atom_code[x] = i
    print(x, i)


def get_tokenized():
    # cleans up text and tokenizes it
    lines = open(filepath, "r").read()
    print("\nPROGRAM:")
    print(lines)
    lines = lines.replace("\n"," \n")
    # lines = lines.replace("\r"," \n")
    for x in keywords:
        lines = lines.replace(x," " + x + " ")
    lines = lines.replace("<  <","<<")
    lines = lines.replace(">  >",">>")
    lines = lines.replace("<  =","<=")
    lines = lines.replace(">  =",">=")
    lines = lines.replace("! =","!=")
    lines = lines.split(" ")
    lines = list(filter(lambda x: x != '', lines))
    # print(lines)
    return lines

def parse(tokens):
    global pif_table, id_table, const_table, id_code, const_code
    errors = 0
    line = 1 # current line

    for x in tokens: # parse text token by token
        if x == '\n':
            line += 1
        elif x in keywords:
            pif_table.append([atom_code[x],"-"]) # add atom to PIF
        else:
            # verify if constant
            if re.match('^[0-9,.]{1,8}$', x):
                const_table.add(x)
                id = const_table.find(x)
                if id:
                    pif_table.append([atom_code["CONST"],id])
                else:
                    pif_table.append([atom_code["CONST"],const_table.n])
            # verify if identifier
            elif re.match('^[a-z,A-Z][a-z,A-Z,0-9]{0,7}$', x):
                id_table.add(x)
                id = id_table.find(x)
                if id:
                    pif_table.append([atom_code["ID"],id])
                else:
                    pif_table.append([atom_code["ID"],id_table.n])
            # error
            else:
                print("ERROR!!! at line:", line, "invalid symbol:", x)
                errors += 1
    if errors:
        print("Program parse FAILED:", errors, "errors")
    else:
        print("Program parse PASSED")

def print_all():
    print("\nPROGRAM INTERNAL FORM (PIF)")
    for x in pif_table:
        print(x)
    print("")
    print("SYMBOL TABLE (ST): IDENTIFIERS")
    id_table.print_data()
    print("SYMBOL TABLE (ST): CONSTANTS")
    const_table.print_data()

tokenized = get_tokenized()
parse(tokenized)
print_all()
