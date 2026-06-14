"""Ejercicios Prácticos - Tema 4: Generadores y Cierres

Ejercicios progresivos para consolidar:
- yield y generadores básicos
- Diferencias generador vs función normal
- Expresiones generadoras
- Generadores infinitos
- Generadores con POO
"""

import sys

print("📚 MÓDULO 4 - TEMA 4: GENERADORES Y CIERRES - EJERCICIOS")
print("=" * 70)
print()


# =============================================================================
# EJERCICIO 1: Primer generador con yield
# =============================================================================

print("=" * 70)
print("📝 EJERCICIO 1: Primer generador con yield")
print("=" * 70)

def contar_hasta(n):
    """Generador que cuenta desde 1 hasta n."""
    for i in range(1, n + 1):
        yield i

gen = contar_hasta(5)
print(f"\nObjeto generador: {gen}")
print("Valores con next():")
for _ in range(5):
    print(f"  {next(gen)}", end=" ")
print()
print("Iterando con for:")
for val in contar_hasta(5):
    print(f"  {val}", end=" ")
print()

print("\n" + "=" * 70)
print("✅ EJERCICIO 1 COMPLETADO")
print("=" * 70)


# =============================================================================
# EJERCICIO 2: Generador vs Función normal - Memoria
# =============================================================================

print("\n\n" + "=" * 70)
print("📝 EJERCICIO 2: Generador vs Función - Memoria")
print("=" * 70)

def numeros_lista(n):
    return [i for i in range(n)]

def numeros_gen(n):
    for i in range(n):
        yield i

n = 500_000
lista = numeros_lista(n)
generador = numeros_gen(n)

print(f"\n💾 Lista ({n:,} elementos):     {sys.getsizeof(lista):>10,} bytes")
print(f"⚡ Generador ({n:,} elementos): {sys.getsizeof(generador):>10,} bytes")
print(f"
🚀 El generador ocupa {sys.getsizeof(lista)//sys.getsizeof(generador)}x MENOS memoria")

print("\n" + "=" * 70)
print("✅ EJERCICIO 2 COMPLETADO")
print("=" * 70)


# =============================================================================
# EJERCICIO 3: Expresión generadora
# =============================================================================

print("\n\n" + "=" * 70)
print("📝 EJERCICIO 3: Expresión generadora")
print("=" * 70)

numeros = range(1, 11)

# Expresión generadora (paréntesis)
cuadrados_gen = (x ** 2 for x in numeros)

# List comprehension (corchetes)
cuadrados_lista = [x ** 2 for x in numeros]

print(f"\nTipo expresión generadora: {type(cuadrados_gen)}")
print(f"Tipo list comprehension:   {type(cuadrados_lista)}")
print(f"\nMemoria generadora: {sys.getsizeof(cuadrados_gen)} bytes")
print(f"Memoria lista:      {sys.getsizeof(cuadrados_lista)} bytes")

print("\nCuadrados (del 1 al 10):")
print(list(x ** 2 for x in range(1, 11)))

print("\nSuma de cuadrados (sin lista intermedia):")
print(f"  sum(x**2 for x in range(1,11)) = {sum(x**2 for x in range(1, 11))}")

print("\n" + "=" * 70)
print("✅ EJERCICIO 3 COMPLETADO")
print("=" * 70)


# =============================================================================
# EJERCICIO 4: Generador infinito con control
# =============================================================================

print("\n\n" + "=" * 70)
print("📝 EJERCICIO 4: Generador infinito")
print("=" * 70)

def multiplos_de(n):
    """Genera múltiplos de n infinitamente."""
    i = n
    while True:
        yield i
        i += n

print("\nPrimeros 8 múltiplos de 3:")
gen = multiplos_de(3)
for _ in range(8):
    print(f"  {next(gen)}", end=" ")
print()

print("\nPrimeros 6 múltiplos de 7:")
gen = multiplos_de(7)
for _ in range(6):
    print(f"  {next(gen)}", end=" ")
print()

print("\n" + "=" * 70)
print("✅ EJERCICIO 4 COMPLETADO")
print("=" * 70)


# =============================================================================
# EJERCICIO 5: Pipeline de generadores
# =============================================================================

print("\n\n" + "=" * 70)
print("📝 EJERCICIO 5: Pipeline de generadores")
print("=" * 70)

def generar_numeros(limite):
    for i in range(1, limite + 1):
        yield i

def filtrar_impares(numeros):
    for n in numeros:
        if n % 2 != 0:
            yield n

def elevar_al_cubo(numeros):
    for n in numeros:
        yield n ** 3

# Pipeline: generar → filtrar impares → elevar al cubo
pipeline = elevar_al_cubo(filtrar_impares(generar_numeros(10)))

print("\nPipeline: 1..10 → solo impares → al cubo")
print(list(pipeline))
print("→ Sin ninguna lista intermedia")

print("\n" + "=" * 70)
print("✅ EJERCICIO 5 COMPLETADO")
print("=" * 70)


# =============================================================================
# EJERCICIO 6: Generador en clase
# =============================================================================

print("\n\n" + "=" * 70)
print("📝 EJERCICIO 6: Generador en clase")
print("=" * 70)


class BibliotecaLibros:
    """Biblioteca con generadores para buscar libros."""

    def __init__(self):
        self._libros = []

    def agregar(self, titulo, autor, paginas, disponible=True):
        self._libros.append({
            "titulo": titulo,
            "autor": autor,
            "paginas": paginas,
            "disponible": disponible
        })

    def disponibles(self):
        """Genera solo libros disponibles."""
        for libro in self._libros:
            if libro["disponible"]:
                yield libro

    def por_autor(self, autor):
        """Genera libros de un autor."""
        for libro in self._libros:
            if libro["autor"].lower() == autor.lower():
                yield libro

    def cortos(self, max_paginas):
        """Genera libros con menos de X páginas."""
        for libro in self._libros:
            if libro["paginas"] <= max_paginas:
                yield libro

    def total_paginas(self):
        """Expresión generadora para suma."""
        return sum(l["paginas"] for l in self._libros)


bib = BibliotecaLibros()
bib.agregar("Clean Code", "Robert Martin", 431)
bib.agregar("The Pragmatic Programmer", "David Thomas", 352)
bib.agregar("Python Crash Course", "Eric Matthes", 544, disponible=False)
bib.agregar("Fluent Python", "Luciano Ramalho", 790)
bib.agregar("Automate Boring Stuff", "Al Sweigart", 504, disponible=False)

print("\n📚 Libros disponibles:")
for libro in bib.disponibles():
    print(f"  {libro['titulo']} ({libro['paginas']}p)")

print("\n📚 Libros cortos (≤400 págs):")
for libro in bib.cortos(400):
    print(f"  {libro['titulo']}")

print(f"\n📊 Total páginas biblioteca: {bib.total_paginas()}")

print("\n" + "=" * 70)
print("✅ EJERCICIO 6 COMPLETADO")
print("=" * 70)


# =============================================================================
# RESUMEN FINAL
# =============================================================================

print("\n\n" + "=" * 70)
print("🎉 TEMA 4 GENERADORES - 6/6 EJERCICIOS COMPLETADOS")
print("=" * 70)
print()
print("📚 Todos los conceptos dominados:")
print("   ✅ EJ1 - yield y primer generador")
print("   ✅ EJ2 - Generador vs función: memoria")
print("   ✅ EJ3 - Expresiones generadoras")
print("   ✅ EJ4 - Generador infinito")
print("   ✅ EJ5 - Pipeline de generadores")
print("   ✅ EJ6 - Generadores en clase POO")
print()
print("🚀 Próximo: Tema 5 - Excepciones y Errores")
print("=" * 70)
