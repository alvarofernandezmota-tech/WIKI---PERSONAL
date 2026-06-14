
#1. declara una lista vacia
lista = []

#2. declara una lista con mas de 7 elementos
lista =[1,2,3,4,5,6,7,8]
#3. encunetra la longitud de tu lista
print(len(lista))
#4.corta tu lista y muestra los dos primeros elementos y los dos ultimos
primeros_numeros = lista[0:2]
ultimos_numeros = lista[-3:-1] 
print(primeros_numeros)
print(ultimos_numeros)

#5. muetsra el primero el del medio y el ultimo
print(lista[0])
print(lista[-1])
medio = int(len(lista)//2)
print(medio)
#6. escribe un programa que sume todos los elementos de una lista  de nuemros enteros
lista_num = [4,6,7,6,8,0,5,6]
suma = None
for numeros in lista_num:
    suma += numeros
print(suma)
