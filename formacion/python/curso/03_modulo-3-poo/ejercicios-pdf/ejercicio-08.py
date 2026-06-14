# EJERCICIO 8: añade a la clase anterior, un metodo
# estatico que dada una lista de notas y sus asignaturas
# asociadas como diccionario, imprima aquellas asignaturas
# que han recibido una nota inferior a 5.
class Estudiante:
    
    def __init__(self, nombre):
        self.nombre = nombre
        self.grado = 0 
    def calcular_media(self, lista_notas):
        media = sum(lista_notas) / len(lista_notas)
        self.grado = media
    @staticmethod
    def asignaturas_suspendidas(diccionario_notas):
        for asignatura, nota in diccionario_notas.items():  # ← .items()
            if nota < 5:
                print(asignatura)
            
notas_dict = {"Matemáticas": 4.5, "Historia": 7, "Inglés": 3.2, "Física": 8}
Estudiante.asignaturas_suspendidas(notas_dict)