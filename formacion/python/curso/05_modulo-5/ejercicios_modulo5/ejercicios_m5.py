# Ejercicios Módulo 5: Python Avanzado

## BLOQUE T1: Manejo de Archivos y Texto

##1. **Lectura línea a línea:** Escribe una función en python para leer el 
# contenido de un archivode texto "poema.txt" línea por línea y mostrar el mismo en
#  pantalla.

import os
from pathlib import Path
from collections import Counter
import string
import pandas as pd
import numpy as np

BASE_DIR = Path(__file__).parent
DATA_DIR = BASE_DIR / "data"

def _data(filename: str) -> Path:
    return DATA_DIR / filename

def read_poem():
    with open(_data("poema.txt"), "r", encoding="utf-8") as file:
        for line in file:
            print(line, end='')


##2. **Contador de líneas:** Escribe una función para contar el número de líneas de un 
# archivo de texto "historia.txt".
##  * *Ejemplo:* Si el archivo contiene 5 líneas de texto, el resultado debe ser 5.


def count_lines():
    with open(_data("historia.txt"), "r", encoding="utf-8") as file:
        lines = file.readlines()
    return len(lines)

   
##3. **Contador de palabras:** Escribe una función en Python para contar y mostrar el número
#  total de palabras en un archivo de texto.


def count_words():
    with open(_data("documento.txt"), "r", encoding="utf-8") as file:
        text = file.read()
    words = text.split()
    return len(words)


##4. **Buscador de palabras específicas:** Escriba una función en Python para leer líneas
#  de un archivo de texto "notas.txt". Su función debe encontrar y mostrar la aparición de
#  la palabra "el".


def find_word():
    count = 0
    with open(_data("notas.txt"), "r", encoding="utf-8") as file:
        for line in file:
            if "el" in line.lower().split():
                print(line, end='')
                count += 1
                
    print(f"\nLa palabra 'el' aparece en {count} línea(s)")
    return count
    
##5. **Filtro por longitud:** Escriba una función `display_words()` en python para leer las
#  líneas de un archivo de texto "story.txt", y mostrar aquellas palabras que tengan
#  menos de 4 caracteres.


def display_words():
    with open(_data("historia.txt"), "r", encoding="utf-8") as file:
        text = file.read()
    words = text.split()
    short_words = [word for word in words if len(word) < 4]
    print("Palabras con menos de 4 caracteres:")
    print(short_words)
    return short_words


##6. **Formateo con caracteres especiales:** Escriba una definición de función
#  para `hash_display()` que lea "materia.txt" y muestre el contenido separando cada
#  carácter con un símbolo "#" (Ejemplo: `H#E#L#L#O`).


def hash_display():
    with open(_data("materia.txt"), "r", encoding="utf-8-sig") as file:  # utf-8-sig elimina el BOM
        text = file.read().strip()
    formatted_text = "#".join(text)
    print(formatted_text)
    return formatted_text

##7. **Generador alfabético:** Escribe un programa en Python para generar 26 archivos
#  de texto llamados A.txt, B.txt, hasta Z.txt.


def generate_alphabet_files():
    alphabet_dir = DATA_DIR / "alphabet"
    alphabet_dir.mkdir(parents=True, exist_ok=True)
    for letter in range(65, 91):
        filename = alphabet_dir / f"{chr(letter)}.txt"
        with open(filename, "w", encoding="utf-8") as f:
            f.write(f"Archivo de la letra {chr(letter)}\n")


##8. **Append y lectura:** Escribe un programa en python para añadir texto a un archivo 
# y mostrar el texto resultante en "python.txt".


def append_and_read():
     with open(_data("python.txt"), "a+", encoding="utf-8") as file:
         file.write("¡Hola, mundo!\n")
         file.seek(0)  
         content = file.read()
         print("Contenido del archivo 'python.txt':")
         print(content)
         return content


##9. **Frecuencia de palabras:** Escribe un programa en python para calcular la frecuencia
#  de todas las palabras de un archivo txt.


def word_frequency():
    with open(_data("texto.txt"), "r", encoding="utf-8-sig") as file:
        text = file.read().lower()
    words = text.split()
    frequency = Counter(words)
    return frequency


##10. **Verificación de existencia:** Escribe un programa en python para comprobar si un
#  archivo especificado existe.


def check_file_exists(filename):
    if os.path.isfile(filename):
        print(f"El archivo '{filename}' existe.")
        return True
    else:
        print(f"El archivo '{filename}' no existe.")
        return False

## BLOQUE T2: Análisis de Datos con Pandas
# *Nota: Utilizar el archivo `csvAutomobile_data.csv`*

##1. **Visualización básica:** Imprime las cinco primeras y últimas filas del conjunto de datos.


def basic_visualization():
    df = pd.read_csv(_data("automovile.csv"))
    print("Primeras 5 filas:")
    print(df.iloc[:5])
    print("\nÚltimas 5 filas:")
    print(df.iloc[-5:])
    return df

##2. **Limpieza de datos:** Reemplaza todos los valores de las columnas que contengan `?`, `n.a.` o
#  `NaN` y actualiza el archivo CSV.


def clean_data():
    df = pd.read_csv(_data("automovile.csv"))
    df.replace(['?', 'n.a.', 'NaN'], pd.NA, inplace=True)
    df.to_csv(_data("automovile.csv"), index=False)
    return df

##3. **Búsqueda de máximos:** Encuentra e imprime el nombre de la empresa del 
# coche más caro y su precio.
def find_most_expensive_car():
    df = pd.read_csv(_data("automovile.csv"))
    most_expensive = df.loc[df['price'].idxmax()]
    print(f"la empresa {most_expensive['company']} con un precio de {most_expensive['price']}")
    return most_expensive

##4. **Filtrado específico:** Imprime todos los datos de los coches de la marca **Toyota**.
def filter_toyota():
    df = pd.read_csv(_data("automovile.csv"))
    toyota_cars = df[df['company'] == 'toyota']  # CSV tiene valores en minúscula
    print("Coches de la marca Toyota:")
    print(toyota_cars)
    return toyota_cars

##5. **Agregación por marca:** Cuenta el total de coches por empresa.
def count_cars_by_company():
    df = pd.read_csv(_data("automovile.csv"))
    car_counts = df['company'].value_counts()
    print("Número de coches por empresa:")
    for company, count in car_counts.items():
        print(f"{company}: {count} coches")
    return car_counts

##6. **Máximos por grupo:** Encuentra el coche con el precio más alto de cada empresa.
def most_expensive_by_company():
    df = pd.read_csv(_data("automovile.csv"))
    most_expensive_cars = df.loc[df.groupby('company')['price'].idxmax()]
    print("Coche más caro por empresa:")
    for _, row in most_expensive_cars.iterrows():
        print(f"{row['company']}: {row['price']}")
    return most_expensive_cars

##7. **Cálculo de medias:** Encuentra el kilometraje medio de cada empresa fabricante de automóviles.
def average_mileage_by_company():
    df = pd.read_csv(_data("automovile.csv"))
    average_mileage = df.groupby('company')['average-mileage'].mean()
    print("Kilometraje medio por empresa:")
    for company, mileage in average_mileage.items():
        print(f"{company}: {mileage:.2f} km/l")
    return average_mileage

##8. **Ordenación:** Ordena todos los coches por la columna **Precio**.
def sort_cars_by_price():
    df = pd.read_csv(_data("automovile.csv"))
    sorted_cars = df.sort_values(by='price')
    print("Coches ordenados por precio:")
    for _, row in sorted_cars.iterrows():
        print(f"{row['company']}: {row['price']}")
    return sorted_cars

##9. **Concatenación:** Une los siguientes dos diccionarios en un DataFrame:
#  ```python
# GermanCars = {'Company': ['Ford', 'Mercedes', 'BMW', 'Audi'], 'Price': [23845, 171995, 135925, 71400]}
# JapaneseCars = {'Company': ['Toyota', 'Honda', 'Nissan', 'Mitsubishi'], 'Price': [29995, 23600, 61500, 58900]}
def concatenate_cars():
    GermanCars = {'Company': ['Ford', 'Mercedes', 'BMW', 'Audi'], 'Price': [23845, 171995, 135925, 71400]}
    JapaneseCars = {'Company': ['Toyota', 'Honda', 'Nissan', 'Mitsubishi'], 'Price': [29995, 23600, 61500, 58900]}
    df_german = pd.DataFrame(GermanCars)
    df_japanese = pd.DataFrame(JapaneseCars)
    combined_df = pd.concat([df_german, df_japanese], ignore_index=True)
    print("DataFrame combinado:")
    print(combined_df)
    return combined_df

##10. **Fusión (Merge):** Crea dos DataFrames y añada el segundo como una nueva columna
#  al primero:
# ```python
# Car_Price = {'Company': ['Toyota', 'Honda', 'BMW', 'Audi'], 'Price': [23845, 17995, 135925, 71400]}
# Car_Horsepower = {'Company': ['Toyota', 'Honda', 'BMW', 'Audi'], 'horsepower': [141, 80, 182, 160]}
def merge_cars():
    Car_Price = {'Company': ['Toyota', 'Honda', 'BMW', 'Audi'], 'Price': [23845, 17995, 135925, 71400]}
    Car_Horsepower = {'Company': ['Toyota', 'Honda', 'BMW', 'Audi'], 'horsepower': [141, 80, 182, 160]}
    df_price = pd.DataFrame(Car_Price)
    df_horsepower = pd.DataFrame(Car_Horsepower)
    merged_df = pd.merge(df_price, df_horsepower, on='Company')
    print("DataFrame fusionado:")
    print(merged_df)
    return merged_df

## BLOQUE T3: Operaciones con NumPy

##1. **Atributos de Array:** Crea un array de enteros 4X2 (tipo `unsignedint16`). Imprime su 
# forma (shape), dimensiones y tamaño de cada elemento en bytes.
def array_attributes():
    arr = np.array([[1, 2], [3, 4], [5, 6], [7, 8]], dtype=np.uint16)
    print("Forma (shape):", arr.shape)
    print("Dimensiones:", arr.ndim)
    print("Tamaño de cada elemento en bytes:", arr.itemsize)
    return arr

##2. **Rangos y pasos:** Crea una matriz 5X2 con un rango entre 100 y 200, con una 
# diferencia de 10 entre cada elemento.
def create_range_array():
    arr = np.arange(100, 200, 10).reshape(5, 2)
    print("Matriz 5X2 con rango entre 100 y 200, con diferencia de 10:")
    print(arr)
    return arr

##3. **Slicing de columnas:** Dado un array 3x3, devuelve un array que solo contenga
#  la tercera columna de todas las filas.
def slice_third_column():
    samplearray = np.array([[11, 22, 33], [44, 55, 66], [77, 88, 99]])
    third_column = samplearray[:, 2]
    print("Tercera columna de todas las filas:")
    print(third_column)
    return third_column

##4. **Slicing complejo:** Devuelve un array de **filas impares** y **columnas pares** 
# de una matriz 5x4.
def slice_odd_rows_even_columns():
    asamplearrary = np.array([[3, 6, 9, 12],
                    [15, 18, 21, 24],
                    [27, 30, 33, 36],
                    [39, 42, 45, 48],
                    [51, 54, 57, 60]])
    result = asamplearrary[1::2, ::2]
    print("Filas impares y columnas pares de la matriz:")
    print(result)
    return result

##5. **Operaciones matemáticas:** Suma dos matrices dadas y luego calcula el
#  cuadrado de cada elemento del resultado.
def mathematical_operations():
    arr1 = np.array([[5, 6, 9], [21, 18, 27]])
    arr2 = np.array([[15, 33, 24], [4, 7, 1]])
    sum_arr = arr1 + arr2
    squared_arr = sum_arr ** 2
    print("Suma de las dos matrices:")
    print(sum_arr)
    print("Cuadrado de cada elemento del resultado:")
    print(squared_arr)
    return sum_arr, squared_arr

##6. **División de matrices:** Crea una matriz 8x3 (rango 10-34) y divídela en cuatro
#  submatrices de igual tamaño.
def divide_matrix():
    arr = np.arange(10, 34).reshape(8, 3)
    submatrices = np.split(arr, 4)
    print("Matriz original:")
    print(arr)
    print("Submatrices de igual tamaño:")
    for i, submatrix in enumerate(submatrices):
        print(f"Submatriz {i+1}:")
        print(submatrix)
    return submatrices

if __name__ == "__main__":
    read_poem()
    print("test pasado ejercicio1")
    print(count_lines())
    print("test pasado ejercicio2")
    print(count_words())
    print("test pasado ejercicio3")
    find_word()
    print("test pasado ejercicio4")
    display_words()
    print("test pasado ejercicio5")
    hash_display()
    print("test pasado ejercicio6")
    generate_alphabet_files()
    print("test pasado ejercicio7")
    append_and_read()
    print("test pasado ejercicio8")
    print(word_frequency())
    print("test pasado ejercicio9")
    check_file_exists(str(_data("poema.txt")))
    print("test pasado ejercicio10")
    basic_visualization()
    print("test pasado ejercicio1 bloque2")
    clean_data()
    print("test pasado ejercicio2 bloque2")
    find_most_expensive_car()
    print("test pasado ejercicio3 bloque2")
    filter_toyota()
    print("test pasado ejercicio4 bloque2")
    count_cars_by_company()
    print("test pasado ejercicio5 bloque2")
    most_expensive_by_company()
    print("test pasado ejercicio6 bloque2")
    average_mileage_by_company()
    print("test pasado ejercicio7 bloque2")
    sort_cars_by_price()
    print("test pasado ejercicio8 bloque2")
    concatenate_cars()
    print("test pasado ejercicio9 bloque2") 
    merge_cars()
    print("test pasado ejercicio10 bloque2")
    array_attributes()
    print("test pasado ejercicio1 bloque3")
    create_range_array()
    print("test pasado ejercicio2 bloque3")
    slice_third_column()
    print("test pasado ejercicio3 bloque3")
    slice_odd_rows_even_columns()
    print("test pasado ejercicio4 bloque3")
    mathematical_operations()
    print("test pasado ejercicio5 bloque3")
    divide_matrix()
    print("test pasado ejercicio6 bloque3")
