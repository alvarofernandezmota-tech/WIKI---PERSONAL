"""
Módulo 4 - Tema 1.5: Polimorfismo

Ejemplos de polimorfismo en Python.
"""

# Ejemplo 1: Polimorfismo con herencia
class Forma:
    """Clase base para formas geométricas"""
    
    def area(self):
        pass
    
    def perimetro(self):
        pass


class Rectangulo(Forma):
    def __init__(self, base, altura):
        self.base = base
        self.altura = altura
    
    def area(self):
        return self.base * self.altura
    
    def perimetro(self):
        return 2 * (self.base + self.altura)


class Circulo(Forma):
    def __init__(self, radio):
        self.radio = radio
    
    def area(self):
        return 3.14159 * self.radio ** 2
    
    def perimetro(self):
        return 2 * 3.14159 * self.radio


def imprimir_info_forma(forma):
    """Función que usa polimorfismo"""
    print(f"Tipo: {forma.__class__.__name__}")
    print(f"Área: {forma.area():.2f}")
    print(f"Perímetro: {forma.perimetro():.2f}")
    print("-" * 30)


# Tests
if __name__ == "__main__":
    formas = [
        Rectangulo(5, 3),
        Circulo(4),
        Rectangulo(10, 2)
    ]
    
    for forma in formas:
        imprimir_info_forma(forma)
