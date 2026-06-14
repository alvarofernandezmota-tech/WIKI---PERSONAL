# EJERCICIO 7: Añade un metodo publico en la clase estudiante. que
# calcule la media de una lista de notas y actualize el valor del atributo grande.
# a continuacion llama a la funcion en tu programa proncipal y imprime el valor mas grado
class Estudiante:
    
    def __init__(self, nombre):
        self.nombre = nombre
        self.grado = 0 

    def calcular_media(self, lista_notas):
        media = sum(lista_notas) / len(lista_notas)
        self.grado = media
estudiante1 = Estudiante("Juan")
lista_notas = [8, 7, 9, 8.5]
estudiante1.calcular_media(lista_notas)  
print(estudiante1.grado)