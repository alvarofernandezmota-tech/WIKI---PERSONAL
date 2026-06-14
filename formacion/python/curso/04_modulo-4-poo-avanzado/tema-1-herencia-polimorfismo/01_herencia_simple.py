"""
Módulo 4 - Tema 1.2: Herencia Simple

Ejemplos de implementación de herencia simple en Python.
"""

# Ejemplo 1: Herencia simple básica
class Animal:
    """Clase base Animal"""
    
    def __init__(self, nombre):
        self.nombre = nombre
    
    def hacer_sonido(self):
        return "Algún sonido"
    
    def info(self):
        return f"Soy {self.nombre}"


class Perro(Animal):
    """Clase Perro que hereda de Animal"""
    
    def hacer_sonido(self):
        return "Guau!"


# Ejemplo 2: Extender funcionalidad
class Gato(Animal):
    """Clase Gato que hereda y extiende Animal"""
    
    def __init__(self, nombre, color):
        super().__init__(nombre)
        self.color = color
    
    def hacer_sonido(self):
        return "Miau!"
    
    def info(self):
        return f"{super().info()} y soy de color {self.color}"


# Tests
if __name__ == "__main__":
    perro = Perro("Rex")
    print(f"{perro.nombre} dice: {perro.hacer_sonido()}")
    print(perro.info())
    
    gato = Gato("Misi", "blanco")
    print(f"{gato.nombre} dice: {gato.hacer_sonido()}")
    print(gato.info())
