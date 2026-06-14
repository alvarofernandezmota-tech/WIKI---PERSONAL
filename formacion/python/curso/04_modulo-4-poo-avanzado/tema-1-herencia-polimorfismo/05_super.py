"""
Módulo 4 - Tema 1.6: Uso de super()

Ejemplos del uso de super() en Python.
"""

# Ejemplo 1: super() en herencia simple
class Persona:
    def __init__(self, nombre, edad):
        self.nombre = nombre
        self.edad = edad
    
    def presentarse(self):
        return f"Hola, soy {self.nombre}"


class Estudiante(Persona):
    def __init__(self, nombre, edad, carrera):
        super().__init__(nombre, edad)
        self.carrera = carrera
    
    def presentarse(self):
        presentacion_base = super().presentarse()
        return f"{presentacion_base} y estudio {self.carrera}"


# Ejemplo 2: super() en herencia múltiple
class Empleado:
    def __init__(self, salario):
        self.salario = salario
    
    def info_laboral(self):
        return f"Salario: {self.salario}"


class EstudianteTrabajador(Estudiante, Empleado):
    def __init__(self, nombre, edad, carrera, salario):
        Estudiante.__init__(self, nombre, edad, carrera)
        Empleado.__init__(self, salario)
    
    def info_completa(self):
        return f"{self.presentarse()}\n{self.info_laboral()}"


# Tests
if __name__ == "__main__":
    estudiante = Estudiante("Ana", 20, "Ingeniería")
    print(estudiante.presentarse())
    
    est_trab = EstudianteTrabajador("Carlos", 22, "Informática", 1200)
    print("\n" + est_trab.info_completa())
