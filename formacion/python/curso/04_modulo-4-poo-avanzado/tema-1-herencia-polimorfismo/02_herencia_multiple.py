"""
Módulo 4 - Tema 1.3: Herencia Múltiple

Ejemplos de implementación de herencia múltiple en Python.
"""

# Ejemplo 1: Herencia múltiple básica
class Volador:
    """Clase para objetos que pueden volar"""
    
    def volar(self):
        return "Estoy volando"


class Nadador:
    """Clase para objetos que pueden nadar"""
    
    def nadar(self):
        return "Estoy nadando"


class Pato(Volador, Nadador):
    """Pato puede volar y nadar"""
    
    def __init__(self, nombre):
        self.nombre = nombre
    
    def presentarse(self):
        return f"Soy {self.nombre}, un pato"


# Ejemplo 2: Herencia múltiple con métodos comunes
class Terrestre:
    def moverse(self):
        return "Caminando por tierra"


class Acuatico:
    def moverse(self):
        return "Nadando en agua"


class Anfibio(Terrestre, Acuatico):
    """Anfibio puede moverse en tierra y agua"""
    pass


# Tests
if __name__ == "__main__":
    pato = Pato("Donald")
    print(pato.presentarse())
    print(pato.volar())
    print(pato.nadar())
    
    rana = Anfibio()
    print(f"Rana se mueve: {rana.moverse()}")
    print(f"MRO de Anfibio: {Anfibio.__mro__}")
