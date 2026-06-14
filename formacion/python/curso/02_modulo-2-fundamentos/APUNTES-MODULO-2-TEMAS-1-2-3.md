# 📚 Apuntes Completos - Módulo 2: Características Básicas (Temas 1-3)

> **Curso:** Python PCAP - Escuela Musk  
> **Alumno:** Álvaro Fernández Mota  
> **Fecha:** Enero 2026  
> **Temas:** 1-3 (Números, Variables/Operadores, Strings)

---

## 📑 Índice

### Tema 1: Números
1. [Tipos numéricos](#tema-1-números)
2. [Operaciones aritméticas](#12-operaciones-aritméticas)
3. [Conversiones de tipo](#13-conversiones-de-tipo)
4. [Funciones matemáticas](#14-funciones-matemáticas)

### Tema 2: Variables y Operadores
5. [Variables](#tema-2-variables-y-operadores)
6. [Operadores](#22-operadores)
7. [Precedencia de operadores](#23-precedencia-de-operadores)
8. [Operadores de asignación](#24-operadores-de-asignación)

### Tema 3: Strings
9. [Cadenas de texto](#tema-3-strings)
10. [Métodos de strings](#32-métodos-de-strings)
11. [Formateo de strings](#33-formateo-de-strings)
12. [Operaciones con strings](#34-operaciones-con-strings)

---

# TEMA 1: Números

## 1.1 Tipos numéricos en Python

### Enteros (int)

Números sin parte decimal, de tamaño ilimitado en Python 3.

```python
# Enteros positivos y negativos
a = 42
b = -17
c = 0

# Números grandes (sin límite)
grande = 999999999999999999999999999999
print(type(grande))  # <class 'int'>

# Diferentes bases numéricas
binario = 0b1010      # Base 2 → 10 en decimal
octal = 0o17          # Base 8 → 15 en decimal
hexadecimal = 0xFF    # Base 16 → 255 en decimal
```

### Flotantes (float)

Números con parte decimal (punto flotante de precisión doble).

```python
# Decimales
pi = 3.14159
temperatura = -12.5

# Notación científica
avogadro = 6.022e23   # 6.022 × 10²³
pequeno = 1.5e-10     # 0.00000000015

print(type(pi))  # <class 'float'>
```

### Números complejos (complex)

Números con parte real e imaginaria.

```python
# Formato: a + bj (j representa √-1)
z1 = 3 + 4j
z2 = complex(2, 5)  # 2 + 5j

# Acceder a partes
print(z1.real)  # 3.0
print(z1.imag)  # 4.0

# Operaciones
z3 = z1 + z2  # (5+9j)
print(type(z3))  # <class 'complex'>
```

---

## 1.2 Operaciones aritméticas

### Operadores básicos

```python
# Suma y resta
resultado = 10 + 5   # 15
diferencia = 10 - 5  # 5

# Multiplicación y división
producto = 10 * 5    # 50
cociente = 10 / 5    # 2.0 (siempre devuelve float)

# División entera (descarta decimales)
div_entera = 10 // 3  # 3
negativa = -10 // 3   # -4 (redondea hacia abajo)

# Módulo (resto de la división)
resto = 10 % 3       # 1
resto2 = -10 % 3     # 2

# Potencia
cuadrado = 2 ** 3    # 8
raiz = 9 ** 0.5      # 3.0 (raíz cuadrada)
```

### Precedencia de operadores aritméticos

```python
# De mayor a menor precedencia:
# 1. Paréntesis ()
# 2. Potencia **
# 3. Multiplicación *, División /, División entera //, Módulo %
# 4. Suma +, Resta -

resultado = 2 + 3 * 4 ** 2      # 2 + 3 * 16 = 2 + 48 = 50
con_parentesis = (2 + 3) * 4    # 5 * 4 = 20
```

---

## 1.3 Conversiones de tipo

### Conversión explícita (casting)

```python
# De float a int (trunca decimales)
entero = int(3.99)      # 3 (no redondea, trunca)
entero2 = int(-2.7)     # -2

# De int a float
flotante = float(5)     # 5.0

# De string a número
numero = int("42")      # 42
decimal = float("3.14") # 3.14

# ❌ Error común
# numero = int("3.14")  # ValueError: no se puede convertir directamente
# Solución:
numero = int(float("3.14"))  # 3

# De número a string
texto = str(42)         # "42"
texto2 = str(3.14)      # "3.14"
```

### Conversión implícita

```python
# Python convierte automáticamente cuando es necesario
resultado = 5 + 2.5   # int + float = float (7.5)
print(type(resultado))  # <class 'float'>

# int + complex = complex
z = 3 + (2+1j)  # (5+1j)
```

---

## 1.4 Funciones matemáticas

### Funciones integradas (built-in)

```python
# Valor absoluto
abs(-10)          # 10
abs(-3.5)         # 3.5

# Redondeo
round(3.7)        # 4
round(3.5)        # 4 (redondeo bancario)
round(2.5)        # 2
round(3.14159, 2) # 3.14 (2 decimales)

# Potencia (alternativa)
pow(2, 3)         # 8 (igual que 2**3)
pow(2, 3, 5)      # 3 (2³ mod 5)

# Máximo y mínimo
max(5, 10, 3)     # 10
min(5, 10, 3)     # 3

# Suma de iterables
sum([1, 2, 3, 4]) # 10
```

### Módulo math

```python
import math

# Constantes
math.pi           # 3.141592653589793
math.e            # 2.718281828459045

# Funciones trigonométricas (en radianes)
math.sin(math.pi/2)   # 1.0
math.cos(0)           # 1.0
math.tan(math.pi/4)   # 1.0

# Raíces y potencias
math.sqrt(16)         # 4.0
math.pow(2, 3)        # 8.0
math.exp(1)           # e¹ = 2.718...

# Logaritmos
math.log(math.e)      # 1.0 (logaritmo natural)
math.log10(100)       # 2.0 (base 10)
math.log(8, 2)        # 3.0 (log₂(8))

# Redondeo especial
math.ceil(3.1)        # 4 (techo)
math.floor(3.9)       # 3 (suelo)
math.trunc(-3.9)      # -3 (truncar)

# Factorial
math.factorial(5)     # 120
```

---

# TEMA 2: Variables y Operadores

## 2.1 Variables

### Declaración y asignación

```python
# Python es de tipado dinámico
x = 10           # int
y = 3.14         # float
nombre = "Ana"   # str
activo = True    # bool

# Reasignación (puede cambiar de tipo)
x = "Hola"      # Ahora x es str
```

### Asignación múltiple

```python
# Asignar mismo valor a múltiples variables
a = b = c = 0

# Asignación simultánea (unpacking)
x, y, z = 1, 2, 3

# Intercambio de valores
a, b = 5, 10
a, b = b, a  # Ahora a=10, b=5
```

### Reglas de nombres

```python
# ✅ VÁLIDOS
mi_variable = 1
_privado = 2
variable123 = 3
camelCase = 4

# ❌ INVÁLIDOS
# 2variable = 1     # No puede empezar con número
# mi-variable = 2   # No puede contener guiones
# class = 3         # Palabra reservada
# mi variable = 4   # No puede contener espacios
```

### Convenciones de estilo (PEP 8)

```python
# snake_case (recomendado para variables y funciones)
edad_usuario = 25
calcular_promedio()

# MAYUSCULAS_SNAKE_CASE (constantes)
PI = 3.14159
MAX_INTENTOS = 3

# PascalCase (clases)
class MiClase:
    pass
```

---

## 2.2 Operadores

### Operadores aritméticos

```python
a, b = 10, 3

print(a + b)   # 13 (suma)
print(a - b)   # 7  (resta)
print(a * b)   # 30 (multiplicación)
print(a / b)   # 3.333... (división)
print(a // b)  # 3  (división entera)
print(a % b)   # 1  (módulo)
print(a ** b)  # 1000 (potencia)
```

### Operadores de comparación

```python
x, y = 5, 10

print(x == y)  # False (igual)
print(x != y)  # True  (diferente)
print(x < y)   # True  (menor que)
print(x > y)   # False (mayor que)
print(x <= y)  # True  (menor o igual)
print(x >= y)  # False (mayor o igual)
```

### Operadores lógicos

```python
# and (y lógico)
print(True and True)    # True
print(True and False)   # False

# or (o lógico)
print(True or False)    # True
print(False or False)   # False

# not (negación)
print(not True)         # False
print(not False)        # True

# Evaluación de cortocircuito
resultado = (5 > 3) and (10 < 20)  # True
resultado = (5 < 3) or (10 > 5)    # True (primera falsa, evalúa segunda)
```

### Operadores de identidad

```python
a = [1, 2, 3]
b = [1, 2, 3]
c = a

print(a is c)      # True (mismo objeto en memoria)
print(a is b)      # False (diferentes objetos)
print(a == b)      # True (mismo contenido)

print(a is not b)  # True
```

### Operadores de pertenencia

```python
lista = [1, 2, 3, 4, 5]

print(3 in lista)       # True
print(10 in lista)      # False
print(10 not in lista)  # True

texto = "Python"
print("Py" in texto)    # True
```

---

## 2.3 Precedencia de operadores

### Orden de evaluación (de mayor a menor)

```python
# 1. Paréntesis ()
# 2. Potencia **
# 3. Unarios +x, -x, not x
# 4. Multiplicación *, /, //, %
# 5. Suma +, Resta -
# 6. Comparación <, <=, >, >=, ==, !=
# 7. is, is not, in, not in
# 8. not
# 9. and
# 10. or

# Ejemplos
resultado = 2 + 3 * 4           # 14 (no 20)
resultado = (2 + 3) * 4         # 20
resultado = 10 > 5 and 3 < 7    # True
resultado = not 5 > 3 or 2 < 1  # False
```

---

## 2.4 Operadores de asignación

### Asignación compuesta

```python
x = 10

# Equivalencias
x += 5   # x = x + 5  → 15
x -= 3   # x = x - 3  → 12
x *= 2   # x = x * 2  → 24
x /= 4   # x = x / 4  → 6.0
x //= 2  # x = x // 2 → 3.0
x %= 2   # x = x % 2  → 1.0
x **= 3  # x = x ** 3 → 1.0

# Con operadores lógicos
estado = True
estado &= False  # estado = estado and False
estado |= True   # estado = estado or True
```

### Operador morsa (walrus) := (Python 3.8+)

```python
# Asignar y evaluar en una sola expresión
if (n := len("Python")) > 5:
    print(f"La longitud es {n}")  # 6

# Útil en bucles
while (linea := input("Escribe algo: ")) != "salir":
    print(f"Escribiste: {linea}")
```

---

# TEMA 3: Strings

## 3.1 Cadenas de texto (strings)

### Creación de strings

```python
# Comillas simples o dobles (equivalentes)
texto1 = 'Hola'
texto2 = "Mundo"

# Comillas triples (multilínea)
poema = """
Rosas son rojas,
Violetas azules,
Python es genial.
"""

# String vacío
vacio = ""
vacio2 = str()
```

### Caracteres especiales (secuencias de escape)

```python
# Salto de línea
print("Línea 1\nLínea 2")

# Tabulación
print("Columna1\tColumna2")

# Comillas dentro de strings
print("Él dijo: \"Hola\"")
print('It\'s Python')

# Barra invertida
print("Ruta: C:\\Users\\nombre")

# Raw string (ignora escapes)
print(r"C:\nueva\carpeta")  # C:\nueva\carpeta
```

### Indexación y slicing

```python
texto = "Python"

# Indexación (empieza en 0)
print(texto[0])    # 'P'
print(texto[2])    # 't'
print(texto[-1])   # 'n' (último)
print(texto[-2])   # 'o' (penúltimo)

# Slicing [inicio:fin:paso]
print(texto[0:3])   # 'Pyt' (0, 1, 2)
print(texto[2:])    # 'thon' (desde 2 hasta el final)
print(texto[:4])    # 'Pyth' (desde inicio hasta 3)
print(texto[::2])   # 'Pto' (cada 2 caracteres)
print(texto[::-1])  # 'nohtyP' (invertir)

# ❌ Los strings son inmutables
# texto[0] = 'J'  # TypeError
```

---

## 3.2 Métodos de strings

### Transformación de mayúsculas/minúsculas

```python
texto = "Hola Mundo"

print(texto.upper())       # 'HOLA MUNDO'
print(texto.lower())       # 'hola mundo'
print(texto.capitalize())  # 'Hola mundo'
print(texto.title())       # 'Hola Mundo'
print(texto.swapcase())    # 'hOLA mUNDO'
```

### Búsqueda y verificación

```python
texto = "Python es genial"

# Encontrar substring
print(texto.find("es"))       # 7 (índice donde empieza)
print(texto.find("Java"))     # -1 (no encontrado)
print(texto.index("es"))      # 7
# print(texto.index("Java"))  # ValueError

# Contar ocurrencias
print(texto.count("e"))       # 2

# Verificar inicio/fin
print(texto.startswith("Py")) # True
print(texto.endswith("al"))   # True
```

### Validación de contenido

```python
print("123".isdigit())      # True
print("abc".isalpha())      # True
print("abc123".isalnum())   # True
print("Hola".islower())     # False
print("HOLA".isupper())     # True
print("   ".isspace())      # True
print("Hola Mundo".istitle()) # True
```

### Modificación y limpieza

```python
texto = "  Hola Mundo  "

# Eliminar espacios
print(texto.strip())    # 'Hola Mundo' (ambos lados)
print(texto.lstrip())   # 'Hola Mundo  ' (izquierda)
print(texto.rstrip())   # '  Hola Mundo' (derecha)

# Reemplazar
print(texto.replace("Mundo", "Python"))  # '  Hola Python  '
print("banana".replace("a", "o", 2))     # 'bonona' (max 2)

# Dividir y unir
palabras = "Hola,Mundo,Python".split(",")  # ['Hola', 'Mundo', 'Python']
print("-".join(palabras))  # 'Hola-Mundo-Python'

# Centrar, alinear
print("Hola".center(10))     # '  Hola   '
print("Hola".ljust(10, '-')) # 'Hola------'
print("Hola".rjust(10, '*')) # '******Hola'
```

---

## 3.3 Formateo de strings

### Operador %

```python
nombre = "Ana"
edad = 25

# %s (string), %d (entero), %f (float)
print("Hola, %s. Tienes %d años." % (nombre, edad))
print("Pi = %.2f" % 3.14159)  # 'Pi = 3.14'
```

### Método .format()

```python
nombre = "Carlos"
edad = 30

# Por posición
print("Hola, {}. Tienes {} años.".format(nombre, edad))

# Por índice
print("{0} tiene {1} años. {0} es programador.".format(nombre, edad))

# Por nombre
print("Hola, {n}. Tienes {e} años.".format(n=nombre, e=edad))

# Formateo de números
print("Pi = {:.2f}".format(3.14159))  # 'Pi = 3.14'
print("{:,}".format(1000000))         # '1,000,000'
```

### f-strings (Python 3.6+) ⭐ Recomendado

```python
nombre = "Laura"
edad = 28

# Sintaxis: f"texto {variable}"
print(f"Hola, {nombre}. Tienes {edad} años.")

# Expresiones dentro de {}
print(f"El próximo año tendrás {edad + 1} años.")
print(f"2 + 2 = {2 + 2}")

# Formateo
pi = 3.14159
print(f"Pi = {pi:.2f}")           # 'Pi = 3.14'
print(f"Número: {1000000:,}")     # 'Número: 1,000,000'

# Alineación y relleno
print(f"{nombre:>10}")            # '     Laura'
print(f"{nombre:^10}")            # '  Laura   '
print(f"{nombre:-<10}")           # 'Laura-----'

# Debug (Python 3.8+)
x = 42
print(f"{x=}")  # 'x=42'
```

---

## 3.4 Operaciones con strings

### Concatenación

```python
# Con operador +
saludo = "Hola" + " " + "Mundo"  # 'Hola Mundo'

# Con +=
mensaje = "Hola"
mensaje += " Mundo"  # 'Hola Mundo'

# Concatenación automática de literales
texto = "Hola " "Mundo"  # 'Hola Mundo'
```

### Repetición

```python
print("Ha" * 3)      # 'HaHaHa'
print("-" * 20)      # '--------------------'

linea = "=" * 10
print(linea)         # '=========='
```

### Longitud

```python
texto = "Python"
print(len(texto))    # 6

vacio = ""
print(len(vacio))    # 0
```

### Iteración

```python
# Recorrer caracteres
for letra in "Python":
    print(letra, end=" ")  # P y t h o n

# Con enumerate (índice y valor)
for i, letra in enumerate("Python"):
    print(f"{i}: {letra}")
```

### Comparación

```python
# Comparación lexicográfica (orden alfabético)
print("abc" < "xyz")       # True
print("Python" == "python") # False (case-sensitive)
print("10" < "2")          # True (compara como strings)

# Comparación sin distinción de mayúsculas
print("Python".lower() == "python".lower())  # True
```

---

## 🎯 Resumen Temas 1-3

### Conceptos clave aprendidos

#### Tema 1: Números
✅ Tipos numéricos: int, float, complex  
✅ Operaciones aritméticas: +, -, *, /, //, %, **  
✅ Conversiones: int(), float(), str()  
✅ Módulo math para funciones avanzadas  

#### Tema 2: Variables y Operadores
✅ Variables de tipado dinámico  
✅ Operadores: aritméticos, comparación, lógicos, identidad, pertenencia  
✅ Precedencia de operadores  
✅ Asignación compuesta (+=, -=, etc.)  

#### Tema 3: Strings
✅ Strings inmutables  
✅ Indexación y slicing  
✅ Métodos: upper(), lower(), replace(), split(), join()  
✅ Formateo: f-strings (recomendado)  
✅ Operaciones: concatenación, repetición, comparación  

---

## 💡 Ejercicios recomendados

### Tema 1: Números
1. Crear calculadora básica con +, -, *, /
2. Convertir temperaturas (Celsius ↔ Fahrenheit)
3. Calcular área y perímetro de figuras geométricas

### Tema 2: Variables y Operadores
1. Intercambiar valores de dos variables sin variable auxiliar
2. Determinar si un número es par o impar usando %
3. Evaluar expresiones lógicas complejas

### Tema 3: Strings
1. Invertir un string sin usar [::-1]
2. Contar vocales en una frase
3. Crear un formateador de nombres (capitalizar correctamente)

---

## 📚 Recursos adicionales

### Documentación oficial
- [Built-in Types - Numeric](https://docs.python.org/3/library/stdtypes.html#numeric-types-int-float-complex)
- [Built-in Types - String Methods](https://docs.python.org/3/library/stdtypes.html#string-methods)
- [math Module](https://docs.python.org/3/library/math.html)

### Práctica
- [Python String Exercises - W3Schools](https://www.w3schools.com/python/python_strings_exercises.asp)
- [Python Operators - Real Python](https://realpython.com/python-operators-expressions/)

---

## ✅ Checklist de verificación

### Tema 1
- [ ] Diferenciar int, float y complex
- [ ] Usar operadores aritméticos correctamente
- [ ] Realizar conversiones de tipo
- [ ] Importar y usar módulo math

### Tema 2
- [ ] Declarar variables siguiendo convenciones
- [ ] Aplicar operadores de comparación y lógicos
- [ ] Entender precedencia de operadores
- [ ] Usar asignación compuesta

### Tema 3
- [ ] Crear y manipular strings
- [ ] Usar indexación y slicing
- [ ] Aplicar métodos de strings comunes
- [ ] Formatear strings con f-strings
- [ ] Realizar operaciones básicas (concatenar, repetir)

---

**🚀 ¡Temas 1-3 completados! Continuar con Tema 4: Condicionales y bucles →**