"""Tema 4.1: Generadores en Python

Un generador es una función que usa 'yield' en lugar de 'return'.
No devuelve todos los valores a la vez — los genera uno a uno,
lo que los hace muy eficientes en memoria.
"""


# =============================================================================
# CONCEPTO: yield vs return
# =============================================================================

print("=" * 60)
print("CONCEPTO: yield vs return")
print("=" * 60)

# Función normal — devuelve toda la lista en memoria
def cuadrados_lista(n):
    resultado = []
    for i in range(n):
        resultado.append(i ** 2)
    return resultado

# Generador — devuelve un valor cada vez que se llama
def cuadrados_generador(n):
    for i in range(n):
        yield i ** 2

print("\nFunción normal (lista completa en memoria):")
print(cuadrados_lista(5))

print("\nGenerador (objeto generador):")
gen = cuadrados_generador(5)
print(gen)  # <generator object ...>
print("Valores uno a uno con next():")
print(next(gen))  # 0
print(next(gen))  # 1
print(next(gen))  # 4

print("\nIterando con for:")
for val in cuadrados_generador(5):
    print(f"  {val}", end="")
print()


# =============================================================================
# EJEMPLO 1: Generador de números pares
# =============================================================================

print("\n" + "=" * 60)
print("EJEMPLO 1: Generador de pares")
print("=" * 60)

def pares_hasta(n):
    """Genera números pares desde 0 hasta n."""
    for i in range(0, n + 1, 2):
        yield i

print("\nPares hasta 10:")
for par in pares_hasta(10):
    print(f"  {par}", end=" ")
print()


# =============================================================================
# EJEMPLO 2: Generador infinito
# =============================================================================

print("\n" + "=" * 60)
print("EJEMPLO 2: Generador infinito")
print("=" * 60)

def contador_infinito(inicio=0):
    """Genera números desde inicio hasta el infinito."""
    n = inicio
    while True:
        yield n
        n += 1

contador = contador_infinito(1)
print("\nPrimeros 5 valores del contador infinito:")
for _ in range(5):
    print(f"  {next(contador)}", end=" ")
print()


# =============================================================================
# EJEMPLO 3: Generador con estado
# =============================================================================

print("\n" + "=" * 60)
print("EJEMPLO 3: Fibonacci con generador")
print("=" * 60)

def fibonacci():
    """Genera la secuencia de Fibonacci infinitamente."""
    a, b = 0, 1
    while True:
        yield a
        a, b = b, a + b

fib = fibonacci()
print("\nPrimeros 10 números de Fibonacci:")
for _ in range(10):
    print(f"  {next(fib)}", end=" ")
print()


# =============================================================================
# EJEMPLO 4: StopIteration
# =============================================================================

print("\n" + "=" * 60)
print("EJEMPLO 4: StopIteration")
print("=" * 60)

def tres_valores():
    yield 1
    yield 2
    yield 3

gen = tres_valores()
print()
try:
    print(f"  next(): {next(gen)}")
    print(f"  next(): {next(gen)}")
    print(f"  next(): {next(gen)}")
    print(f"  next(): {next(gen)}")  # ← lanza StopIteration
except StopIteration:
    print("  ⚠️  StopIteration: el generador se agotó")


print("\n" + "=" * 60)
print("✅ Generadores con yield dominados")
print("=" * 60)
