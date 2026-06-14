# EJERCICIO 5: Crear 3 instancias de Estudiante con diferentes datos
# Mostrar información de cada una
class Estudiante:
    def __init__(self, nombre, edad, grado):
        self.nombre = nombre
        self.edad = edad
        self.grado = grado

estudiante1 = Estudiante("Carlos", 20, "Ingeniería")
estudiante2 = Estudiante("Ana", 22, "Medicina")
estudiante3 = Estudiante("Luis", 19, "Derecho")
estudiantes = [estudiante1, estudiante2, estudiante3]

print("=" * 50)
print(" " * 12 + "LISTA ESTUDIANTES")
print("=" * 50)

for estudiante in estudiantes:
    print(f"\nNombre: {estudiante.nombre}")
    print(f"Edad: {estudiante.edad} años")
    print(f"Grado: {estudiante.grado}")
    print("-" * 50)