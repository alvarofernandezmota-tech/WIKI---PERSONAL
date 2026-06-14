"""
EJEMPLOS TEMA 1 - METODOLOGÍA Y CONCEPTOS POO
Módulo 3 Python - Escuela Musk
Autor: Álvaro Fernández Mota
Fecha: 10 febrero 2026
"""

# ==============================================================================
# EJEMPLO 1: Programación Estructurada vs POO
# ==============================================================================

print("="*80)
print("EJEMPLO 1: COMPARACIÓN ESTRUCTURADA VS POO")
print("="*80)

# --- Versión Estructurada ---
print("\n📄 Versión Estructurada:")
print("-" * 40)

# Datos globales
citas_estructurada = []

def agregar_cita_estructurada(nombre, fecha, hora):
    """Función para agregar cita"""
    cita = {'nombre': nombre, 'fecha': fecha, 'hora': hora}
    citas_estructurada.append(cita)
    print(f"✅ Cita agregada: {nombre}")

def ver_citas_estructurada():
    """Función para ver citas"""
    if not citas_estructurada:
        print("❌ No hay citas")
        return
    for cita in citas_estructurada:
        print(f"  - {cita['nombre']}: {cita['fecha']} a las {cita['hora']}")

# Uso
agregar_cita_estructurada("Juan", "15/02/2026", "10:00")
agregar_cita_estructurada("Ana", "16/02/2026", "11:00")
print("\nCitas registradas:")
ver_citas_estructurada()


# --- Versión POO ---
print("\n\n📦 Versión POO:")
print("-" * 40)

class Cita:
    """Clase que representa una cita"""
    def __init__(self, nombre, fecha, hora):
        self.nombre = nombre
        self.fecha = fecha
        self.hora = hora
    
    def mostrar(self):
        return f"{self.nombre}: {self.fecha} a las {self.hora}"

class GestorCitas:
    """Clase que gestiona las citas"""
    def __init__(self):
        self.citas = []
    
    def agregar_cita(self, cita):
        self.citas.append(cita)
        print(f"✅ Cita agregada: {cita.nombre}")
    
    def ver_citas(self):
        if not self.citas:
            print("❌ No hay citas")
            return
        for cita in self.citas:
            print(f"  - {cita.mostrar()}")

# Uso
gestor = GestorCitas()
cita1 = Cita("Juan", "15/02/2026", "10:00")
cita2 = Cita("Ana", "16/02/2026", "11:00")
gestor.agregar_cita(cita1)
gestor.agregar_cita(cita2)
print("\nCitas registradas:")
gestor.ver_citas()


# ==============================================================================
# EJEMPLO 2: Encapsulación
# ==============================================================================

print("\n\n" + "="*80)
print("EJEMPLO 2: ENCAPSULACIÓN")
print("="*80)

class CuentaBancaria:
    """Ejemplo de encapsulación"""
    def __init__(self, titular, saldo_inicial):
        self.titular = titular  # Público
        self.__saldo = saldo_inicial  # Privado (doble guion bajo)
    
    def depositar(self, cantidad):
        """Método público para depositar"""
        if cantidad > 0:
            self.__saldo += cantidad
            print(f"✅ Depositado: {cantidad}€")
            return True
        print("❌ Cantidad inválida")
        return False
    
    def retirar(self, cantidad):
        """Método público para retirar"""
        if cantidad > 0 and cantidad <= self.__saldo:
            self.__saldo -= cantidad
            print(f"✅ Retirado: {cantidad}€")
            return True
        print("❌ Saldo insuficiente o cantidad inválida")
        return False
    
    def ver_saldo(self):
        """Acceso controlado al saldo"""
        return f"Saldo actual: {self.__saldo}€"

# Uso
cuenta = CuentaBancaria("Juan Pérez", 1000)
print(f"Titular: {cuenta.titular}")
print(cuenta.ver_saldo())

cuenta.depositar(500)
print(cuenta.ver_saldo())

cuenta.retirar(200)
print(cuenta.ver_saldo())

# Intentar acceder directamente al saldo privado
try:
    print(cuenta.__saldo)  # Esto dará error
except AttributeError:
    print("❌ No se puede acceder a __saldo (es privado)")


# ==============================================================================
# EJEMPLO 3: Herencia
# ==============================================================================

print("\n\n" + "="*80)
print("EJEMPLO 3: HERENCIA")
print("="*80)

class Persona:
    """Clase padre"""
    def __init__(self, nombre, edad):
        self.nombre = nombre
        self.edad = edad
    
    def presentarse(self):
        return f"Hola, soy {self.nombre} y tengo {self.edad} años"

class Estudiante(Persona):
    """Clase hija - hereda de Persona"""
    def __init__(self, nombre, edad, carrera):
        super().__init__(nombre, edad)  # Llamar constructor padre
        self.carrera = carrera
    
    def estudiar(self):
        return f"{self.nombre} está estudiando {self.carrera}"

class Profesor(Persona):
    """Otra clase hija"""
    def __init__(self, nombre, edad, materia):
        super().__init__(nombre, edad)
        self.materia = materia
    
    def enseñar(self):
        return f"{self.nombre} enseña {self.materia}"

# Uso
estudiante = Estudiante("Ana", 20, "Ingeniería Informática")
profesor = Profesor("Juan", 45, "Matemáticas")

print(estudiante.presentarse())  # Heredado
print(estudiante.estudiar())  # Propio
print()
print(profesor.presentarse())  # Heredado
print(profesor.enseñar())  # Propio


# ==============================================================================
# EJEMPLO 4: Polimorfismo
# ==============================================================================

print("\n\n" + "="*80)
print("EJEMPLO 4: POLIMORFISMO")
print("="*80)

class Animal:
    """Clase base"""
    def __init__(self, nombre):
        self.nombre = nombre
    
    def hacer_sonido(self):
        pass

class Perro(Animal):
    def hacer_sonido(self):
        return f"{self.nombre}: 🐶 Guau guau!"

class Gato(Animal):
    def hacer_sonido(self):
        return f"{self.nombre}: 🐱 Miau miau!"

class Vaca(Animal):
    def hacer_sonido(self):
        return f"{self.nombre}: 🐄 Muuuu!"

# Polimorfismo en acción
def presentar_animal(animal):
    """Misma función, diferentes comportamientos"""
    print(animal.hacer_sonido())

# Crear lista de diferentes animales
animales = [
    Perro("Max"),
    Gato("Luna"),
    Vaca("Lola"),
    Perro("Rocky")
]

print("\nPresentación de animales:")
for animal in animales:
    presentar_animal(animal)


# ==============================================================================
# EJEMPLO 5: Los 4 Principios Juntos
# ==============================================================================

print("\n\n" + "="*80)
print("EJEMPLO 5: LOS 4 PRINCIPIOS JUNTOS")
print("="*80)

from abc import ABC, abstractmethod

# ABSTRACCIÓN: Clase abstracta
class Vehiculo(ABC):
    def __init__(self, marca, modelo):
        self.marca = marca
        self.modelo = modelo
        self.__velocidad = 0  # ENCAPSULACIÓN: Atributo privado
    
    @abstractmethod
    def arrancar(self):
        pass
    
    @abstractmethod
    def detener(self):
        pass
    
    def acelerar(self, incremento):
        self.__velocidad += incremento
        return f"Velocidad: {self.__velocidad} km/h"
    
    def frenar(self, decremento):
        self.__velocidad = max(0, self.__velocidad - decremento)
        return f"Velocidad: {self.__velocidad} km/h"
    
    def ver_velocidad(self):
        return self.__velocidad

# HERENCIA: Clases que heredan de Vehiculo
class Coche(Vehiculo):
    def arrancar(self):
        return f"🚗 {self.marca} {self.modelo} arrancado con llave"
    
    def detener(self):
        return f"🚗 {self.marca} {self.modelo} detenido"

class Moto(Vehiculo):
    def arrancar(self):
        return f"🏍️ {self.marca} {self.modelo} arrancada con botón"
    
    def detener(self):
        return f"🏍️ {self.marca} {self.modelo} detenida"

# Uso
coche = Coche("Toyota", "Corolla")
moto = Moto("Honda", "CBR")

print("\nCoche:")
print(coche.arrancar())
print(coche.acelerar(50))
print(coche.acelerar(30))
print(coche.frenar(20))
print(coche.detener())

print("\nMoto:")
print(moto.arrancar())
print(moto.acelerar(80))
print(moto.frenar(30))
print(moto.detener())

# POLIMORFISMO: Misma función para diferentes vehículos
def probar_vehiculo(vehiculo):
    print(f"\nProbando vehículo:")
    print(vehiculo.arrancar())
    print(vehiculo.acelerar(60))
    print(vehiculo.detener())

print("\n" + "-"*40)
probar_vehiculo(coche)
probar_vehiculo(moto)

print("\n\n✅ Fin de ejemplos Tema 1")
