## Strings
##1. Haz un programa que lea una secuencia de caracteres acabada en punto y que escriba
#  cuántas letras ‘a’ contiene.
texto = input("Introduce texto (termina con punto): ")
contador = 0
for caracter in texto:
    if caracter == ".":
        break
    if caracter.lower() == "a":
        contador += 1
if contador > 0:
    print(f"el texto contiene {contador} letras <a>.")
else:
    print(f"el texto no contiene letra <a>")
##2. Haz un programa que encuentre todas las apariciones de una subcadena en una cadena dada.
texto = input("Introduce el texto completo: ")
subcadena = input("Introduce la subcadena a buscar: ")
posicion = 0
apariciones = []
while True:
    posicion = texto.find(subcadena, posicion)
    if posicion == -1:
        break
    apariciones.append(posicion)
    posicion += 1

print(f"La subcadena '{subcadena}' aparece en las posiciones: {apariciones}")
##3. Haz un programa que invierta una cadena dada.
texto = input("introduce unn textp")
texto_invertido = texto [::-1]
print(f"Texto invertido: {texto_invertido}")

##4. Haz un programa que divida una cadena en guiones.
texto = input("introduce unn textp")
print(texto.split("-"))
##5. Haz un programa que añada una nueva cadena en medio de una cadena dada.
texto = input("introduce unn textp")
insertar = input("introduce lo qeu deseas insertar en mitad del texto ")
mitad = len(texto) // 2
resultado = texto[:mitad] + insertar + texto [mitad:]
print(f"Resultado:{resultado}")

##6. Haz un programa que encuentre la última posición de una subcadena dada.
texto = input("introduce unn textp")
subcadena = input("Introduce la subcadena a buscar: ")
posicion = texto.rfind(subcadena)
if posicion != -1:
    print(f"Última aparición de '{subcadena}' en posición: {posicion}")
else:
    print(f"No se encontró '{subcadena}'")
##7. Haz un programa que elimine cadenas vacías de una lista de cadenas.
lista_cadenas = ["hola", "", "mundo", "", "python", ""]
lista_sin_vacias = []
for cadena in lista_cadenas:
    if cadena != "":
        lista_sin_vacias.append(cadena)
if lista_sin_vacias:
    print(f"Lista sin cadenas vacías: {lista_sin_vacias}")
else:
    print(f"no hay cadenas vacias por tanto: {lista_cadenas} queda exactamente igual.")
##8. Haz un programa que elimine símbolos especiales / signos de puntuación de una cadena.

texto = input("Introduce un texto con símbolos: ")
texto_limpio = "".join([c for c in texto if c.isalnum() or c.isspace()])
print(f"Texto sin símbolos: {texto_limpio}")

##9. Haz un programa que encuentre palabras con letras y números.
texto = input("Introduce un texto: ")
palabras = texto.split()
palabras_mixtas = []
for palabra in palabras:
    tiene_letra = False
    tiene_numero = False
    for caracter in palabra:
        if caracter.asalpha():
            tiene_letra = True
        if caracter in palabra:
            tiene_numero = True
    if tiene_letra and tiene_numero:
        palabras_mixtas.append(palabra)
print(f"Palabras con letras y números: {palabras_mixtas}")

##10. Haz un programa que sustituya cada símbolo especial por # en la siguiente cadena.
texto = input("Introduce un texto con símbolos: ")
texto_modificado = []
for caracter in texto:
    if caracter.isalnum() or caracter.isspace():
        texto_modificado.append(caracter)
    else:
        texto_modificado.append("#")
resultado = "".join(texto_modificado)
print(f"Texto con # en lugar de símbolos: {resultado}")
##listas
##1. Haz un programa que lea una lista dado su tamaño e imprima el segundo elemento (si existe).
n = int(input("tamañod e la lista: "))
lista = []
for i in range(n):
    elemento = int(input(f"elemento {i+1}: "))
    lista.append(elemento)
if len(lista) >= 2:
    print(f"el segundo elemento es: {lista[1]}")
else:
    print("la lista no tiene segundo elemento.")

##2. Haz un programa que lea una secuencia no vacía de enteros acabada en -1, y que escriba
#  cuántos son iguales al último.
lista = []
num = int(input("Introduce un número (-1 para terminar): "))
while num != -1:
    lista.append(num)
    num = int(input("Introduce un número (-1 para terminar): "))
ultimo = lista[-1]
contador = 0
for num in lista:
    if ultimo == num:
        contador +=1
print(f"Hay {contador} numeros iguales al ultimo numero: {ultimo}") 
##3. Haz un programa que lea secuencias de enteros acabada en -1, y que
#  escriba cada una invirtiendo la orden de sus elementos.
lista = []
num = int(input("Introduce un número (-1 para terminar): "))
while num != -1:
    lista.append(num)
    num = int(input("Introduce un número (-1 para terminar): "))
lista.reverse()
print(f"lista invertida: {lista}")
##4. Haz un programa que lea n palabras, y que escriba cada una invirtiendo la orden de sus caracteres.
n = int(input("¿Cuántas palabras?: "))
for i in range(n):
    palabra = input(f"Palabras: {i+1}: ")
    print(f"Invertida: {palabra[::-1]}")
##5. Haz un programa que lea una secuencia de números mientras sean positivos y que escriba la media.
lista = []
num = float(input("Introduce un número positivo (negativo o 0 para terminar): "))
while num > 0:
    lista.append(num)
    num = float(input("Introduce un número positivo (negativo o 0 para terminar): "))
if len(lista) > 0:
    media =sum(lista) / len(lista)
    print(f"La media de la lista es: {media}")
else:
    print("no se introdujeron numeros positivos.")

##6. Haz un programa que devuelva la concatenación de v1 y v2, v1 y v2 son dos listas de 
# tamaño n y m. Es decir, hay que devolver un vector que tenga los elementos de v1 seguidos
#  de los elementos de v2.
n = int(input("Tamaño de la primera lista: "))
v1 = []
for i in range(n):
    elemento = int(input(f"Elemento {i + 1} de v1: "))
    v1.append(elemento)

m = int(input("Tamaño de la segunda lista: "))
v2 = []
for i in range(m):
    elemento = int(input(f"Elemento {i + 1} de v2: "))
    v2.append(elemento)
resultado = v1 + v2
print(f"Lista concatenada: {resultado}.")
##7. Haz un programa que almacene en una lista los siguientes precios, 50, 75, 46, 22, 80, 65, 8, 
# y muestre por pantalla el menor y el mayor de los precios.
precios = [50, 75, 46, 22, 80, 65, 8]
menor = precios[0]
mayor = precios[0]
for precio in precios:
    if precio > mayor:
        mayor = precio
    if precio < menor:
        menor = precio
print(f"Precio menor: {menor}")
print(f"Precio mayor: {mayor}")

##8. Haz un programa que almacene las asignaturas de un curso 
# (por ejemplo Matemáticas, Física, Química, Historia y Lengua) 
# en una lista y la muestre por pantalla.
asignaturas = ["Matemáticas", "Física", "Química", "Historia", "Lengua"]
print("Asignaturas del curso:")
for asignatura in asignaturas:
    print(f"- {asignatura}")
##9. Haz un programa que almacene en una lista los números del 1 al 10 y los muestre por pantalla en orden inverso 
# separados por comas.
numeros = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
numeros.reverse()
resultado = ""
for i in range(len(numeros)):
    resultado += str(numeros[i])
    if i < len(numeros) -1:
        resultado += ", "
print(resultado)

##10. Haz un programa que concatene dos listas del mismo tamaño n alternando elementos de una lista y otra.
n = int(input("Tamaño de las listas: "))

lista1 = []
for i in range(n):
    elemento = int(input(f"Elemento {i+1} de lista1: "))
    lista1.append(elemento)
lista2 = []
for i in range(n):
    lemento = int(input(f"Elemento {i+1} de lista1: "))
    lista2.append(elemento)
resultado = []
for i in range(n):
    resultado.append(lista1[i])
    resultado.append(lista2[i])
print(f"Resultado: {resultado}")
      
##11. Haz un programa que itere ambas listas de tamaños n y m (siendo n y m números distintos )
# simultáneamente e imprima sus elementos.
n = int(input("Tamaño de la lista1: "))
m = int(input("Tamaño de la lista2: "))
lista1 = []
for i in range(n):
    elemento = int(input(f"Elemento {i+1} de la lista1"))
    lista1.append(elemento)
lista2 = []
for i in range(m):
    elemento =int(input(f"elemento {i+1} de la lista2"))
    lista2.append(elemento)
tamaño_minimo = min(len(lista1), len(lista2))
for i in range(tamaño_minimo):
    print(f"{lista1[i]} - {lista2[i]}")
##12. Haz un programa que añada un nuevo elemento 60 a la lista [10, 50, 40, 20, 30] después de
#  un elemento especificado por el usuario. Si el elemento introducido no está presente en la lista
#  debe mostrar el mensaje: 'Elemento no presente en la lista'.
lista = [10, 50, 40, 20, 30]
elemento_ref = int(input("¿Después de qué elemento quieres insertar 60?: "))
valor = 60
if elemento_ref in lista:
    posicion = lista.index(elemento_ref)
    lista.insert(posicion + 1, valor)
    print(lista)
else:
    print(f"no se encontro {elemento_ref} en la lista")


##13. Haz un programa que elimine todas las apariciones de un elemento específico introducido
#  por el usuario de la lista [10, 50, 40, 20, 60, 30].
numeros = [10, 50, 40, 20, 60, 30]
numero = int(input("¿que numero desea borrar de la lista?: "))
while numero in numeros:
    numeros.remove(numero)
print(numeros)
##Tuplas
##1. Haz una programa que invierta una tupla.
tupla = (1, 2, 3)
numeros = list(tupla)
numeros.reverse()
tupla_invertida = tuple(numeros)
print(tupla_invertida)
##2. Haz un programa que acceda al valor 15 de la tupla.
tupla = (10, 5, 15, 20, 8)
posicion = tupla.index(15)
print(f"El valor 15 está en la posición {posicion}")

##3. Haz un programa que declare una tupla con un solo elemento 10.
tupla = (10,)
print(tupla)
##4. Haz un programa que descomponga la tupla en 4 variables.
tupla = (10, 5, 15, 20, 8)
a, b, c, d, e = tupla
print(f"Variables desempaquetadas: {a}, {b}, {c}, {d}, {e}")

##5. Haz un programa que intercambie dos tuplas en Python.
tupla1 = (1, 2, 3)
tupla2 = (10, 20, 30)
tupla1, tupla2 = tupla2, tupla1
print(f"tupla1: {tupla1}")
print(f"tupla2: {tupla2}")
##6. Haz un programa que copie elementos específicos de una tupla a una nueva tupla.
tupla_original = (10, 5, 15, 20, 8, 30, 25)
tupla_nueva = []
for elemento in tupla_original:
    if elemento % 5 == 0:
        tupla_nueva.append(elemento)
tupla_nueva = tuple(tupla_nueva)
print(f"Nueva tupla: {tupla_nueva}")
##7. Haz un programa que modifique una tupla.
tupla_original = (10, 5, 15, 20, 8, 30, 25)
tupla_original = list(tupla_original)
tupla_original.append(10)
tupla_original.append(100)
tupla_modificada = tuple(tupla_original)
print(f"La tupla modificada es: {tupla_modificada}")
##8. Ordena una tupla de tuplas por el 2º elemento.
tupla_original = (10, 5, 15, 20, 8, 30, 25,13)
print(tupla_original)
print("\ntupla de tuplas")
tupla_de_tuplas = (
    (10, 5),
    (15, 20),
    (8, 30),
    (25, 13)
)
print(tupla_de_tuplas)
lista = list(tupla_de_tuplas)
lista.sort(key=lambda x: x[1])
tupla_ordenada = tuple(lista)
print(f"\nTupla ordenada: {tupla_ordenada}")
##9. Haz un programa que cuente el número de apariciones del elemento 50 de una tupla.
tupla = (10, 50, 15, 50, 20, 50, 30, 50)
elemento_buscar = 50
contador = tupla.count(elemento_buscar)
print(f"{elemento_buscar} aparece {contador} veces en la tupla.")

##10. Haz un programa que compruebe si todos los elementos de la tupla son iguales.
tupla = (5, 5, 5, 5, 5)
primer_elemento = tupla[0]
todos_iguales = True
for elemento in tupla:
    if elemento != primer_elemento:
        todos_iguales = False
        break
if todos_iguales:
    print("Todos los elementos son iguales")
else:
    print("Los elementos NO son todos iguales")

#### Diccionarios
##1. Haz un programa que convierta dos listas en un diccionario.
keys = ["nombre", "edad", "ciudad"]
values = ["Ana", 25, "Madrid"]
dicionario = dict(zip(keys, values))
print(dicionario)

##2. Haz un programa que fusione dos diccionarios de Python en uno solo.
dict1 = {"a": 1, "b": 2}
dict2 = {"c": 3, "d": 4}

resultado = dict1.copy() 
resultado.update(dict2)  

print(resultado)
##3. Haz un programa que imprima el valor de la clave 'history' del siguiente diccionario.
##3. Imprimir el valor de la clave 'history'
sample_dict = {
    "class": {
        "student": {
            "name": "Mike",
            "marks": {
                "physics": 70,
                "history": 80
            }
        }
    }
}
print(sample_dict["class"]["student"]["marks"]["history"])

##4. Haz un programa que inicialice el diccionario con valores por defecto.
claves = ['nombre', 'edad', 'ciudad', 'email']
diccionario = dict.fromkeys(claves, None)
print(diccionario)
claves = ['nombre', 'edad', 'ciudad', 'email']
diccionario = {clave: [] for clave in claves}
diccionario["nombre"] = "alvaro"
diccionario["edad"] = 30
diccionario["ciudad"] = "Madrid"
diccionario["email"] = None
##5. Haz un programa que cree un diccionario extrayendo las claves de un diccionario dado.
diccionario_original = {
    'nombre': 'Ana',
    'edad': 25,
    'ciudad': 'Madrid',
    'email': 'ana@example.com',
    'telefono': '123456789',
    'activo': True
}
diccionario_nuevo ={}
for clave in diccionario_original.keys():
    diccionario_nuevo[clave] = diccionario_original[clave]
print(f"El diccionario nuevo es: {diccionario_nuevo}")
##6. Haz un programa que elimine una lista de claves de un diccionario.
diccionario_original = {
    'nombre': 'Ana',
    'edad': 25,
    'ciudad': 'Madrid',
    'email': 'ana@example.com',
    'telefono': '123456789',
    'activo': True
}
claves_eliminar = {"telefono", "activo"}
for clave in claves_eliminar:
    diccionario_original.pop(clave)
print(diccionario_original) 
##7. Haz un programa que compruebe si un valor existe en un diccionario.
diccionario_original = {
    'nombre': 'Ana',
    'edad': 25,
    'ciudad': 'Madrid',
    'email': 'ana@example.com',
    'telefono': '123456789',
    'activo': True
}
n = input("Introduce el valor a buscar: ")
if n in diccionario_original.values():
    print(f"El valor '{n}' si existe en el diccionario.")
else:
    print(f"El valor '{n}' no existe en el diccionario.")
##8. Haz un programa que cambie el nombre de la clave de un diccionario.
diccionario_original = {
    'nombre': 'Ana',
    'edad': 25,
    'ciudad': 'Madrid',
    'email': 'ana@example.com',
    'telefono': '123456789',
    'activo': True
}
diccionario_original['años de vida'] = diccionario_original.pop('edad')
print(diccionario_original)
##9. Haz un programa que obtenga la clave de un valor mínimo del siguiente diccionario.

diccionario = {
    'manzanas': 45,
    'peras': 30,        
    'naranjas': 55,
    'plátanos': 40
}
valor_minimo = min(diccionario.values())

print(f"Eñl valor minimo del diccionario es {valor_minimo}")
clave_minima = min(diccionario, key=diccionario.get)
print(f"\n'{clave_minima}' tiene el valor mínimo: {valor_minimo}")
##10. Haz un programa que cambie el valor de una clave en un diccionario anidado.
usuarios = {
    'user001': {
        'nombre': 'Ana',
        'edad': 25,
        'ciudad': 'Madrid'
    },
    'user002': {
        'nombre': 'Juan',
        'edad': 30,
        'ciudad': 'Barcelona'
    }
}
usuarios['user001']['edad'] = 26

## Sets
##1. Haz un programa que añada una lista de elementos a un conjunto.
mi_set = set()
lista = [1, 2, 3, 4, 5]
for elemento in lista:
    mi_set.add(elemento)
print(mi_set)

##2. Haz un programa que devuelva un nuevo conjunto de elementos idénticos de dos conjuntos.
conjunto1 = {1, 2, 3, 4, 5}
conjunto2 = {4, 5, 6, 7, 8}
comunes =set()
for elemento in conjunto1:
    if elemento in conjunto2:
        comunes.add(elemento)
print(comunes)

##3. Haz un programa que obtenga sólo elementos únicos de dos conjuntos.

conjunto1 = {1, 2, 3, 4, 5}
conjunto2 = {4, 5, 6, 7, 8}
diferentes = set()
for elemento in conjunto1:
    if elemento not in conjunto2:
        diferentes.add(elemento)
for elemento in conjunto2:
    if elemento not in conjunto1:
        diferentes.add(elemento)
print(f"Elementos unicos: {diferentes}")

##4. Haz un programa que actualice el primer conjunto con elementos que 
# no existen en el segundo conjunto.

conjunto1 = {1, 2, 3, 4, 5}
conjunto2 = {4, 5, 6, 7, 8}
print(conjunto1, conjunto2)
conjunto1 -= conjunto2
print(conjunto1, conjunto2)
##5. Haz un programa que elimine elementos del conjunto a la vez.
conjunto = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10}
eliminar = {2, 4, 6, 8, 10}

conjunto -= eliminar

print(conjunto)

##6. Haz un programa que devuelva un conjunto de elementos presentes en el conjunto A o B, pero no en ambos.

conjunto_a = {1, 2, 3, 4, 5}
conjunto_b = {4, 5, 6, 7, 8}

resultado = conjunto_a ^ conjunto_b

print(f"Elementos en A o B, pero no en ambos: {resultado}")


##7. Haz un programa que compruebe si dos conjuntos tienen algún elemento en común. En caso afirmativo, mostrar los elementos comunes.

conjunto1 = {1, 2, 3, 4, 5}
conjunto2 = {4, 5, 6, 7, 8}

comunes = conjunto1 & conjunto2

if comunes:
    print(f"Sí hay elementos comunes: {comunes}")
else:
    print("No hay elementos comunes")


##8. Haz un programa que actualice el conjunto1 añadiendo elementos del conjunto2, excepto los elementos comunes.

conjunto1 = {1, 2, 3}
conjunto2 = {3, 4, 5}

print(f"conjunto1 antes: {conjunto1}")

nuevos = conjunto2 - conjunto1
conjunto1.update(nuevos)

print(f"conjunto1 después: {conjunto1}")


##9. Haz un programa que elimine elementos del conjunto1 que también están en el conjunto2.

conjunto1 = {1, 2, 3, 4, 5}
conjunto2 = {4, 5, 6, 7, 8}

print(f"conjunto1 antes: {conjunto1}")

conjunto1 -= conjunto2

print(f"conjunto1 después: {conjunto1}")
