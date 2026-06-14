# EJERCICIO 10: Añade un metodo privado de la clase anterior ,
# que dado un diccionario mes-numero de asistencias,devuelva 1 si tiene <4 devuelva 2si algun mes tiene alguna asistencia
#  entre [4, 8] o bien devuelva 3 en casa contrario.
# para proabr el metodo pribado, encapsulalo con una funcion publica qeu devuelva su resultado.
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
    
    def _verificar_asistencias(self, diccionario_asistencias):
        for mes, asistencias in diccionario_asistencias.items():
            if asistencias < 4:
                return 1
            if asistencias >= 4 and asistencias <= 8:
                return 2
        return 3 
    def verificar_asistencias(self, diccionario_asistencias):
        return self._verificar_asistencias(diccionario_asistencias)
    

est1 = Estudiante("Juan")

asistencias1 = {"enero": 3, "febrero": 10}
print(est1.verificar_asistencias(asistencias1)) 

asistencias2 = {"enero": 5, "febrero": 10}
print(est1.verificar_asistencias(asistencias2)) 

# Prueba 3: todos > 8
asistencias3 = {"enero": 9, "febrero": 10, "marzo": 12}
print(est1.verificar_asistencias(asistencias3))  
