""""""Tema 2.1: Abstract Base Class (ABC) - Conceptos Básicos

Este archivo demuestra el uso fundamental de Abstract Base Class (ABC)
para crear interfaces formales en Python.
""""""

from abc import ABC, abstractmethod


# =============================================================================
# EJEMPLO 1: Clase Abstracta Básica
# =============================================================================

class Animal(ABC):
    """"""Clase abstracta que define la interfaz para animales.""""""
    
    @abstractmethod
    def hacer_sonido(self):
        """"""Método abstracto que debe ser implementado por subclases.""""""
        pass
    
    @abstractmethod
    def moverse(self):
        """"""Método abstracto para el movimiento del animal.""""""
        pass
    
    # Método concreto (opcional)
    def presentarse(self):
        """"""Método concreto que puede ser usado por todas las subclases.""""""
        print(f"Soy un {self.__class__.__name__}")


class Perro(Animal):
    """"""Implementación concreta de Animal.""""""
    
    def hacer_sonido(self):
        return "GUAU GUAU!"
    
    def moverse(self):
        return "El perro corre en cuatro patas"


class Pajaro(Animal):
    """"""Otra implementación concreta de Animal.""""""
    
    def hacer_sonido(self):
        return "PIO PIO!"
    
    def moverse(self):
        return "El pájaro vuela"


# =============================================================================
# EJEMPLO 2: ABC con Métodos Concretos y Abstractos
# =============================================================================

class Forma(ABC):
    """"""Clase abstracta para formas geométricas.""""""
    
    def __init__(self, nombre):
        self.nombre = nombre
    
    @abstractmethod
    def area(self):
        """"""Calcular el área de la forma.""""""
        pass
    
    @abstractmethod
    def perimetro(self):
        """"""Calcular el perímetro de la forma.""""""
        pass
    
    def descripcion(self):
        """"""Método concreto compartido.""""""
        return f"Esta es una forma: {self.nombre}"


class Rectangulo(Forma):
    """"""Implementación de Forma para rectángulos.""""""
    
    def __init__(self, ancho, alto):
        super().__init__("Rectángulo")
        self.ancho = ancho
        self.alto = alto
    
    def area(self):
        return self.ancho * self.alto
    
    def perimetro(self):
        return 2 * (self.ancho + self.alto)


class Circulo(Forma):
    """"""Implementación de Forma para círculos.""""""
    
    def __init__(self, radio):
        super().__init__("Círculo")
        self.radio = radio
    
    def area(self):
        return 3.14159 * self.radio ** 2
    
    def perimetro(self):
        return 2 * 3.14159 * self.radio


# =============================================================================
# DEMOSTRACIÓN
# =============================================================================

if __name__ == "__main__":
    print("=" * 60)
    print("EJEMPLO 1: Animales con ABC")
    print("=" * 60)
    
    # Crear instancias
    perro = Perro()
    pajaro = Pajaro()
    
    # Usar métodos abstractos implementados
    print(f"\nPerro:")
    perro.presentarse()
    print(f"Sonido: {perro.hacer_sonido()}")
    print(f"Movimiento: {perro.moverse()}")
    
    print(f"\nPájaro:")
    pajaro.presentarse()
    print(f"Sonido: {pajaro.hacer_sonido()}")
    print(f"Movimiento: {pajaro.moverse()}")
    
    # Intentar crear instancia de clase abstracta (da error)
    print("\n" + "=" * 60)
    print("⚠️  Intentar instanciar clase abstracta:")
    print("=" * 60)
    try:
        animal = Animal()  # Esto lanzará un error
    except TypeError as e:
        print(f"❌ Error: {e}")
    
    print("\n" + "=" * 60)
    print("EJEMPLO 2: Formas Geométricas")
    print("=" * 60)
    
    # Crear formas
    rectangulo = Rectangulo(5, 3)
    circulo = Circulo(4)
    
    # Mostrar información
    formas = [rectangulo, circulo]
    
    for forma in formas:
        print(f"\n{forma.descripcion()}")
        print(f"Área: {forma.area():.2f}")
        print(f"Perímetro: {forma.perimetro():.2f}")
    
    print("\n" + "=" * 60)
    print("✅ ABC obliga a implementar todos los métodos abstractos")
    print("=" * 60)
