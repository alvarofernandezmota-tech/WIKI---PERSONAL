## ejemplod e funciones sin parametros.
def saludas():
    pass
print("Bienvenido")
## funciones con parametro
def saludo_personalizado(nombre):
    print(f"hola {nombre}")
##name = input("dime tu nombre: ")
saludo_personalizado("pedro")
##usa del return y diferencia con el priint
def despedir(nombre):
    frase = (f"adios {nombre}")
    return frase
##funciones con mas de un parametro
def primer_valor_mayor(num1, num2):
    return num1 > num2
print(primer_valor_mayor(4,7))
def sumar(num1, num2):
    return num1 + num2
print(sumar(5, 6))
def restar(num1, num2):
    return num1 - num2
print(restar(num1 = 7, num2 =6))
##funcion con parametro por defecto
def multi(num1, num2=9):
    return num1 * num2
print(multi(5,))
##funciones conn numero arbitrario de parametros
def sumar(*nums):
    return sum(nums)
def imprimir_detalles_persona(**kwargs):
    for c, v in kwargs.items():
        print(f"{c}: {v}")
##anotaciones en funciones
def sumar(num1:int, num2:int):
    return num1 + num2

print('-----------------------------------------------------')

##ejercicios clase 

def contador_vocales(cadena:str):
    vocales = 0
    for x in cadena:
        if x in "aeiou":
            vocales+=1
    return vocales
print(contador_vocales("oso"))
listax = []
def add_item(elementos:list, elemento):
    elemento = int(input("introduce un elemento que deas agregar: "))
    listax.append(elemento)
    return listax
listaxx = [3,45,6456,474,567,4568,68678,679,649679,43679,69489,49,49]
def pares_y_impares(listaxx:list):
    ocnt = 0
    for i in listaxx:
        if i % 2 == 0:
            ocnt + 1
    return ocnt
print(pares_y_impares())