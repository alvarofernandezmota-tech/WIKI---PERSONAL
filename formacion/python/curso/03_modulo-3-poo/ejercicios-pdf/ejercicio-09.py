# EJERCICIO 9: Añade un atributo de clase llamado escuela a la clase estudiante
# y dale un valor predeterminado. A continuacion,
# añade un metodo de clase que dado el nombre de otra escuela actualice 
# el atributo. Llama a tu metodo en el programa principal y 
# asegurate de que funciona.

class Estudiante:
    escuela = "salesianos-estrecho"  # ← Atributo de CLASE
    
    def __init__(self, nombre):
        self.nombre = nombre
        self.grado = 0 
    
    def calcular_media(self, lista_notas):
        media = sum(lista_notas) / len(lista_notas)
        self.grado = media
    
    @staticmethod
    def asignaturas_suspendidas(diccionario_notas):
        for asignatura, nota in diccionario_notas.items():
            if nota < 5:
                print(asignatura)
    
    @classmethod  
    def cambiar_escuela(cls, nueva_escuela):  
        cls.escuela = nueva_escuela 
est1 = Estudiante("Juan")
print("Escuela inicial:", Estudiante.escuela)
Estudiante.cambiar_escuela("salesianos-atocha")

print("Escuela actualizada:", Estudiante.escuela)  # 


