## 📋 EJERCICIO T1-E1: Herencia Simple
## Enunciado:
## Crea una clase Staff con los atributos role, dept y salary.
## Crea una clase Profesor que herede de la clase anterior y que además tenga como atributos nombre y edad.
## Haz que sea posible instanciar un profesor dándole valor a todos los atributos.

class Staff:
    def __init__(self, role, dept,salary):
        self.role = role
        self.dept = dept
        self.salary = salary
        pass

class Profesor(Staff):
    def __init__(self, role, dept, salary, nombre, edad):
        super().__init__(role, dept, salary)
        self.nombre = nombre
        self.edad = edad

if __name__ == "__main__":
    profesor1 = Profesor("Profesor", "Matemáticas", 3000, "Juan Pérez", 45)
    print(f"Nombre: {profesor1.nombre}, Edad: {profesor1.edad}, Rol: {profesor1.role}, Departamento: {profesor1.dept}, Salario: {profesor1.salary}")

## 📋 EJERCICIO T1-E2: Herencia Múltiple
## Enunciado:
## Representa el siguiente diagrama con sus clases, atributos y métodos correspondientes.
## Cada método display() debe imprimir el nombre de la clase, atributos y valores de la instancia en ese momento.
## Ejemplo: In display method of Parent1, x = 10
"""
┌─────────────┐         ┌─────────────┐
│  Parent1    │         │  Parent2    │
├─────────────┤         ├─────────────┤
│ - x: int    │         │ - y: int    │
├─────────────┤         ├─────────────┤
│ + display() │         │ + display() │
└─────────────┘         └─────────────┘
       ▲                       ▲
       │                       │
       └───────────┬───────────┘
                   │
            ┌─────────────┐
            │   Child     │
            ├─────────────┤
            │ - x (here)  │
            │ - y (here)  │
            │ - z (propio)│
            ├─────────────┤
            │ + display() │
            └─────────────┘
"""
class Parent1:
    def __init__(self, x):
        self.x = x

    def display(self):
        print(f"In display method of Parent1, x = {self.x}")
        
class Parent2:
    def __init__(self, y):
        self.y = y

    def display(self):
        print(f"In display method of Parent2, y = {self.y}")

class Child(Parent1, Parent2):
    def __init__(self, x, y, z):
        Parent1.__init__(self, x)
        Parent2.__init__(self, y)
        self.z = z

    def display(self):
        print(f"In display method of Child, x = {self.x}, y = {self.y}, z = {self.z}")

if __name__ == "__main__":
    parent1 = Parent1(10)
    parent2 = Parent2(20)
    child = Child(10, 20, 30)
    parent1.display()
    parent2.display()
    child.display()
    print(f"\n{isinstance(child, Parent1)}")
    print(f"{isinstance(child, Parent2)}")

## 📋 EJERCICIO T1-E3: Sobreescritura de métodos
## Enunciado:
## Crea una clase Car que herede de Vehicle y que sobreescriba los métodos max_speed() y change_gear().
## Instancia dos objetos de cada clase y comprueba que la salida de cada método es distinta.

class Vehicle:
    def __init__(self, name, color, price):
        self.name = name
        self.color = color
        self.price = price

    def show(self):
        print('Details:', self.name, self.color, self.price)

    def max_speed(self):
        print('Vehicle max speed is 150')

    def change_gear(self):
        print('Vehicle change 6 gear')

class Car(Vehicle):
    def max_speed(self):
        print('Car max speed is 200')

    def change_gear(self):
        print('Car change 8 gear')

    def show(self):
        print('Details:', self.name, self.color, self.price, 'This is a car')

if __name__ == "__main__":
    vehicle1 = Vehicle("Vehicle1", "Red", 10000)
    vehicle2 = Vehicle("Vehicle2", "Blue", 15000)
    car1 = Car("Car1", "Black", 20000)
    car2 = Car("Car2", "White", 25000)

    vehicle1.show()
    vehicle1.max_speed()
    vehicle1.change_gear()

    vehicle2.show()
    vehicle2.max_speed()
    vehicle2.change_gear()

    car1.show()
    car1.max_speed()
    car1.change_gear()

    car2.show()
    car2.max_speed()
    car2.change_gear()

## TEMA 2 - CLASES ABSTRACTAS / INTERFACES
## T2-E1: Interfaz Formal (SVM y DecisionTree)
## Enunciado: Dadas las siguientes clases con el output
## de sus respectivos métodos, crea una interfaz formal que las implemente.
"""
svm = SVM()
svm.preprocess_data(data=None, y=None)
svm.fit()
svm.predict()

dt = DecisionTree()
dt.preprocess_data(data=None, y=None)
dt.fit()
dt.predict()

 Output esperado:

Preprocessing data at SVM
Training at SVM
Evaluating at SVM
Preprocessing data at DecisionTree
Training at DecisionTree
Evaluating at DecisionTree
"""
from abc import ABC, abstractmethod

class BaseClassifier(ABC):
    @abstractmethod
    def preprocess_data(self, data, y):
        pass

    @abstractmethod
    def fit(self):
        pass

    @abstractmethod
    def predict(self):
        pass

class SVM(BaseClassifier):
    def preprocess_data(self, data, y):
        print("Preprocessing data at SVM")

    def fit(self):
        print("Training at SVM")

    def predict(self):
        print("Evaluating at SVM")

class DecisionTree(BaseClassifier):
    def preprocess_data(self, data, y):
        print("Preprocessing data at DecisionTree")

    def fit(self):
        print("Training at DecisionTree")

    def predict(self):
        print("Evaluating at DecisionTree")

## 📋 EJERCICIO T2-E2: Interfaz Informal
## Enunciado:
## Repite el ejercicio anterior esta vez creando una interfaz informal (sin
## usar ABC ni @abstractmethod).
class BaseClassifier:
    def preprocess_data(self, data, y):
        raise NotImplementedError("Subclasses must implement this method")

    def fit(self):
        raise NotImplementedError("Subclasses must implement this method")
    def predict(self):
        raise NotImplementedError("Subclasses must implement this method")

class SVM(BaseClassifier):
    def preprocess_data(self, data, y):
        print("Preprocessing data at SVM")

    def fit(self):
        print("Training at SVM")

    def predict(self):
        print("Evaluating at SVM")

class DecisionTree(BaseClassifier):
    def preprocess_data(self, data, y):
        print("Preprocessing data at DecisionTree")

    def fit(self):
        print("Training at DecisionTree")

    def predict(self):
        print("Evaluating at DecisionTree")

if __name__ == "__main__":
    svm = SVM()
    svm.preprocess_data(data=None, y=None)
    svm.fit()
    svm.predict()

    dt = DecisionTree()
    dt.preprocess_data(data=None, y=None)
    dt.fit()
    dt.predict()

## 📋T2-E3
## Enunciado: Crea una clase virtual llamada Algoritmo con los atributos nombre,
## tarea y aprendizaje que sea superclase de BaseClssifier.
## Comprueba con issubclass() que Algoritmo es padre de BaseClassifier.

class Algoritmo:
    def __init__(self, nombre, tarea, aprendizaje):
        self.nombre = nombre
        self.tarea = tarea
        self.aprendizaje = aprendizaje

class BaseClassifier(Algoritmo):
    def preprocess_data(self, data, y):
        raise NotImplementedError("Subclasses must implement this method")

    def fit(self):
        raise NotImplementedError("Subclasses must implement this method")
    def predict(self):
        raise NotImplementedError("Subclasses must implement this method")
    
if __name__ == "__main__":
    print(issubclass(BaseClassifier, Algoritmo))


## Módulo 5 - Tema 1
## EJERCICIO 1: Formatos de fecha y hora
## Enunciado: Escribe un script en Python para mostrar los distintos formatos de fecha y hora:
## a) Fecha y hora actuales
## b) Año actual
## c) Mes del año
## d) Número de la semana del año
## e) Día de la semana
## f) Día del año
## g) Día del mes
## h) Día de la semana
import datetime
now = datetime.datetime.now()
print(f"Fecha y hora actuales: {now}")
print(f"Año actual: {now.year}")
print(f"Mes del año: {now.month}")
print(f"Número de la semana del año: {now.isocalendar()[1]}")
print(f"Día de la semana: {now.weekday()}")
print(f"Día del año: {now.timetuple().tm_yday}")
print(f"Día del mes: {now.day}")
print(f"Día de la semana: {now.strftime('%A')}")


## 📋 M5 - T1 - EJERCICIO 2
## Enunciado:
## Escribe un programa en Python para convertir una cadena a datetime.
""""
INPUT  : Jan 1 2014 2:43PM
OUTPUT : 2014-01-01 14:43:00
"""
from datetime import datetime

date_string = "Jan 1 2014 2:43PM"
date_object = datetime.strptime(date_string, "%b %d %Y %I:%M%p")
print(f"date_object: {date_object}")


## 📋 M5 - T1 - EJERCICIO 3
## Enunciado:
## Escribe un programa en Python para obtener la hora actual.
from datetime import datetime

now = datetime.now()
print(f"Hora actual: {now.time()}")


## 📋 M5 - T1 - EJERCICIO 4
## Enunciado:
## Escribe un programa en Python para restar cinco días a la fecha actual.
from datetime import datetime, timedelta 
now = datetime.now()
five_days_ago = now - timedelta(days=5)
print(f"Fecha actual: {now}")
print(f"Fecha hace cinco días: {five_days_ago}")

## 📋 M5 - T1 - EJERCICIO 5
## Enunciado:
## Convierte una cadena de timestamp Unix en una fecha legible.
from datetime import datetime
timestamp = 1284105682
date_object = datetime.fromtimestamp(timestamp)
print(f"Fecha legible: {date_object}")


## 📋 M5 - T1 - EJERCICIO 6
## Enunciado:
## Escribe un programa en Python para sumar 5 segundos a la hora actual.
from datetime import datetime, timedelta
now = datetime.now()
five_seconds_later = now + timedelta(seconds=5)
print(f"Hora actual: {now}")
print(f"Hora dentro de cinco segundos: {five_seconds_later}")

## 📋 M5 - T1 - EJERCICIO 7
## Enunciado:
## Escribe un programa en Python para obtener el número de la semana.
from datetime import datetime
now = datetime.now()
week_number = now.isocalendar()[1]
print(f"La fecha es {now.date()}, Número de la semana: {week_number}")

## 📋 M5 - T1 - EJERCICIO 8
## Enunciado:
## Escribe un programa en Python para seleccionar todos los domingos de un año determinado.

from datetime import datetime, timedelta

def get_sundays(year):
    current_date = datetime(year, 1, 1)
    current_date += timedelta(days=(6 - current_date.weekday()) % 7)
    while current_date.year == year:
        print(current_date.date())
        current_date += timedelta(days=7)

if __name__ == "__main__":
    year = 2024
    print(f"Domingos del año {year}:")
    get_sundays(year)

## 📋 M5 - T1 - EJERCICIO 9
## Enunciado:
## Escribe un programa en Python para contar el número de lunes del primer día del mes desde 2015 hasta 2016.

from datetime import datetime
def count_mondays(start_year, end_year):
    count = 0
    for year in range(start_year, end_year + 1):
        for month in range(1, 13):
            if datetime(year, month, 1).weekday() == 0:
                count += 1
    return count
if __name__ == "__main__":
    start_year = 2015
    end_year = 2016
    mondays_count = count_mondays(start_year, end_year)
    print(f"Número de lunes del primer día del mes desde {start_year} hasta {end_year}: {mondays_count}")

## 📋 M5 - T1 - EJERCICIO 10
## Enunciado:
## Escribe un programa en Python para crear 12 fechas fijas a partir de una 
## fecha especificada en un periodo determinado. La diferencia entre dos fechas será de 20.
from datetime import datetime, timedelta

if __name__ == "__main__":
    start_date = datetime(2026, 1, 1)
    
    for i in range(12):
        date = start_date + timedelta(days=20 * i)
        print(date.date())


## 📋 M5 - T2 - EJERCICIO 1
## Enunciado:
## Implementa una función generadora que dadas dos listas del mismo tamaño,
## devuelva la multiplicación entre los elementos de cada una.
def prod(l1, l2):
    solution = []
    gen1 = iter(l1)   
    gen2 = iter(l2)    
    while True:
        try:
            solution.append(next(gen1) * next(gen2))
        except StopIteration:
            pass        
            break
    return solution

if __name__ == "__main__":
    l1 = [1, 2, 3]
    l2 = [4, 5, 6]
    print(prod(l1, l2))  


## 📋 M5 - T2 - EJERCICIO 2
## Enunciado:
## Implementa un generador que, dado un entero n, genere n números aleatorios.
    import random
def random_numbers(n):
    for _ in range(n):
        yield random.random()

if __name__ == "__main__":
    n = 5
    for number in random_numbers(n):
        print(number)

## 📋 M5 - T2 - EJERCICIO 3
## Enunciado:
## Implementa un generador de Fibonacci que genere n números de la secuencia.

def fibonacci(n):
    a, b = 0, 1
    for _ in range(n):
        yield a
        a, b = b, a + b
if __name__ == "__main__":
    n = 10
    for number in fibonacci(n):
        print(number)

## 📋 M5 - T2 - EJERCICIO 4
## Enunciado:
## Implementa un generador que, dado un entero n, imprima todos
## los números inferiores a n multiplicados por dos.
def double_numbers(n):
    for i in range(n):
        yield i * 2
if __name__ == "__main__":
    n = 10
    for number in double_numbers(n):
        print(number)


## 📋 M5 - T2 - EJERCICIO 5
## Enunciado:
## Implementa un generador que, dado un entero n, genere n números senares.
def odd_numbers(n):
    for i in range(1, 2 * n, 2):
        yield i
if __name__ == "__main__":
    n = 10
    for number in odd_numbers(n):
        print(number)


## 📋 M5 - T3 - EJERCICIO 1
## Enunciado:
## Crea una función que genere una excepción e imprima su tipo,
## los argumentos de la excepción y su mensaje de error.
def generarate_excepcion():
    try:
        raise ValueError("Este es un error de valor")
    except Exception as e:
        print(f"Tipo de excepción: {type(e)}")
        print(f"Argumentos de la excepción: {e.args}")
        print(f"Mensaje de error: {str(e)}")
if __name__ == "__main__":
    generarate_excepcion()

## 📋 M5 - T3 - EJERCICIO 2
## Enunciado:
## Crea una función que compute la diferencia entre dos enteros. Si la diferencia es negativa,
## genera una excepción personalizada llamada NegativeDifferenceException.
class NegativeDifferenceException(Exception):
    pass
def compute_difference(a, b):
    difference = a - b
    if difference < 0:
            raise NegativeDifferenceException("La diferencia es negativa")
    return difference
if __name__ == "__main__":
    try:
        result = compute_difference(5, 10)
        print(f"Diferencia: {result}")
    except NegativeDifferenceException as e:
        print(f"Excepción personalizada: {str(e)}")

## 📋 M5 - T3 - EJERCICIO 3
## Enunciado:
## Crea una función que calcule la división entre dos números. Debe imprimir:
## "Los parámetros deben ser números enteros" → si hay TypeError
## "El divisor no puede ser 0" → si hay ZeroDivisionError

def divide(a, b):
    return a / b
if __name__ == "__main__":
    try:
        result = divide(10, 0)
        print(f"Resultado: {result}")
    except TypeError:
        print("Los parámetros deben ser números enteros")
    except ZeroDivisionError:
        print("El divisor no puede ser 0")

## 📋 M5 - T3 - EJERCICIO 4
## Añade a la función anterior un mensaje que se imprima al final de la ejecución,
## independientemente de si se ha generado excepción o no.
def divide(a, b):
    try:
        return a / b
    except TypeError:
        print("Los parámetros deben ser números enteros")
    except ZeroDivisionError:
        print("El divisor no puede ser 0")
    finally:
        print("Fin de la ejecución")