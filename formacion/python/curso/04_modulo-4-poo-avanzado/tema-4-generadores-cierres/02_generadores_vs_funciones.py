"""Tema 4.2: Diferencias entre Generadores y Funciones Normales

Comparación práctica de rendimiento y comportamiento
entre funciones normales y generadores.
"""

import sys


# =============================================================================
# DIFERENCIA 1: Memoria
# =============================================================================

print("=" * 60)
print("DIFERENCIA 1: Memoria")
print("=" * 60)

def lista_numeros(n):
    """Función normal — carga TODO en memoria."""
    return [i for i in range(n)]

def gen_numeros(n):
    """Generador — genera de uno en uno."""
    for i in range(n):
        yield i

n = 100_000

lista = lista_numeros(n)
generador = gen_numeros(n)

print(f"\nTamaño lista ({n} elementos):     {sys.getsizeof(lista):>10} bytes")
print(f"Tamaño generador ({n} elementos): {sys.getsizeof(generador):>10} bytes")
print(f"\nEl generador ocupa {sys.getsizeof(lista) // sys.getsizeof(generador)}x MENOS memoria 🚀")


# =============================================================================
# DIFERENCIA 2: Ejecución lazy (perezosa)
# =============================================================================

print("\n" + "=" * 60)
print("DIFERENCIA 2: Ejecución Lazy")
print("=" * 60)

def funcion_normal():
    print("  [normal] Ejecutando TODO...")
    resultado = []
    for i in range(3):
        print(f"  [normal] Calculando {i}")
        resultado.append(i * 2)
    print("  [normal] ¡Listo!")
    return resultado

def generador_lazy():
    print("  [gen] Creando generador...")
    for i in range(3):
        print(f"  [gen] Calculando {i}")
        yield i * 2

print("\n▶️  Función normal (ejecuta todo al llamar):")
resultado = funcion_normal()

print("\n▶️  Generador (NO ejecuta nada hasta pedir):")
gen = generador_lazy()
print("  [main] Generador creado, aún no ejecuta nada")
print("  [main] Pidiendo primer valor...")
print(f"  [main] Obtenido: {next(gen)}")
print("  [main] Pidiendo segundo valor...")
print(f"  [main] Obtenido: {next(gen)}")


# =============================================================================
# DIFERENCIA 3: Estado interno
# =============================================================================

print("\n" + "=" * 60)
print("DIFERENCIA 3: Estado interno")
print("=" * 60)

def funcion_sin_estado(n):
    """Siempre empieza desde cero."""
    return list(range(n))

def generador_con_estado(n):
    """Recuerda dónde se quedó."""
    for i in range(n):
        yield i

print("\nFunción normal (sin estado):")
print(f"  llamada 1: {funcion_sin_estado(3)}")
print(f"  llamada 2: {funcion_sin_estado(3)}  ← siempre igual")

print("\nGenerador (con estado):")
gen = generador_con_estado(5)
print(f"  next(): {next(gen)}  ← recuerda posición")
print(f"  next(): {next(gen)}")
print(f"  next(): {next(gen)}  ← sigue desde donde lo dejó")


# =============================================================================
# TABLA RESUMEN
# =============================================================================

print("\n" + "=" * 60)
print("TABLA RESUMEN")
print("=" * 60)
print("""
┌──────────────────┬────────────────────┬────────────────────┐
│ Característica   │ Función normal      │ Generador           │
├──────────────────┼────────────────────┼────────────────────┤
│ Palabra clave   │ return              │ yield               │
│ Memoria         │ Toda a la vez       │ Un valor a la vez   │
│ Ejecución       │ Inmediata           │ Lazy (perezosa)     │
│ Estado          │ Sin estado          │ Recuerda posición  │
│ Infinitos       │ ❌ Imposible         │ ✅ Posible           │
│ Reutilizable    │ ✅ Sí                │ ❌ Una sola vez      │
└──────────────────┴────────────────────┴────────────────────┘
""")

print("✅ Diferencias generador vs función dominadas")
print("=" * 60)
