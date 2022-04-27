#T1
#Ericka Cespedes
#2017239557

print('''
    El input de la función principal "expresion()" debe ser una hilera.
    Se asume que cada token es un solo caracter y que la hilera no contiene espacios.

    E -> E + F | E - F | F
    F -> F * P | F / P | P
    P -> T ^ P | T
    T -> (E) | N
    N -> 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7| 8 | 9
''')

global line, index

index = -1

num = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]

import operator
operadores={'+':operator.add, '-':operator.sub, '*':operator.mul, '/':operator.truediv, '^':operator.pow}
#nodo = lambda num1, operador, num2: operadores[operador](float(num1),float(num2))

def nodo(num1, operador, num2):
    return operadores[operador](float(num1),float(num2))

def getToken(line):
    global index
    index += 1
    if (index < len(line)):
        return line[index]
    else:
        return None

def retToken(tok):
    global index
    index -= 1
    tok = None

def termino(line):
    tok = getToken(line)
    if (tok in num):
        return tok
    if (tok == '('):
        term = expresion(line)
        assert(getToken(line) == ')')
        return term
    retToken(tok)

def potencia(line):
    pot = termino(line)
    tok = getToken(line)
    if (tok == '^'):
        return nodo(pot, '^', potencia(line))
    retToken(tok)
    return pot
    
def factor(line):
    fact = potencia(line)
    tok = getToken(line)
    while ((tok == '*') or (tok == '/')):
        otro = potencia(line)
        fact = nodo(fact, tok, otro)
        tok = getToken(line)
    retToken(tok)
    return fact

# Funcion principal
def expresion(line):
    exp = factor(line)
    tok = getToken(line)
    while ((tok ==  '+') or (tok == '-')):
        otro = factor(line)
        exp = nodo(exp, tok, otro)
        tok = getToken(line)
    retToken(tok)
    return exp

#Main
def main():
    while True:
        global line
        line = input("\nPara salir escriba 'exit' \nIntroduzca la expresion: ")
        if (line == 'exit'):
            return None
        
        try:
            result = expresion(line)
            print(result)
            
        except:
            raise Exception("Error: La expresion ingresada es invalida.")

main()
