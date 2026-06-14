"""
EJERCICIOS TEMA 6 - FUNCIONES
Módulo 2 Python - Escuela Musk
Autor: Álvaro Fernández Mota
Fecha: 5 febrero 2026

Instrucciones: Resuelve cada ejercicio creando las funciones requeridas
"""

# ==============================================================================
# EJERCICIO 1: Filtrar números pares
# ==============================================================================
"""
Haz un programa que cree una función en Python que dada una secuencia 
devuelva únicamente los números pares.

Input: [5, 7, 3, 4, 2, 1]
Output: [4, 2]
"""

# Tu código aquí:
s = [5, 7, 3, 4, 2, 1]
def get_pair(s):
    par = []
    for n in s:
        if n % 2 == 0:
            par.append(n)
    return par

par = get_pair(s)
print(par)




# Prueba tu función:
# numeros = [5, 7, 3, 4, 2, 1]
# resultado = tu_funcion(numeros)
# print(resultado)  # Debe imprimir: [4, 2]


# ==============================================================================
# EJERCICIO 2: Función con argumentos variables (*args)
# ==============================================================================
"""
Haz un programa que cree una función con longitud variable de argumentos.
La función debe imprimir cada argumento recibido.

Input: func1(20, 40, 60)
Output:
20
40
60
"""

# Tu código aquí:
def crear_funcion(*args):
    for i in args:
        print(i)
    
crear_funcion(34, 54, 76, 23)

# Prueba tu función:
# func1(20, 40, 60)


# ==============================================================================
# EJERCICIO 3: Retornar múltiples valores
# ==============================================================================
"""
Haz un programa que devuelva múltiples valores desde una función.
Crea la función calculation() de modo que pueda aceptar dos variables 
y calcular sumas y restas. Además, debe devolver tanto la suma como 
la resta en una sola llamada.
Input: 40, 10
Output: (50, 30)
"""

# Tu código aquí:
def sumar(a, b):
    return a + b
def restar(a, b):
    return a - b
def  calculadora(num1, num2, operacion):
    if operacion == 'sumar':
        return sumar(num1, num2)
    if operacion == 'restar':
        return restar(num1, num2)
resultado1 = calculadora(45, 20, 'sumar')
resultado2 = calculadora(45, 20, 'restar')
print(f"({resultado1}, {resultado2})")

# Prueba tu función:
# resultado = calculation(40, 10)
# print(resultado)  # Debe imprimir: (50, 30)


# ==============================================================================
# EJERCICIO 4: Argumento con valor por defecto
# ==============================================================================
"""
Haz un programa que cree una función con un argumento por defecto.

Crea una función show_employee() usando las siguientes condiciones:
- Debe aceptar el nombre y el salario del empleado y mostrar ambos.
- Si falta el salario en la llamada de función, asigne el valor 
  predeterminado 9000 al salario.

Input:
show_employee("Ben", 12000)
show_employee("Jessa")

Output:
Name: Ben salary: 12000
Name: Jessa salary: 9000
"""

# Tu código aquí:
def show_employee(nombre, salario=9000):
    print(f"Nombre: {nombre}, salario: {salario}")



# Prueba tu función:
# show_employee("Ben", 12000)
# show_employee("Jessa")


# ==============================================================================
# EJERCICIO 5: Funciones anidadas (inner function)
# ==============================================================================
"""
Haz un programa que cree una función interna para calcular la suma 
de la siguiente manera:

- Crea una función externa que acepte dos parámetros, a y b.
- Crea una función interna dentro de una función externa que calculará 
  la suma de a y b.
- Por último, la función externa debe sumar 5 al resultado de la suma 
  y devolverlo.

Input: 5, 10
Output: 20

Nota: 5 + 10 = 15, luego 15 + 5 = 20
"""

# Tu código aquí:
def funcion_interna(a, b):
    def suma():
        a + b
        return a + b
    resultado_interno = suma()
    resultado_final = resultado_interno + 5
    print(f"suma de los numeros + 5: {resultado_final}")
    return resultado_final






# Prueba tu función:
# resultado = outer_fun(5, 10)
# print(resultado)  # Debe imprimir: 20


# ==============================================================================
# EJERCICIO 6: Cuadrado y raíz cuadrada de una lista
# ==============================================================================
"""
Haz un programa que cree dos funciones:
1. Una que calcule el cuadrado de cada número de una lista
2. Otra que calcule la raíz cuadrada de cada número de una lista

Input: [10, 4, 1, 15]

Output:
[100, 16, 1, 225]
[3.1622776601683795, 2.0, 1.0, 3.872983346207417]

Pista: Usa import math y la función math.sqrt()
"""

# Tu código aquí:
# Tu código aquí:
import math  # Importar módulo matemático
math.sqrt(16)   # Raíz cuadrada → 4.0
math.pow(4, 2)  # Potencia → 16.0
math.pi         # Constante pi → 3.14159...

def cuadrado(numeros):
    resultado_cuadrado_num = []
    for numero in numeros:
        cuadrado = numero ** 2
        resultado_cuadrado_num.append(cuadrado)
    return resultado_cuadrado_num
def raiz(numeros):
    resultado_raiz = []
    for numero in numeros:
        raiz = math.sqrt(numero)
        resultado_raiz.append(raiz)
    return resultado_raiz
numeros = [10, 4, 1, 15]
print(cuadrado(numeros))
print(raiz(numeros))

    
# Prueba tus funciones:
# numeros = [10, 4, 1, 15]
# cuadrados = compute_square(numeros)
# raices = compute_sqrt(numeros)
# print(cuadrados)
# print(raices)


# ==============================================================================
# EJERCICIO 7: Ordenar tres valores
# ==============================================================================
"""
Haz un programa que cree una función que ordene tres valores (a, b, c) 
de menor a mayor.

Por ejemplo, si a=7, b=-3 y c=1, los valores después de la llamada 
deben ser a=-3, b=1 y c=7.

Input: 7, -3, 1
Output: [-3, 1, 7]

Pista: Puedes recibir los 3 valores como lista o individualmente, 
y retornar una lista ordenada.
"""


def sort_values(valores):
    return sorted(valores)




# Prueba tu función:
# valores = [7, -3, 1]
# ordenados = sort_values(valores)
# print(ordenados)  # Debe imprimir: [-3, 1, 7]


# ==============================================================================
# NOTAS FINALES
# ==============================================================================
"""
Consejos para resolver los ejercicios:

1. Lee bien el enunciado y entiende qué se pide
2. Piensa en los parámetros que necesita tu función
3. Piensa en qué debe retornar (si es que retorna algo)
4. Escribe primero la estructura básica: def nombre_funcion(parametros):
5. Implementa la lógica dentro de la función
6. Prueba tu función con los casos de ejemplo
7. Si funciona, intenta hacer el código más "pythónico"

¡Éxito con los ejercicios!
"""