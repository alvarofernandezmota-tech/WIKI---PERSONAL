"""Tema 4: Ejemplos Prácticos - Generadores y Cierres con POO

Ejemplos reales que combinan generadores con clases Python.
"""

import sys


# =============================================================================
# EJEMPLO 1: Clase con __iter__ y __next__ (iterador manual)
# =============================================================================

print("=" * 60)
print("EJEMPLO 1: Clase Iterador manual")
print("=" * 60)


class Rango:
    """Implementa un rango personalizado como iterador."""

    def __init__(self, inicio, fin, paso=1):
        self.inicio = inicio
        self.fin = fin
        self.paso = paso
        self.actual = inicio

    def __iter__(self):
        return self

    def __next__(self):
        if self.actual >= self.fin:
            raise StopIteration
        valor = self.actual
        self.actual += self.paso
        return valor


rango = Rango(0, 10, 2)
print("\nRango(0, 10, paso=2):")
for n in rango:
    print(f"  {n}", end=" ")
print()


# =============================================================================
# EJEMPLO 2: Generador como método de clase
# =============================================================================

print("\n" + "=" * 60)
print("EJEMPLO 2: Generador en método de clase")
print("=" * 60)


class Inventario:
    """Inventario que puede iterar sus productos con generador."""

    def __init__(self):
        self._productos = []

    def agregar(self, nombre, precio, stock):
        self._productos.append({"nombre": nombre, "precio": precio, "stock": stock})

    def disponibles(self):
        """Generador: solo productos con stock > 0."""
        for p in self._productos:
            if p["stock"] > 0:
                yield p

    def caros(self, minimo):
        """Generador: productos por encima de un precio mínimo."""
        for p in self._productos:
            if p["precio"] >= minimo:
                yield p

    def valor_total(self):
        """Usa expresión generadora para calcular valor total."""
        return sum(p["precio"] * p["stock"] for p in self._productos)


inventario = Inventario()
inventario.agregar("Portátil", 999, 5)
inventario.agregar("Ratón", 25, 0)
inventario.agregar("Teclado", 75, 10)
inventario.agregar("Monitor", 350, 3)
inventario.agregar("Webcam", 89, 0)

print("\nProductos disponibles (stock > 0):")
for p in inventario.disponibles():
    print(f"  {p['nombre']}: {p['precio']}€ (stock: {p['stock']})")

print("\nProductos caros (>= 100€):")
for p in inventario.caros(100):
    print(f"  {p['nombre']}: {p['precio']}€")

print(f"\nValor total inventario: {inventario.valor_total()}€")


# =============================================================================
# EJEMPLO 3: Pipeline de procesamiento de datos
# =============================================================================

print("\n" + "=" * 60)
print("EJEMPLO 3: Pipeline con generadores")
print("=" * 60)


class ProcesadorDatos:
    """Procesa grandes volúmenes de datos con generadores."""

    def __init__(self, datos):
        self.datos = datos

    def filtrar(self, condicion):
        return (d for d in self.datos if condicion(d))

    def transformar(self, func, datos=None):
        fuente = datos if datos is not None else self.datos
        return (func(d) for d in fuente)

    def tomar(self, n, datos=None):
        fuente = datos if datos is not None else self.datos
        for i, d in enumerate(fuente):
            if i >= n:
                break
            yield d


numeros = range(1, 1_000_001)  # 1 millón de números
procesador = ProcesadorDatos(numeros)

# Pipeline: filtrar pares → elevar al cuadrado → tomar los primeros 5
pares = procesador.filtrar(lambda x: x % 2 == 0)
cuadrados = procesador.transformar(lambda x: x ** 2, pares)
resultado = list(procesador.tomar(5, cuadrados))

print(f"\nPrimeros 5 cuadrados de pares (de 1M números):")
print(f"  {resultado}")
print(f"  Memoria del generador: {sys.getsizeof(procesador.filtrar(lambda x: x % 2 == 0))} bytes")
print(f"  (vs lista completa: ~8MB)")


print("\n" + "=" * 60)
print("✅ Generadores + POO en la práctica")
print("=" * 60)
