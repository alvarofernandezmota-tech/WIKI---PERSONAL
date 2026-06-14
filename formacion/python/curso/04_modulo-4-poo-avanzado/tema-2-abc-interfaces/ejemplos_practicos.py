""""""Ejemplos Prácticos: Block Puzzles del Tema 2 - ABC e Interfaces

Este archivo contiene los 8 puzzles del curso corregidos según PEP 8.
""""""

from abc import ABC, ABCMeta, abstractmethod


print("=" * 70)
print(" PUZZLE 1: Herencia Básica")
print("=" * 70)

class Transporte:
    """"""Clase base para medios de transporte.""""""
    def mover(self):
        pass

class Coche(Transporte):
    """"""Coche que hereda de Transporte.""""""
    def mover(self):
        print("El coche se mueve")

auto = Coche()  # ✅ CORREGIDO: Mayúscula (era: coche())
auto.mover()


print("\n" + "=" * 70)
print(" PUZZLE 2: Interfaz Formal con ABC")
print("=" * 70)

class Postre(ABC):
    """"""Interfaz formal para postres.""""""
    @abstractmethod
    def saborear(self):
        pass

class Helado(Postre):
    """"""Implementación de Postre.""""""
    def saborear(self):
        print("¡Mmm, qué delicioso!")

Helado().saborear()


print("\n" + "=" * 70)
print(" PUZZLE 3: Polimorfismo con Múltiples Clases")
print("=" * 70)

class Animal:
    """"""Clase base para animales.""""""
    def __init__(self, nombre):
        self.nombre = nombre
    
    def hacer_sonido(self):
        return "El animal hace un sonido genérico"

class Perro(Animal):
    """"""Perro que hace 'GUAU'.""""""
    def hacer_sonido(self):
        return "GUAU"

class Gato(Animal):
    """"""Gato que hace 'MIAU'.""""""
    def hacer_sonido(self):
        return "MIAU"

mascotas = [Perro("Jack"), Gato("Isidoro")]

for mascota in mascotas:
    print(mascota.nombre + " hace " + mascota.hacer_sonido())


print("\n" + "=" * 70)
print(" PUZZLE 4: Implementación Simple de Herencia")
print("=" * 70)

class Animal:  # ✅ CORREGIDO: Mayúscula (era: animal)
    """"""Clase base Animal.""""""
    def sonido(self):
        pass

class Vaca(Animal):  # ✅ CORREGIDO: Mayúscula (era: vaca)
    """"""Vaca que hace 'Muuu'.""""""
    def sonido(self):
        print("Muuu")

vaca = Vaca()  # ✅ CORREGIDO: Mayúscula (era: vaca = vaca())
vaca.sonido()


print("\n" + "=" * 70)
print(" PUZZLE 5: ABC con Métodos Abstractos")
print("=" * 70)

class LenguajeProgramacion(ABC):
    """"""Interfaz para lenguajes de programación.""""""
    @abstractmethod
    def programar(self):
        pass

class Python(LenguajeProgramacion):
    """"""Implementación para Python.""""""
    def programar(self):
        print("¡Estoy programando en Python!")

Python().programar()


print("\n" + "=" * 70)
print(" PUZZLE 6: Sobrescritura de Métodos")
print("=" * 70)

class Planeta:
    """"""Clase base Planeta.""""""
    def girar(self):
        print("Giro alrededor del sol")

class Tierra(Planeta):
    """"""Tierra con movimiento adicional.""""""
    def girar(self):
        print("Giro alrededor del sol y alrededor de mi propio eje")

Tierra().girar()


print("\n" + "=" * 70)
print(" PUZZLE 7: Métodos de Instancia")
print("=" * 70)

class Ubicacion:
    """"""Clase base para ubicaciones.""""""
    def obtener_coordenadas(self):
        pass

class Ciudad(Ubicacion):
    """"""Ciudad con coordenadas específicas.""""""
    def obtener_coordenadas(self):
        print("Las coordenadas de la ciudad son 40.4168° N, 3.7038° W")

madrid = Ciudad()
madrid.obtener_coordenadas()


print("\n" + "=" * 70)
print(" PUZZLE 8: Clases Virtuales con ABCMeta")
print("=" * 70)

class MyFloat(metaclass=ABCMeta):
    """"""Clase abstracta para flotantes.""""""
    pass

# Registrar float como subclase virtual
MyFloat.register(float)

print(f"float es subclase de MyFloat: {issubclass(float, MyFloat)}")
print(f"3.14 es instancia de MyFloat: {isinstance(3.14, MyFloat)}")


print("\n" + "=" * 70)
print(" ✅ TODOS LOS PUZZLES COMPLETADOS")
print("=" * 70)
print("\n🐞 Errores encontrados y corregidos:")
print("   1️⃣  Puzzle 1: auto = coche() → auto = Coche()")
print("   4️⃣  Puzzle 4: class animal → class Animal")
print("   4️⃣  Puzzle 4: class vaca → class Vaca")
print("   4️⃣  Puzzle 4: vaca = vaca() → vaca = Vaca()")
print("\n✅ Todos los nombres de clases en CamelCase (PEP 8)")
print("=" * 70)
