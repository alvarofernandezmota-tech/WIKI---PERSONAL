"""
EJERCICIOS TEMA 1 - METODOLOGÍA Y CONCEPTOS POO
Módulo 3 Python - Escuela Musk
Autor: Álvaro Fernández Mota
Fecha: 10 febrero 2026

Instrucciones: Resuelve cada ejercicio aplicando los conceptos de POO
"""

# ==============================================================================
# EJERCICIO 1: Convertir código estructurado a POO
# ==============================================================================
"""
Tienes el siguiente código estructurado que gestiona productos:

productos = []

def agregar_producto(nombre, precio, stock):
    producto = {'nombre': nombre, 'precio': precio, 'stock': stock}
    productos.append(producto)

def ver_productos():
    for producto in productos:
        print(f"{producto['nombre']}: {producto['precio']}€ (Stock: {producto['stock']})")

Tu tarea:
1. Crea una clase Producto con atributos: nombre, precio, stock
2. Crea una clase GestorProductos con métodos: agregar_producto(), ver_productos()
3. Usa encapsulación (atributos privados donde tenga sentido)
"""

# Tu código aquí:




# Prueba tu código:
# gestor = GestorProductos()
# producto1 = Producto("Laptop", 899.99, 5)
# gestor.agregar_producto(producto1)
# gestor.ver_productos()


# ==============================================================================
# EJERCICIO 2: Aplicar Encapsulación
# ==============================================================================
"""
Crea una clase Empleado que tenga:
- Atributos privados: nombre, salario
- Métodos públicos:
  - __init__(nombre, salario)
  - aumentar_salario(porcentaje): Aumenta el salario en X%
  - ver_salario(): Retorna el salario actual
  - get_nombre(): Retorna el nombre

Reglas:
- El salario NO puede ser negativo
- El salario NO debe ser accesible directamente
- El porcentaje de aumento debe ser entre 0 y 100
"""

# Tu código aquí:




# Prueba tu código:
# empleado = Empleado("Ana", 2000)
# print(empleado.get_nombre())
# print(empleado.ver_salario())
# empleado.aumentar_salario(10)  # Aumentar 10%
# print(empleado.ver_salario())


# ==============================================================================
# EJERCICIO 3: Implementar Herencia
# ==============================================================================
"""
Crea una jerarquía de clases para formas geométricas:

1. Clase base: Forma
   - Métodos abstractos: calcular_area(), calcular_perimetro()

2. Clases hijas:
   - Rectangulo(base, altura)
   - Circulo(radio)
   - Triangulo(base, altura, lado1, lado2, lado3)

Cada clase hija debe implementar sus propios cálculos.

Fórmulas:
- Área rectángulo: base * altura
- Perímetro rectángulo: 2 * (base + altura)
- Área círculo: π * radio²
- Perímetro círculo: 2 * π * radio
- Área triángulo: (base * altura) / 2
- Perímetro triángulo: lado1 + lado2 + lado3
"""

# Pista: Usa from abc import ABC, abstractmethod
import math

# Tu código aquí:




# Prueba tu código:
# rectangulo = Rectangulo(5, 3)
# circulo = Circulo(4)
# triangulo = Triangulo(6, 4, 5, 5, 6)

# print(f"Rectángulo - Área: {rectangulo.calcular_area()}, Perímetro: {rectangulo.calcular_perimetro()}")
# print(f"Círculo - Área: {circulo.calcular_area():.2f}, Perímetro: {circulo.calcular_perimetro():.2f}")
# print(f"Triángulo - Área: {triangulo.calcular_area()}, Perímetro: {triangulo.calcular_perimetro()}")


# ==============================================================================
# EJERCICIO 4: Demostrar Polimorfismo
# ==============================================================================
"""
Usando las clases del ejercicio anterior (Forma, Rectangulo, Circulo, Triangulo):

1. Crea una función mostrar_info_forma(forma) que:
   - Imprima el tipo de forma
   - Imprima el área
   - Imprima el perímetro

2. Crea una lista con diferentes formas
3. Recorre la lista y llama a mostrar_info_forma() para cada una

Esto demostrará polimorfismo: misma función, diferentes comportamientos
"""

# Tu código aquí:




# Prueba tu código:
# formas = [
#     Rectangulo(5, 3),
#     Circulo(4),
#     Triangulo(6, 4, 5, 5, 6)
# ]
# 
# for forma in formas:
#     mostrar_info_forma(forma)
#     print("-" * 40)


# ==============================================================================
# EJERCICIO 5: Los 4 Principios Juntos
# ==============================================================================
"""
Crea un sistema de biblioteca con los 4 principios de POO:

1. ABSTRACCIÓN: Clase abstracta Material con métodos prestar(), devolver()

2. HERENCIA: Clases que heredan de Material:
   - Libro(titulo, autor, num_paginas)
   - Revista(titulo, edicion, mes)
   - DVD(titulo, duracion_minutos)

3. ENCAPSULACIÓN: 
   - Atributo privado __disponible (True/False)
   - Métodos para acceder/modificar disponibilidad

4. POLIMORFISMO:
   - Cada tipo de material implementa prestar() y devolver() a su manera
   - Función gestionar_material(material) que funcione con cualquier tipo

Requisitos adicionales:
- Cada material debe tener un método mostrar_info()
- Solo se puede prestar si está disponible
- Al devolver, vuelve a estar disponible
"""

from abc import ABC, abstractmethod

# Tu código aquí:




# Prueba tu código:
# libro = Libro("1984", "George Orwell", 328)
# revista = Revista("National Geographic", "Febrero 2026", "02")
# dvd = DVD("Inception", 148)

# materiales = [libro, revista, dvd]

# for material in materiales:
#     material.mostrar_info()
#     material.prestar()
#     material.devolver()
#     print("-" * 60)


# ==============================================================================
# EJERCICIO BONUS: Aplicar a THDORA
# ==============================================================================
"""
Rediseña THDORA usando POO:

1. Clase Cita:
   - Atributos: nombre, telefono, fecha, hora, motivo
   - Métodos: mostrar(), validar()

2. Clase GestorCitas:
   - Atributo privado __citas (lista)
   - Métodos: agregar(), ver_todas(), buscar(criterio), eliminar(indice)

3. Aplica encapsulación donde tenga sentido
4. Añade validaciones en los métodos

Esto será la base para mejorar THDORA en las próximas fases.
"""

# Tu código aquí:




# Prueba tu código:
# gestor = GestorCitas()
# cita1 = Cita("Juan", "612345678", "15/02/2026", "10:00", "Limpieza")
# gestor.agregar(cita1)
# gestor.ver_todas()


# ==============================================================================
# NOTAS FINALES
# ==============================================================================
"""
Consejos para resolver los ejercicios:

1. Lee bien el enunciado y entiende qué principio de POO aplica
2. Dibuja un diagrama de clases si te ayuda
3. Empieza por la clase base/padre
4. Implementa las clases hijas
5. Prueba cada clase por separado
6. Usa docstrings para documentar
7. Aplica los principios SOLID (los verás más adelante)

¡Éxito con los ejercicios!
"""
