## modulo 2 tema 4 ##       
## 1. Haz un programa que lea dos palabras y que indique el orden lexicográfico. Escribe en una línea indicando si a < b, a > b o a = b. Ejemplo: a = Anna, b = Javier, Anna < Javier.

a = input("Introduce una palabra:")
b = input("Introduce una palabra:")

if a > b:
    print("{} > {}".format(a, b))
else:
    print("{} < {}".format(a, b))

    ##2. Haz un programa que lea una letra y que indique por pantalla si es una mayúscula, si es una minúscula, si es una vocal, y si es una consonante.

c = input("introduce una letra:") 
if c == "a" or c == "e" or c == "i" or c == "o" or c == "u":
    print("{} es una vocal".format(c))
else:
    print("{} es una consonte".format(c))
if c.islower():
    print("{} es una minuscula".format(c))
else:
    print("{} es una mayuscula".format(c))
## 3. Haz un programa que lea un entero que representa una temperatura en grados
#  Celsius, y que diga si hace calor, si hace frío, o si se está bien.
#  Suponed que hace calor si la temperatura es más alta que 30 grados,
#  que hace frío si es más baja que 10 grados, y que se está bien en otro caso.

x = float(input("Introduce un número:"))
if x > 30:
    print("hace calor")
elif x < 10:
    print("hace frio")
else:
    print("se esta bien") 
##4. Haz un programa que, dados dos intervalos, calcule el intervalo correspondiente a la intersección o indique que esta es vacía.

x1 = int(input("Introduce el extremo izquierdo del primer intervalo: "))
y1 = int(input("Introduce el extremo derecho del primer intervalo: "))

x2 = int(input("Introduce el extremo izquierdo del segundo intervalo: "))
y2 = int(input("Introduce el extremo derecho del segundo intervalo: "))

# El mínimo válido para la intersección es el mayor de los extremos izquierdos
minimo = max(x1, x2)

# El máximo válido para la intersección es el menor de los extremos derechos
maximo = min(y1, y2)

# Comprobamos si hay intersección
if minimo <= maximo:
    print("[{}, {}]".format(minimo, maximo))
else:
    print("Intersección vacía")
## 5. Haz un programa que indique 
# si un año es bisiesto o no. Un año bi
# siesto tiene 366 días. Después de la r
# eforma gregoriana, los años bisiestos son los 
# múltiplos de cuatro que no acaban en dos cer
# os, y también los acabados en dos ceros ta
# les que el número que queda después de sac
# ar los dos ceros finales es divisible por cu
# atro. Así, 1800 y 1900, a pesar de ser múltiples
#  de cuatro, no fueran bisiestos; en cambio, 2000
#  lo fue.

x = int(input("introduce un numero:"))
if x % 4 == 0 or x % 100 != 0 or x % 400 == 0:
    print("{} es año bisiesto".format(x))
else:
    print("{} no es año bisiesto".format(x))

##6. Haz un programa que añada un segundo en 
# una hora del día, dadas sus horas, minutos y segundos.
h = int(input("Introduce las horas (0-23): "))
m = int(input("Introduce los minutos (0-59): "))
s = int(input("Introduce los segundos (0-59): "))

# Convertir toda la hora a segundos
total_segundos = h * 3600 + m * 60 + s

# Sumar 1 segundo
total_segundos += 1

# Volver a convertir a horas, minutos y segundos (módulo 24h)
h = (total_segundos // 3600) % 24
m = (total_segundos % 3600) // 60
s = total_segundos % 60

print("Nueva hora: {:02d}:{:02d}:{:02d}".format(h, m, s))

## 7. Haz un programa que lea un real x≥0 y que escriba ⌊x⌋ 
# (la parte entera inferior de x), ⌈x⌉ 
# (la parte entera superior de x), y el redondeo de x.

x = float(input("introduce un numero x≥0:"))

if x >= 0:
    parte_entera_inferior = int(x) 
    parte_entera_superior = int(x) + 1 if x % 1 != 0 else int(x)
    redondeo = round(x) 
    print(f"parte entera inferior: {parte_entera_inferior} parte entera superior: {parte_entera_superior} redondeo: {redondeo}")
else:
    print("El número no es válido, debe ser x≥0")


#bucles


#.1 Haz un programa que lea dos números a y b, y que escriba todos los números
# enteros a y b. Debe cumplirse que a < b. En caso que a > b, escribe los número
# de manera descendente.
a = int(input("Introduce un número entero a: "))
b = int(input("Introduce un número entero b: "))

if a < b:
    print(f"primer numero: {a} es menor que segundo numero: {b}")
elif a > b:
    print(f"primer numero: {a} es mayor que segundo numero: {b}")
else: a == b
print(f"primer numero: {a} es igual que segundo numero: {b}")

#2. Haz un programa que lea una secuencia de 10 números y que escriba la media.
suma = 0
media = suma / 10
for i in range(1,11):
    numero = float(input("Introduce un número: "))
    suma += numero
media = suma / 10
print(f"La media de los números es: {media}")

#3. Haz un programa que dada una lista de naturales de tamaño n, indique la posición del
# primer número par.

n = int(input("Introduce el tamaño de la lista de números naturales: "))
lista = []
for i in range(n):
    numero = int(input("Introduce un número natural: "))
    lista.append(numero)    
for i in range(n):
    if lista[i] % 2 == 0:
        print(f"El primer número par está en la posición: {i}")
        break 

# 4. Haz un programa que lea un número n y que escriba la “tabla de multiplicar” de n.
n = int(input("Introduce un número para ver su tabla de multiplicar: "))
for i in range(1, 11):
    resultado = n * i
    print(f"{n} x {i} = {resultado}")

#5. Haz un programa que lea un número y que lo escriba del revés.
n = int(input("Introduce un número: "))
temp = n
invertido = 0
while temp > 0:
    digito = temp % 10 
    invertido = invertido * 10 + digito 
    temp //= 10
print(f"El número al revés es: {invertido}")

#6. Haz un programa que lea un número y que escriba el número de dígitos.
n = int(input("Introduce un número: "))
temp = n
suma = 0
while temp > 0:
    digito = temp % 10
    suma = suma + 1
    temp //= 10
print(f"El número de dígitos es: {suma}")
#7. Haz un programa que diga si un natural n es capicua o no.
n = int(input("Introduce un número natural: "))
temp = n
invertido = 0
while temp > 0:
    digito = temp % 10
    invertido = invertido * 10 + digito
    temp = temp // 10
if n == invertido:
    print(f"El número {n} es capicua")
else:
    print(f"El número {n} no es capicua")
#8. haz un programa que dada una secuencia de años acabada en 0, diga cuqntos hay del diglo 20.
contador = 0
año = int(input("Introduce un año (0 para terminar): "))
while año != 0:
    if 1900 < año <= 2000:
        contador = contador + 1
    año = int(input("Introduce un año (0 para terminar): "))
print(f"Hay {contador} años del siglo 20")

#9. Haz un programa que reciba una secuencia de naturales de tamaño n y nos devuelva
#  cuál es el primer natural que tiene un valor inferior al primer natural leído.
n = int(input("introduce el tamaño de la secuencia de números naturales: "))
primero = int(input("Introduce el primer natural: "))
secuencia = []
for i in range(1, n):
    numero = int(input("Introduce un número natural: "))
    secuencia.append(numero)
for numero in secuencia:
    if numero < primero:
        print(f"El primer natural inferior al primero leído ({primero}) es: {numero}")
        break
else:
        print("No hay ningún natural inferior al primero leído.")
#10. Haz un programa que cuente cuántos valores hay en una secuencia de enteros acabada en 0.
contador = 0
numero = int(input("Introduce un número entero (0 para terminar): "))
while numero != 0:
    contador = contador + 1
    numero = int(input("Introduce un número entero (0 para terminar): "))
print(f"Hay {contador} valores en la secuencia.")
#11. Haz un programa que devuelva el máximo de una secuencia de temperaturas acabada en 1000.
numero = float(input("Introduce una temperatura (1000 para terminar): "))
maximo = numero
while numero != 1000:
    if numero > maximo:
        maximo = numero
    numero = float(input("Introduce una temperatura (1000 para terminar): "))   
print(f"La temperatura máxima es: {maximo}")
#12. Haz un programa que dada una secuencia de valores acabada en 0 compruebe que ningún valor supera 50.
numero = float(input("Introduce un número (0 para terminar): "))
supera_50 = False
while numero != 0:
    if numero > 50:
        supera_50 = True
        break
    numero = float(input("Introduce un número (0 para terminar): "))
if supera_50 == False:
    print("Ningún valor supera 50.")
#13. Haz un programa que dada una secuencia de valores acabada en 0 compruebe que ningún valor
#supera 50 y que no hay más de tres que superen 40.
numero = float(input("Introduce un número (0 para terminar): "))
contador_supera_cuarenta = 0
supera_50 = False
while numero != 0:
    if numero > 50:
        supera_50 = True
        break
    if numero > 40:
        contador_supera_cuarenta = contador_supera_cuarenta + 1
        if contador_supera_cuarenta > 3:
            break
    numero = float(input("Introduce un número (0 para terminar): "))
if supera_50 == True:
    print("Hay un valor que supera 50.")
elif contador_supera_cuarenta > 3:
    print("Hay más de tres valores que superan 40.")
else:
    print("Ningún valor supera 50 y no hay más de tres que superen 40.")
#14. Haz un programa que dada una secuencia de valores acabada en 0 diga si hay más positivos o negativos.
numero = float(input("Introduce un número (0 para terminar): "))
contador_positivos = 0
contador_negativos = 0
while numero != 0:
    if numero > 0:
        contador_positivos += 1
    elif numero < 0:
        contador_negativos += 1
    numero = float(input("Introduce un número (0 para terminar): "))
if contador_positivos > contador_negativos:
    print("Hay más positivos.")
elif contador_negativos > contador_positivos:
    print("Hay más negativos.")
#15. Haz un programa que dada una secuencia de valores enteros acabada en 0 diga cuál es el número que hay antes
#de primer negativo encontrado.
numero = int(input("Introduce un número entero (0 para terminar): "))
anterior = None
while numero != 0:
    if numero < 0:
        break
    anterior = numero
    numero = int(input("Introduce un número entero (0 para terminar): "))
if numero < 0:
    if anterior is not None:
        print(f"El número antes del primer negativo es: {anterior}")
    elif anterior is None:
        print("No hay ningún número antes del primer negativo.")
else:
    print("No se ha introducido ningún numero negativo.")
#16. Haz un programa que dada una secuencia de valores enteros acabada en 0 diga cuántos son múltiples del primero.
numero = int(input("Introduce un número entero (0 para terminar): "))
primero = int(input("Introduce el primer número entero de la secuencia: "))
contador_multiplos = 0
while numero != 0:
    if numero % primero == 0:
        contador_multiplos += 1
    numero = int(input("Introduce un número entero (0 para terminar): "))
print(f"Hay {contador_multiplos} números que son múltiplos del primero ({primero}).")

#17. Haz un programa que lea varias descripciones de rectángulos y de círculos,
#  y que para cada una escriba el área correspondiente.
#  La entrada empieza con un número n, seguido de n descripciones.
#  Si es de un rectángulo, se tiene la palabra “rectángulo” seguida de dos
#  reales estrictamente positivos que indican la longitud y la anchura.
#  Si es de un círculo, se tiene la palabra “círculo” seguida de un real estrictamente positivo
#  que indica el radio.
import math
n = int(input("Introduce el número de figuras: "))
for i in range(n):
    tipo_figuras = input("Introduce el tipo de figura (rectángulo/círculo): ")
    if tipo_figuras == "rectangulo":
        longitud = float(input("introduce la longitud del rectángulo: "))
        anchura = float(input("introduce la anchura del rectángulo: "))
        area = longitud * anchura
        print(f"El área del rectángulo es: {area}")
    elif tipo_figuras == "circulo":
        radio = float(input("Introduce el radio del círculo: "))
        area = math.pi * radio ** 2
        print(f"El área del círculo es: {area}")
    else:
        print("Tipo de figura no válido.")

#18. Haz un programa que lea un natural n, y que escriba el resultado de la suma siguiente: 1^2 + 2^2 + … + (n−1)^2 + n^2 y el aspecto de la secuencia. 
n = int(input("Introduce un número natural n: "))
suma = 0
for i in range(1, n + 1):
    suma += i ** 2
print(f"La suma de los cuadrados desde 1 hasta {n} es: {suma}")