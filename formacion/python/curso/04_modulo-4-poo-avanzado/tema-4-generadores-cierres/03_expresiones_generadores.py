"""Tema 4.3: Expresiones con Generadores

Las expresiones generadoras son como list comprehensions
pero con paréntesis en lugar de corchetes — no cargan
todo en memoria, generan los valores al vuelo.
"""

import sys


# =============================================================================
# EJEMPLO 1: List comprehension vs Expresión generadora
# =============================================================================

print("=" * 60)
print("EJEMPLO 1: List comprehension vs Expresión generadora")
print("=" * 60)

n = 1_000_000

# List comprehension — crea la lista completa en memoria
lista = [i ** 2 for i in range(n)]

# Expresión generadora — genera al vuelo
generador = (i ** 2 for i in range(n))

print(f"\nList comprehension:    {sys.getsizeof(lista):>12} bytes")
print(f"Expresión generadora:  {sys.getsizeof(generador):>12} bytes")
print(f"Tipo lista:     {type(lista)}")
print(f"Tipo generador: {type(generador)}")


# =============================================================================
# EJEMPLO 2: Uso con sum(), max(), min()
# =============================================================================

print("\n" + "=" * 60)
print("EJEMPLO 2: sum(), max(), min() con generadores")
print("=" * 60)

numeros = range(1, 11)

# sum() acepta directamente una expresión generadora
total    = sum(x ** 2 for x in numeros)
maximo   = max(x ** 2 for x in numeros)
minimo   = min(x ** 2 for x in numeros)

print(f"\nCuadrados del 1 al 10:")
print(f"  Suma:    {total}")
print(f"  Máximo:  {maximo}")
print(f"  Mínimo:  {minimo}")

# Sin crear ninguna lista intermedia 🚀
print("  → Sin crear ninguna lista intermedia!")


# =============================================================================
# EJEMPLO 3: Filtrado con expresiones generadoras
# =============================================================================

print("\n" + "=" * 60)
print("EJEMPLO 3: Filtrado")
print("=" * 60)

nombres = ["Ana", "Bernardo", "Carlos", "Diana", "Elena", "Francisco"]

# Solo nombres con más de 4 letras
largos = (nombre for nombre in nombres if len(nombre) > 4)
print("\nNombres con más de 4 letras:")
for nombre in largos:
    print(f"  {nombre}")

# Transformar y filtrar a la vez
numeros = range(1, 21)
pares_cuadrado = (x**2 for x in numeros if x % 2 == 0)
print("\nCuadrado de pares del 1 al 20:")
print(list(pares_cuadrado))


# =============================================================================
# EJEMPLO 4: Encadenar generadores (pipeline)
# =============================================================================

print("\n" + "=" * 60)
print("EJEMPLO 4: Pipeline de generadores")
print("=" * 60)

def leer_datos():
    """Simula lectura de datos."""
    datos = [1, -2, 3, -4, 5, -6, 7, -8, 9, -10]
    for d in datos:
        yield d

def solo_positivos(datos):
    """Filtra solo positivos."""
    for d in datos:
        if d > 0:
            yield d

def al_cuadrado(datos):
    """Eleva al cuadrado."""
    for d in datos:
        yield d ** 2

# Pipeline: leer → filtrar → transformar
pipeline = al_cuadrado(solo_positivos(leer_datos()))

print("\nPipeline: leer → solo positivos → al cuadrado")
print(list(pipeline))
print("→ Todo procesado sin crear listas intermedias")


# =============================================================================
# CUÁNDO USAR CADA UNO
# =============================================================================

print("\n" + "=" * 60)
print("CUÁNDO USAR CADA UNO")
print("=" * 60)
print("""
✅ Usa LIST COMPREHENSION cuando:
   • Necesitas acceder a los elementos varias veces
   • El tamaño de datos es pequeño/moderado
   • Necesitas indexar: lista[0], lista[-1]

✅ Usa EXPRESIÓN GENERADORA cuando:
   • Solo necesitas iterar una vez
   • Los datos son grandes o infinitos
   • Quieres pasar a sum(), max(), min(), etc.
   • Quieres encadenar operaciones (pipeline)
""")

print("✅ Expresiones generadoras dominadas")
print("=" * 60)
