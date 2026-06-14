##TIPOS DE DATOS
"""""
STRINGS => SON CADENAS DE TEXTO Y SIEMPRE VAN ENTRE COMILLAS DOBLES O SIMPLES.
NUMEROS:
- ENTEROS (int): Números sin decimales. EJEMPLO: 5, -3, 0.
- FLOTANTES (float): Números con decimales. EJEMPLO: 3.14, -0.001, 2.0.
BOOLEANOS (bool) => SOLO PUEDEN SER TRUE O FALSE. EJEMPLO: True, False.
LISTAS => SON COLECCIONES DE ELEMENTOS QUE PUEDEN SER DE DIFERENTES TIPOS DE DATOS. VAN ENTRE CORCHETES Y LOS ELEMENTOS SE SEPARAN POR COMAS.
EJEMPLO: [1, 2, 3], ['a', 'b', 'c'], [1, 'a', True].
TUPLAS => SON SIMILARES A LAS LISTAS, PERO SON INMUTABLES. VAN ENTRE PARENTESIS Y LOS ELEMENTOS SE SEPARAN POR COMAS.
EJEMPLO: (1, 2, 3), ('a', 'b', 'c'), (1, 'a', True).
DICCIONARIOS => SON COLECCIONES DE PARES CLAVE-VALOR. VAN ENTRE LLAVES Y CADA PAR SE SEPARA POR COMAS. LA CLAVE Y EL VALOR SE SEPARAN POR DOS PUNTOS.
EJEMPLO: {'clave1': 'valor1', 'clave2': 'valor2'}.

"""

#print() - printar
#print(type()) - tipo de dato
#print(type(4))      -   <class 'int'>
#print(type(4.4))    - <class 'float'> 
#print(type(4 + 3j))    -  <class 'complex'>
#print(type(True))    -    <class 'bool'>   
#print(type("Hola"))   -  <class 'str'>   
#print(type([1, 2, 3]))     -  <class 'list'>
#print(type((1, 2, 3)))       -   <class 'tuple'>
#print(type({"clave": "valor"}))   -   <class 'dict'>
""""
VARIABLES   => SON NOMBRES QUE SE UTILIZAN PARA ALMACENAR DATOS EN LA MEMORIA.          
SE ASIGNAN UTILIZANDO EL SIGNO IGUAL (=).
EJEMPLO:    
edad = 25
"""

mi_variable = "Esto es un string"  #snakecase
miVariable = "Esto es un string"   #camelcase   
MiVariable = "Esto es un string"   #pascalcase
# Buenas prácticas:
# - Utilizar nombres descriptivos y significativos.
# - Utilizar minúsculas y guiones bajos para separar palabras (snake_case).
# - Evitar utilizar palabras reservadas del lenguaje como nombres de variables. 
# - No comenzar los nombres de las variables con números.
# - Utilizar nombres cortos pero claros.
# - Evitar utilizar caracteres especiales en los nombres de las variables.
# - Ser consistente con el estilo de nomenclatura a lo largo del código.

mi_variable = "Esto es un string"
print(mi_variable)

otra_variable = "esto tambien es un string"

print(mi_variable + otra_variable)

print(mi_variable , otra_variable)

nombre = "luis"
print("Hola, mi nombre es " + nombre)
print("Hola, mi nombre es", nombre)
edad = 30
print("Hola, mi nombre es " + nombre + " y tengo " + str(edad) + " años.")
#FORMATEAR UNA CADENA DE TEXTO
print(f"Hola, mi nombre es {nombre} y tengo {edad} años.")
print("Hola, mi nombre es {} y tengo {} años.".format(nombre, edad))

deporte , comida = "futbol" , "pizza"
print(f"Me gusta el {deporte} y comer {comida}.")  #DECLARAR VARIABLES EN UNA LINEA 

nombre = "luis martinez"
nombre = input("como te llamas: ")
print("Hola, {nombre}")

#OPERADORES ARITMETICOS
#SUMA (+)               
a = 5
b = 3           
suma = a + b
print("La suma de", a, "y", b, "es:", suma)     
#RESTA (-)
resta = a - b       
print("La resta de", a, "y", b, "es:", resta)
#MULTIPLICACION (*)     
multiplicacion = a * b
print("La multiplicación de", a, "y", b, "es:", multiplicacion)
#DIVISION (/)           
division = a / b            
print("La división de", a, "y", b, "es:", division) 
#DIVISION ENTERA (//)        
division_entera = a // b        
print("La división entera de", a, "y", b, "es:", division_entera)
#MODULO (%)         
modulo = a % b         
print("El módulo de", a, "y", b, "es:", modulo)     
#POTENCIA (**)        
potencia = a ** b
print("La potencia de", a, "elevado a", b, "es:", potencia)

num1 = 10
num2 = 3

print(num1 + num2)  #13
print(num1 - num2)  #7      
print(num1 * num2)  #30
print(num1 / num2)  #3.3333 
print(num1 // num2) #3
print(num1 % num2)  #1
print(num1 ** num2) #1000   

palabra1 = "hola"
palabra2 = "adios"
print(palabra1 + " " + palabra2)  #hola adios
print(palabra1 * 3)  #holaholahola
print((palabra1 + " ") * 3)  #hola hola hola    

#comparacion
x = 10              
y = 5
print(x > y)   #True
print(x < y)   #False
print(x == y)  #False
print(x != y)  #True    
print(x >= y)  #True
print(x <= y)  #False

print("hola" > "adios")  #True
print("hola" < "adios")  #False 