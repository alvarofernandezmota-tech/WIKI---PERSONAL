# 📝 EJERCICIOS DE REPASO - TEMA 5
# Estructuras de Datos: Strings, Listas, Tuplas, Diccionarios y Sets
# Escuela Musk - Módulo 2
# Fecha: 02 Febrero 2026

"""
ESTOS EJERCICIOS MEZCLAN TODOS LOS CONCEPTOS DEL TEMA 5:
- Strings
- Listas
- Tuplas
- Diccionarios
- Sets

Objetivo: Consolidar conocimientos antes de pasar a Funciones
"""

# =============================================================================
# EJERCICIO 1: LISTA + DICCIONARIO
# =============================================================================
# Dada una lista de nombres, crea un diccionario que cuente cuántas veces
# aparece cada nombre.
#
# Ejemplo:
# nombres = ["Ana", "Juan", "Ana", "Pedro", "Juan", "Ana"]
# Resultado: {'Ana': 3, 'Juan': 2, 'Pedro': 1}
nombres = ["Ana", "Juan", "Ana", "Pedro", "Juan", "Ana"]
conteo = {}
for nombre in nombres:
    if nombre in conteo:
        conteo[nombre] += 1
    else:
        conteo[nombre] = 1
print(conteo)

# =============================================================================
# EJERCICIO 2: STRING + LISTA
# =============================================================================
# Dada una frase, crea una lista con las palabras que tienen más de 5 letras.
#
# Ejemplo:
# frase = "Python es un lenguaje de programación muy potente"
# Resultado: ['Python', 'lenguaje', 'programación', 'potente']
frase = "Python es un lenguaje de programación muy potente"
palabra_cinco_letras = []
palabras = frase.split()
for palabra in palabras:
    if len(palabra) > 5:
        palabra_cinco_letras.append(palabra)
if palabra_cinco_letras:
    print(palabra_cinco_letras)
else:
    print("No hay palabras con más de 5 letras")

# =============================================================================
# EJERCICIO 3: SET + LISTA
# =============================================================================
# Dadas dos listas, encuentra:
# a) Elementos comunes
# b) Elementos únicos (que están solo en una lista)
# c) Todos los elementos sin duplicados
#
# Ejemplo:
# lista1 = [1, 2, 3, 4, 5]
# lista2 = [4, 5, 6, 7, 8]
lista1 = [1, 2, 3, 4, 5]
lista2 = [4, 5, 6, 7, 8]
elementos_comunes = []
elementos_unicos = []
elementos_sin_duplicados = []
for elemento in lista1:
    if elemento in lista2:
        elementos_comunes.append(elemento)
    if elemento not in lista2:
        elementos_unicos.append(elemento)
for elemento in lista2:
    if elemento not in lista1:
        elementos_unicos.append(elemento)
listas_juntas = lista1 + lista2
print(listas_juntas)
for elemento in listas_juntas:
    if elemento not in elementos_sin_duplicados:
        elementos_sin_duplicados.append(elemento)
print(elementos_sin_duplicados)
# =============================================================================
# EJERCICIO 4: DICCIONARIO + TUPLA
# =============================================================================
# Dado un diccionario de productos con sus precios, crea una tupla con
# el producto más caro y el más barato.
#
# Ejemplo:
productos = {'manzana': 1.5, 'pan': 0.8, 'leche': 1.2, 'huevos': 2.5}
mas_caro = max(productos, key=productos.get)
menos_caro = min(productos, key=productos.get)
print(f"{mas_caro}: {productos[mas_caro]}€, {menos_caro}: {productos[menos_caro]}€")





# =============================================================================
# EJERCICIO 5: LISTA + STRING
# =============================================================================
# Dada una lista de palabras, crea un string donde cada palabra esté separada
# por un guion y todas estén en mayúsculas.
#
# Ejemplo:
palabras = ["hola", "mundo", "python"]
palabras_mayusculas = []
for palabra in palabras:
    palabras_mayusculas.append(palabra.upper())
resultado = "-".join(palabras_mayusculas)
print(resultado)





# =============================================================================
# EJERCICIO 6: DICCIONARIO ANIDADO
# =============================================================================
# Dado un diccionario de estudiantes con sus notas, calcula la media de
# cada estudiante y crea un nuevo diccionario con las medias.
#
# Ejemplo:
estudiantes = {
    'Ana': [8, 7, 9],
    'Juan': [6, 7, 5],
    'Pedro': [9, 8, 10]
}
medias = {}
for nombre, notas in estudiantes.items():
    media = sum(notas) / len(notas)
    medias[nombre] = media
print(medias)




# =============================================================================
# EJERCICIO 7: SET + STRING
# =============================================================================
# Dada una frase, encuentra todas las letras únicas (sin duplicados) que
# aparecen en la frase. Ignora espacios y convierte todo a minúsculas.
#
# Ejemplo:
frase = "Hola Mundo"
frase_lower = frase.lower()
frase_remplace = frase_lower.replace(" ", "")
frase_set = set(frase_remplace)
print(frase_set)




# =============================================================================
# EJERCICIO 8: LISTA + TUPLA + DICCIONARIO
# =============================================================================
# Dada una lista de tuplas (nombre, edad), crea un diccionario donde la
# clave sea el nombre y el valor sea la edad. Luego, encuentra el nombre
# de la persona más joven.
#
# Ejemplo:
personas = [("Ana", 25), ("Juan", 30), ("Pedro", 22)]
Diccionario_personas = dict(personas)
mas_joven = min(Diccionario_personas, key=Diccionario_personas.get)
print(Diccionario_personas)
print(f"la persona mas joven es: {mas_joven}: {Diccionario_personas[mas_joven]} años")






# =============================================================================
# EJERCICIO 9: STRING + DICCIONARIO
# =============================================================================
# Dada una frase, cuenta cuántas vocales tiene cada tipo (a, e, i, o, u).
# No diferencies entre mayúsculas y minúsculas.
#
# Ejemplo:
# frase = "Hola mundo de Python"
# Resultado: {'a': 1, 'e': 1, 'i': 0, 'o': 4, 'u': 2}
frase = "Hola mundo de Python"
vocales = ["a", "e", "i", "o", "u"]
Diccionario_vocales ={}
for vocal in vocales:
    Diccionario_vocales[vocal] = 0
frase_lower = frase.lower()
for letra in frase_lower:
    if letra in Diccionario_vocales:
        Diccionario_vocales[letra] += 1
print(Diccionario_vocales)



# =============================================================================
# EJERCICIO 10: LISTA + SET
# =============================================================================
# Dada una lista con números duplicados, elimina los duplicados manteniendo
# el orden original de aparición.
#
# Ejemplo:
# numeros = [1, 2, 3, 2, 4, 1, 5, 3]
# Resultado: [1, 2, 3, 4, 5]
#
# Pista: Usa un set para rastrear qué has visto, pero construye una nueva lista

numeros = [1, 2, 3, 2, 4, 1, 5, 3]
vistos = set()        # ← Para rastrear qué has visto
resultado = []   
for numero in numeros:
    if numero not in vistos:
        resultado.append(numero)
        vistos.add(numero)
print(resultado)


# =============================================================================
# EJERCICIO 11: DICCIONARIO + LISTA
# =============================================================================
# Dado un diccionario que representa un inventario de una tienda,
# crea una lista con los productos que tienen menos de 10 unidades.
#
# Ejemplo:
# inventario = {'manzanas': 50, 'peras': 8, 'naranjas': 30, 'plátanos': 5}
# Resultado: ['peras', 'plátanos']
inventario = {'manzanas': 50, 'peras': 8, 'naranjas': 30, 'plátanos': 5} #{PRODUCTO: UNIDADES}
menores_diez = []
for producto, unidades in inventario.items():
    if unidades < 10:
        menores_diez.append(producto)
print(f"Los productos con menos de 10 unidades son : {menores_diez}")



# =============================================================================
# EJERCICIO 12: STRING + LISTA + SET
# =============================================================================
# Dada una frase, encuentra todas las palabras que aparecen más de una vez.
#
# Ejemplo:
# frase = "hola mundo hola python mundo es genial"
# Resultado: {'hola', 'mundo'}
frase = "hola mundo hola python mundo es genial"
palabras = frase.split()
conteo = {}
for palabra in palabras:
    if palabra in conteo:
        conteo[palabra] += 1
    else:
        conteo[palabra] = 1
repetidas = set()
for palabra, veces in conteo.items():
    if veces > 1:
        repetidas.add(palabra)
print(repetidas)

## ========================================================
## ===============================================================

frase = "hola mundo hola python mundo es genial"
palabras = frase.split()
conteo = {}
for palabra in palabras:
    if palabra in conteo:
        conteo[palabra] += 1
    else:
        conteo[palabra] = 1
for palabra, veces in conteo.items():
    if veces > 1:
        print(f"{palabra}: {veces}")



# =============================================================================
# EJERCICIO 13: TUPLA + DICCIONARIO
# =============================================================================
# Dada una tupla de temperaturas (en Celsius) por día de la semana,
# crea un diccionario donde la clave sea el día y el valor la temperatura.
# Luego encuentra el día más caluroso.
#
# Ejemplo:
# temperaturas = (15, 18, 20, 17, 19, 22, 16)
# dias = ("Lunes", "Martes", "Miércoles", "Jueves", "Viernes", "Sábado", "Domingo")
# Resultado diccionario: {'Lunes': 15, 'Martes': 18, ...}
# Día más caluroso: 'Sábado'
temperaturas = (15, 18, 20, 17, 19, 22, 16)
dias = ("Lunes", "Martes", "Miércoles", "Jueves", "Viernes", "Sábado", "Domingo")
temperaturas_dias = {}
for i in range(len((dias))):
    temperaturas_dias[i] = temperaturas[i]
print(temperaturas_dias)
dia_mas = max()




# =============================================================================
# EJERCICIO 14: LISTA + DICCIONARIO + SET (COMBINADO)
# =============================================================================
# Dadas dos listas de estudiantes con sus asignaturas favoritas:
# - Crea un diccionario con cada estudiante y sus asignaturas
# - Encuentra las asignaturas que son favoritas de al menos 2 estudiantes
#
# Ejemplo:
# estudiantes = ["Ana", "Juan", "Pedro", "María"]
# asignaturas = [["Matemáticas", "Física"], ["Matemáticas", "Historia"],
#                ["Física", "Química"], ["Matemáticas", "Física"]]
#
# Diccionario: {'Ana': ['Matemáticas', 'Física'], ...}
# Asignaturas populares: {'Matemáticas', 'Física'}
estudiantes = ["Ana", "Juan", "Pedro", "María"]
asignaturas = [["Matemáticas", "Física"], ["Matemáticas", "Historia"],
               ["Física", "Química"], ["Matemáticas", "Física"]]
estudiantes_asig_fav = {}
for i in range(len(estudiantes)):
    estudiantes_asig_fav[estudiantes[i]] = asignaturas[i]
print(estudiantes_asig_fav)




# =============================================================================
# EJERCICIO 15: TODO COMBINADO (DESAFÍO)
# =============================================================================
# Tienes una lista de frases. Para cada frase:
# 1. Cuenta cuántas palabras tiene
# 2. Encuentra la palabra más larga
# 3. Crea un diccionario con esta información
#
# Ejemplo:
# frases = [
#     "Python es genial",
#     "Me encanta programar en Python",
#     "Los ejercicios ayudan a aprender"
# ]
#
# Resultado: {
#     "Python es genial": {"palabras": 3, "mas_larga": "Python"},
#     "Me encanta programar en Python": {"palabras": 5, "mas_larga": "programar"},
#     "Los ejercicios ayudan a aprender": {"palabras": 5, "mas_larga": "ejercicios"}
# }
frases = [
    "Python es genial",
    "Me encanta programar en Python",
    "Los ejercicios ayudan a aprender"
]
resumen = {}
for frase in frases:
    palabras = frase.split()
    num_palabras =len(palabras)
    palabra_mas_larga = max(palabras, key=len)
    resumen[frase] = {
        "palabras": num_palabras,
    "palabra mas larga": palabra_mas_larga}

print(resumen)
    



# =============================================================================
# 🎯 OBJETIVOS DE ESTOS EJERCICIOS:
# =============================================================================
# ✅ Practicar conversiones entre tipos de datos
# ✅ Combinar múltiples estructuras de datos
# ✅ Usar métodos nativos de Python
# ✅ Aplicar lógica de programación
# ✅ Prepararse para trabajar con funciones
#
# 💡 CONSEJO:
# Intenta resolver cada ejercicio sin mirar las soluciones.
# Si te atascas, revisa la chuleta de Python en recursos/chuleta_python.md
# =============================================================================
