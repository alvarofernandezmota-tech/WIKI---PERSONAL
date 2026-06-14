"""
Módulo 4 - Tema 1.4: Method Resolution Order (MRO)

Ejemplos de MRO en herencia múltiple.
"""

# Ejemplo MRO con herencia diamante
class A:
    def metodo(self):
        return "Método de A"


class B(A):
    def metodo(self):
        return "Método de B"


class C(A):
    def metodo(self):
        return "Método de C"


class D(B, C):
    pass


# Tests y explicación
if __name__ == "__main__":
    d = D()
    print(f"Resultado: {d.metodo()}")
    print(f"\nMRO de D: {D.__mro__}")
    
    # Explicación del MRO
    print("\nOrden de resolución:")
    for i, clase in enumerate(D.__mro__, 1):
        print(f"{i}. {clase.__name__}")
