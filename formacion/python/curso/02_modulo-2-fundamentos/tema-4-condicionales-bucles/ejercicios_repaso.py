

# EJERCICIO R1: Clasificador de números
#
# Haz un programa que lea exactamente 8 números enteros y muestre:
# - Cuántos son PARES y cuántos IMPARES
# - Cuántos son POSITIVOS, NEGATIVOS y CEROS
# - El MAYOR de todos los números leídos
#
# EJEMPLO DE EJECUCIÓN:
# Número 1: 5
# Número 2: -3
# Número 3: 0
# Número 4: 8
# Número 5: -7
# Número 6: 12
# Número 7: 0
# Número 8: 4
#
# SALIDA ESPERADA:
# Pares: 4
# Impares: 4
# Positivos: 4
# Negativos: 2
# Ceros: 2
# Mayor: 12
#
# PISTAS:
# - Usa un bucle for con range(8)
# - Necesitas 5 contadores: pares, impares, positivos, negativos, ceros
# - Para el máximo, inicialízalo con el primer número leído
# - Recuerda: un número es par si numero % 2 == 0
mayor = None
contador_pares = 0
contador_impares = 0
contador_positivos = 0
contador_negativos = 0
contador_ceros = 0
for i in range(8):
    numero = int(input(f"Número {i + 1}: "))
    if numero % 2 == 0:
        contador_pares += 1
    else:
        contador_impares += 1
    if numero > 0:
        contador_positivos += 1
    elif numero < 0:
        contador_negativos += 1
    else:
        contador_ceros += 1
    if mayor is None or numero > mayor:
        mayor = numero  
print(f"Pares: {contador_pares}")
print(f"Impares: {contador_impares}")
print(f"Positivos: {contador_positivos}")
print(f"Negativos: {contador_negativos}")
print(f"Ceros: {contador_ceros}")
print(f"Mayor: {mayor}")


# EJERCICIO R2: Secuencia hasta encontrar múltiplo
#
# Haz un programa que:
# 1. Lea un número entero positivo N
# 2. Luego lea una secuencia de números acabada en 0 (centinela)
# 3. Muestre el PRIMER número de la secuencia que sea múltiplo de N
# 4. Si NO hay ningún múltiplo, debe mostrar un mensaje indicándolo
# 5. Al final, muestre cuántos números se leyeron antes de terminar
#    (sin contar el centinela 0 ni el N inicial)
#
# EJEMPLO DE EJECUCIÓN:
N = int(input("Introduce N: "))
contador_numeros = 0
encontrado = False  
primer_multiplo = None  
numero = int(input("Número (0 para terminar): "))
while numero != 0:
    contador_numeros += 1
    if encontrado == False and numero % N == 0:
        primer_multiplo = numero
        encontrado = True
        break
    numero = int(input("Número (0 para terminar): "))
if encontrado == False:
    print(f"No se encontró ningún múltiplo de {N}.")
else:
    print(f"El primer múltiplo de {N} es: {primer_multiplo}")
print(f"Números leídos antes de terminar: {contador_numeros}")

# EJERCICIO R3: Validador de secuencia creciente
#
# Haz un programa que lea una secuencia de números acabada en -1 (centinela)
# y verifique si la secuencia es ESTRICTAMENTE CRECIENTE
# (cada número es mayor que el anterior).
#
# El programa debe mostrar:
# - "La secuencia es creciente" si todos los números son mayores que el anterior
# - "La secuencia NO es creciente" en caso contrario
# - Si solo se introduce un número (o ninguno), debe indicar
#   "No hay suficientes números para comparar"
# EJEMPLO DE EJECUCIÓN:
anterior = None
creciente = True
contador = 0
numero = int(input("Número (-1 para terminar): "))
while numero != -1:
    contador += 1
    if anterior is not None and numero <= anterior:
        creciente = False      
        break       
    anterior = numero
    numero = int(input("Número (-1 para terminar): "))
if contador < 2:
    print("No hay suficientes números para comparar")   
elif creciente:
    print("La secuencia es creciente")  
else:
    print("La secuencia NO es creciente")
    #SE ME DA MAS O MENOS 

# EJERCICIO R4: Calculadora de estadísticas
#
# Haz un programa que lea números decimales (float) acabados en 0 (centinela)
# y calcule:
# - La SUMA de todos los números
# - El PROMEDIO (media aritmética)
# - Cuántos números son MAYORES que el promedio
#
# NOTA: Debes leer todos los números primero, calcular el promedio,
# y luego volver a recorrer para contar cuántos son mayores que el promedio.
#
# EJEMPLO DE EJECUCIÓN:
# Número (0 para terminar): 5.5
# Número (0 para terminar): 8.0
# Número (0 para terminar): 3.2
# Número (0 para terminar): 9.1
# Número (0 para terminar): 6.7
# Número (0 para terminar): 0
#
# Suma: 32.5
# Promedio: 6.5
# Números mayores que el promedio: 3
#
# EXPLICACIÓN:
# - Números: 5.5, 8.0, 3.2, 9.1, 6.7
# - Suma = 5.5 + 8.0 + 3.2 + 9.1 + 6.7 = 32.5
# - Promedio = 32.5 / 5 = 6.5
# - Mayores que 6.5: 8.0, 9.1, 6.7 → 3 números
#
# PISTAS:
# - Usa centinela 0
# - Usa una LISTA para almacenar todos los números
# - append() para guardar en la lista
# - Primer bucle: leer y guardar
# - Calcular suma con sum() o con bucle
# - Calcular promedio: suma / len(lista)
# - Segundo bucle: recorrer lista y contar mayores que promedio
numero = float(input("Número (0 para terminar): "))
numeros = []
contador = 0
suma = 0
promedio = 0
while numero != 0:
    numeros.append(numero)
    numero = float(input("Número (0 para terminar): "))
suma = sum(numeros)
promedio = suma / len(numeros)
for numero in numeros:
    if numero > promedio:
        contador += 1
print(f"Suma: {suma}")
print(f"Promedio: {promedio}")
print(f"Números mayores que el promedio: {contador}")

# EJERCICIO N1: Mi Primer Menú
#
# Haz un programa que muestre un menú de opciones de una cafetería
# y permita al usuario elegir repetidamente hasta que decida salir.
#
# El programa debe:
# 1. Mostrar un menú con 4 opciones de bebidas y una opción para salir
# 2. Leer la elección del usuario
# 3. Mostrar un mensaje confirmando la elección
# 4. Repetir el menú hasta que el usuario elija salir (opción 0)
# 5. Si el usuario introduce una opción inválida, mostrar mensaje de error
#
# EJEMPLO DE EJECUCIÓN:
#
# === CAFETERÍA PYTHON ===
# 1. Café ☕
# 2. Té 🍵
# 3. Chocolate caliente 🍫
# 4. Zumo de naranja 🍊
# 0. Salir
# Elige tu bebida: 1
#
# ✅ Has pedido: Café ☕
#
# === CAFETERÍA PYTHON ===
# 1. Café ☕
# 2. Té 🍵
# 3. Chocolate caliente 🍫
# 4. Zumo de naranja 🍊
# 0. Salir
# Elige tu bebida: 3
#
# ✅ Has pedido: Chocolate caliente 🍫
#
# === CAFETERÍA PYTHON ===
# 1. Café ☕
# 2. Té 🍵
# 3. Chocolate caliente 🍫
# 4. Zumo de naranja 🍊
# 0. Salir
# Elige tu bebida: 7
#
# ❌ Opción no válida. Intenta de nuevo.
#
# === CAFETERÍA PYTHON ===
# 1. Café ☕
# 2. Té 🍵
# 3. Chocolate caliente 🍫
# 4. Zumo de naranja 🍊
# 0. Salir
# Elige tu bebida: 0
#
# 👋 ¡Gracias por tu visita! ¡Hasta pronto!
#
# PISTAS:
# - Usa while True: para crear el bucle infinito
# - Usa input() para leer la opción del usuario (como string)
# - Usa if/elif/else para procesar cada opción
# - Usa break cuando el usuario elija la opción 0
# - El else captura las opciones inválidas
# - Usa print("\n") o print() vacío para dejar espacio entre iteraciones

# TU CÓDIGO AQUÍ:

while True:
    print("\n=== CAFETERÍA PYTHON ===")
    print("1. Café ☕")
    print("2. Té 🍵")
    print("3. Chocolate caliente 🍫")
    print("4. Zumo de naranja 🍊")
    print("0. Salir")
    opcion = int(input("Elige tu bebida:(introduce 0 para salir) "))
    if opcion == 1:
        print("\n✅ Has pedido: Café ☕")
    elif opcion == 2:
        print("\n✅ Has pedido: Té 🍵")
    elif opcion == 3:
        print("\n✅ Has pedido: Chocolate caliente 🍫")
    elif opcion == 4:
        print("\n✅ Has pedido: Zumo de naranja 🍊")
    elif opcion == 0:
        print("\n👋 ¡Gracias por tu visita! ¡Hasta pronto!")
        break
    else:
        print("\n❌ Opción no válida. Intenta de nuevo.")
    


    # EJERCICIO N2: Calculadora Matemática con import math
#
# Haz un programa que realice cálculos matemáticos usando el módulo math.
#
# El programa debe:
# 1. Pedir al usuario que elija una operación matemática
# 2. Pedir los datos necesarios (números, radio, etc.)
# 3. Realizar el cálculo usando funciones de math
# 4. Mostrar el resultado con 2 decimales
#
# OPERACIONES A IMPLEMENTAR:
# - Calcular el área de un círculo (π * radio²)
# - Calcular la raíz cuadrada de un número
# - Calcular la potencia (base^exponente)
# - Calcular la hipotenusa de un triángulo (teorema de Pitágoras)
#
# EJEMPLO DE EJECUCIÓN:
#
# === CALCULADORA MATEMÁTICA ===
# 1. Área de un círculo
# 2. Raíz cuadrada
# 3. Potencia
# 4. Hipotenusa (Pitágoras)
# Elige operación: 1
#
# Introduce el radio: 5
# El área del círculo es: 78.54
#
# === CALCULADORA MATEMÁTICA ===
# 1. Área de un círculo
# 2. Raíz cuadrada
# 3. Potencia
# 4. Hipotenusa (Pitágoras)
# Elige operación: 2
#
# Introduce el número: 25
# La raíz cuadrada de 25 es: 5.00
#
# === CALCULADORA MATEMÁTICA ===
# 1. Área de un círculo
# 2. Raíz cuadrada
# 3. Potencia
# 4. Hipotenusa (Pitágoras)
# Elige operación: 3
#
# Introduce la base: 2
# Introduce el exponente: 3
# 2 elevado a 3 es: 8.00
#
# === CALCULADORA MATEMÁTICA ===
# 1. Área de un círculo
# 2. Raíz cuadrada
# 3. Potencia
# 4. Hipotenusa (Pitágoras)
# Elige operación: 4
#
# Introduce cateto a: 3
# Introduce cateto b: 4
# La hipotenusa es: 5.00
#
# PISTAS:
# - Usa import math al principio del archivo (línea 1)
# - math.pi → constante π (3.14159...)
# - math.sqrt(numero) → raíz cuadrada
# - math.pow(base, exponente) → potencia (también puedes usar base ** exponente)
# - Fórmula área círculo: π * radio²
# - Fórmula Pitágoras: hipotenusa = √(a² + b²)
# - Para formatear con 2 decimales: {variable:.2f}
# - NO necesitas while True ni break para este ejercicio
# - Es un programa que ejecuta UNA operación y termina

# TU CÓDIGO AQUÍ:
import math
math.pi - 3.1415926535
# - math.pi → constante π (3.14159...)
# - math.sqrt(numero) → raíz cuadrada
# - math.pow(base, exponente) → potencia (también puedes usar base ** exponente)
# - Fórmula área círculo: π * radio²
# - Fórmula Pitágoras: hipotenusa = √(a² + b²)
# - Para formatear con 2 decimales: {variable:.2f}
import math
while True:
    print("\n=== CALCULADORA MATEMÁTICA ===")
    print("1. Área de un círculo")
    print("2. Raíz cuadrada")
    print("3. Potencia")
    print("4. Hipotenusa (Pitágoras)")
    print("0. Salir")
    operacion = int(input("Elige operación: "))
    if operacion == 1:
        radio = float(input("Introduce el radio: "))
        area = math.pi * math.pow(radio, 2)
        print(f"El área del círculo es: {area:.2f}")
    elif operacion == 2:
        numero = float(input("Introduce el número: "))
        raiz = math.sqrt(numero)
        print(f"La raíz cuadrada de {numero} es: {raiz:.2f}")
    elif operacion == 3:
        base = float(input("Introduce la base: "))
        exponente = float(input("Introduce el exponente: "))
        potencia = math.pow(base, exponente)
        print(f"{base} elevado a {exponente} es: {potencia:.2f}")
    elif operacion == 4:
        cateto_a = float(input("Introduce cateto a: "))
        cateto_b = float(input("Introduce cateto b: "))
        hipotenusa = math.sqrt(math.pow(cateto_a, 2) + math.pow(cateto_b, 2))
        print(f"La hipotenusa es: {hipotenusa:.2f}")
    elif operacion == 0:
        print("\n👋 ¡Gracias por usar la calculadora! ¡Hasta pronto!")
        break
    else:
        print("\n❌ Opción no válida. Intenta de nuevo.")



# EJERCICIO N3: Calculadora Geométrica Completa (Menú + Math)
#
# Haz un programa que combine TODO lo aprendido: menú repetitivo + import math.
#
# El programa debe:
# 1. Mostrar un menú con 5 opciones de cálculos geométricos
# 2. Permitir al usuario elegir repetidamente hasta que decida salir
# 3. Para cada opción, pedir los datos necesarios
# 4. Realizar el cálculo usando math cuando sea necesario
# 5. Mostrar el resultado con 2 decimales
# 6. Repetir el menú hasta que el usuario elija salir (opción 0)
#
# OPCIONES DEL MENÚ:
# 1. Área de un círculo (π * r²)
# 2. Perímetro de un círculo (2 * π * r)
# 3. Área de un cuadrado (lado²)
# 4. Área de un rectángulo (base * altura)
# 5. Hipotenusa de un triángulo (teorema de Pitágoras)
# 0. Salir
#
# EJEMPLO DE EJECUCIÓN:
#
# === CALCULADORA GEOMÉTRICA ===
# 1. Área de un círculo
# 2. Perímetro de un círculo
# 3. Área de un cuadrado
# 4. Área de un rectángulo
# 5. Hipotenusa (Pitágoras)
# 0. Salir
# Elige operación: 1
#
# Introduce el radio: 5
# ✅ El área del círculo es: 78.54
#
# === CALCULADORA GEOMÉTRICA ===
# 1. Área de un círculo
# 2. Perímetro de un círculo
# 3. Área de un cuadrado
# 4. Área de un rectángulo
# 5. Hipotenusa (Pitágoras)
# 0. Salir
# Elige operación: 4
#
# Introduce la base: 10
# Introduce la altura: 5
# ✅ El área del rectángulo es: 50.00
#
# === CALCULADORA GEOMÉTRICA ===
# 1. Área de un círculo
# 2. Perímetro de un círculo
# 3. Área de un cuadrado
# 4. Área de un rectángulo
# 5. Hipotenusa (Pitágoras)
# 0. Salir
# Elige operación: 0
#
# 👋 ¡Gracias por usar la calculadora! ¡Hasta pronto!
#
# PISTAS:
# - Usa import math al principio
# - Usa while True para el menú repetitivo
# - Usa break para salir cuando elijan 0
# - Fórmulas:
#   * Área círculo: math.pi * radio ** 2
#   * Perímetro círculo: 2 * math.pi * radio
#   * Área cuadrado: lado ** 2
#   * Área rectángulo: base * altura
#   * Hipotenusa: math.sqrt(cateto_a ** 2 + cateto_b ** 2)
# - Usa {variable:.2f} para 2 decimales
# - Añade mensajes con ✅ para las respuestas

# TU CÓDIGO AQUÍ:


import math
while True:
    print("\n=== CALCULADORA GEOMETRICA ===")
    print("1. Área de un círculo")
    print("2. Perímetro de un círculo")
    print("3. Área de un cuadrado") 
    print("4. Área de un rectángulo")
    print("5. Hipotenusa (Pitágoras)")
    print("0. Salir")
    operacion = int(input("Elige operación: "))
    if operacion == 1:
        radio = float(input("Introduce el radio: "))
        area = math.pi * math.pow(radio, 2)
        print(f"✅ El área del círculo es: {area:.2f}")
    elif operacion == 2:
        radio = float(input("Introduce el radio: "))
        perimetro = 2 * math.pi * radio
        print(f"✅ El perímetro del círculo es: {perimetro:.2f}")
    elif operacion == 3:
        lado = float(input("Introduce el lado: "))
        area = math.pow(lado, 2)
        print(f"✅ El área del cuadrado es: {area:.2f}")
    elif operacion == 4:
        base = float(input("Introduce la base: "))
        altura = float(input("Introduce la altura: "))
        area = base * altura
        print(f"✅ El área del rectángulo es: {area:.2f}")
    elif operacion == 5:
        cateto_a = float(input("Introduce cateto a: "))
        cateto_b = float(input("Introduce cateto b: "))
        hipotenusa = math.sqrt(math.pow(cateto_a, 2) + math.pow(cateto_b, 2))
        print(f"✅ La hipotenusa es: {hipotenusa:.2f}")
    elif operacion == 0:
        print("\n👋 ¡Gracias por usar la calculadora! ¡Hasta pronto!")
        break
    else:
        print("\n❌ Opción no válida. Intenta de nuevo.")

    