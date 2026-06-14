# 📚 Apuntes Completos - Módulo 1: Python, el nuevo desconocido

> **Curso:** Python PCAP - Escuela Musk  
> **Alumno:** Álvaro Fernández Mota  
> **Fecha:** Enero 2026  
> **Estado:** ✅ Completado

---

## 📑 Índice

1. [¿Qué es Python?](#1-qué-es-python)
2. [Historia de Python](#2-historia-de-python)
3. [Características del lenguaje](#3-características-del-lenguaje)
4. [Aplicaciones de Python](#4-aplicaciones-de-python)
5. [Instalación y configuración](#5-instalación-y-configuración)
6. [Primeros pasos](#6-primeros-pasos)
7. [Conceptos clave](#7-conceptos-clave)

---

## 1. ¿Qué es Python?

### Definición

Python es un **lenguaje de programación interpretado, de alto nivel y de propósito general**. Fue creado por Guido van Rossum y lanzado por primera vez en 1991.

### Características principales

- **Interpretado**: No necesita compilación previa
- **Alto nivel**: Abstracción de detalles técnicos de la máquina
- **Propósito general**: Aplicable a múltiples dominios
- **Sintaxis clara**: Código legible y fácil de mantener
- **Multiparadigma**: Soporta programación orientada a objetos, imperativa y funcional

### Filosofía Python (Zen of Python)

```python
import this
```

Principios destacados:
- **"Beautiful is better than ugly"** - La belleza importa
- **"Explicit is better than implicit"** - La claridad es fundamental
- **"Simple is better than complex"** - La simplicidad es clave
- **"Readability counts"** - La legibilidad cuenta

---

## 2. Historia de Python

### Línea temporal

- **1989**: Guido van Rossum comienza el desarrollo
- **1991**: Lanzamiento de Python 0.9.0
- **2000**: Python 2.0 (list comprehensions, garbage collector)
- **2008**: Python 3.0 (incompatible con Python 2, modernización)
- **2020**: Fin del soporte de Python 2
- **Actualidad**: Python 3.x en constante evolución

### Origen del nombre

El nombre "Python" proviene del programa de comedia británico **"Monty Python's Flying Circus"**, no de la serpiente.

### Creador: Guido van Rossum

- Programador holandés
- Conocido como el "Benevolent Dictator For Life" (BDFL)
- En 2018 se retiró de esta posición
- Actualmente Python es gestionado por un consejo directivo

---

## 3. Características del lenguaje

### Ventajas

✅ **Sintaxis simple y legible**
- Código similar al pseudocódigo
- Indentación obligatoria (fuerza buenas prácticas)

✅ **Multiplataforma**
- Windows, macOS, Linux, Unix

✅ **Extensas librerías**
- Biblioteca estándar muy completa
- Miles de paquetes en PyPI (Python Package Index)

✅ **Gran comunidad**
- Documentación abundante
- Soporte activo en foros y comunidades

✅ **Versatilidad**
- Desarrollo web, ciencia de datos, IA, automatización, etc.

### Desventajas

❌ **Velocidad de ejecución**
- Más lento que lenguajes compilados (C, C++, Java)
- Mitigable con optimizaciones y librerías nativas

❌ **Consumo de memoria**
- Mayor uso de RAM que lenguajes de bajo nivel

❌ **Limitaciones en móviles**
- No es el lenguaje principal para apps móviles nativas

---

## 4. Aplicaciones de Python

### Áreas de uso

🌐 **Desarrollo Web**
- Frameworks: Django, Flask, FastAPI
- Backend APIs y servicios web

📊 **Ciencia de Datos y Análisis**
- Pandas, NumPy, Matplotlib
- Análisis estadístico y visualización

🤖 **Inteligencia Artificial y Machine Learning**
- TensorFlow, PyTorch, scikit-learn
- Deep Learning y redes neuronales

⚙️ **Automatización y Scripting**
- Automatización de tareas repetitivas
- Web scraping (BeautifulSoup, Scrapy)

🎮 **Desarrollo de Videojuegos**
- Pygame para juegos 2D
- Scripting en engines como Blender

🔬 **Computación Científica**
- SciPy, SymPy
- Simulaciones y cálculos complejos

💼 **Finanzas y Trading**
- Análisis de mercados
- Trading algorítmico

---

## 5. Instalación y configuración

### Instalación de Python

#### Windows
1. Descargar desde [python.org](https://www.python.org/downloads/)
2. Ejecutar instalador
3. ✅ **Marcar "Add Python to PATH"**
4. Verificar: `python --version`

#### macOS
```bash
# Usando Homebrew
brew install python3

# Verificar instalación
python3 --version
```

#### Linux (Ubuntu/Debian)
```bash
sudo apt update
sudo apt install python3 python3-pip

# Verificar
python3 --version
```

### IDEs y Editores recomendados

- **VS Code** (recomendado para principiantes)
  - Extensión: Python (Microsoft)
  - Gratuito y ligero

- **PyCharm**
  - IDE profesional de JetBrains
  - Versión Community (gratuita) y Professional

- **Jupyter Notebook**
  - Ideal para ciencia de datos
  - Formato interactivo

- **IDLE**
  - Incluido con Python
  - Simple y básico

### pip: Gestor de paquetes

```bash
# Verificar pip
pip --version

# Instalar paquete
pip install nombre_paquete

# Listar paquetes instalados
pip list

# Actualizar pip
pip install --upgrade pip
```

---

## 6. Primeros pasos

### Hola Mundo

```python
print("¡Hola, mundo!")
```

### Modo interactivo (REPL)

```bash
# Abrir intérprete Python
python3

>>> 2 + 2
4
>>> print("Python es genial")
Python es genial
>>> exit()
```

### Ejecutar scripts

```bash
# Crear archivo hola.py
echo 'print("Hola desde script")' > hola.py

# Ejecutar
python3 hola.py
```

### Comentarios

```python
# Comentario de una línea

"""
Comentario
de múltiples
líneas (docstring)
"""

# Los comentarios son ignorados por el intérprete
print("Esto sí se ejecuta")  # Comentario inline
```

### Variables básicas

```python
# Python es de tipado dinámico
nombre = "Álvaro"  # str
edad = 25  # int
altura = 1.75  # float
estudiante = True  # bool

# Ver tipo de variable
print(type(nombre))  # <class 'str'>
```

---

## 7. Conceptos clave

### Indentación

```python
# ✅ CORRECTO
if True:
    print("Indentado correctamente")
    print("Mismo bloque")

# ❌ INCORRECTO
if True:
print("Error de indentación")  # IndentationError
```

### Case-sensitive

```python
variable = 10
Variable = 20
VARIABLE = 30

# Son tres variables diferentes
print(variable, Variable, VARIABLE)  # 10 20 30
```

### Convenciones de nombres

```python
# snake_case (recomendado para variables y funciones)
mi_variable = 42
mi_funcion()

# PascalCase (para clases)
class MiClase:
    pass

# MAYUSCULAS (para constantes)
PI = 3.14159
MAX_INTENTOS = 3
```

### Palabras reservadas

```python
import keyword
print(keyword.kwlist)
# ['False', 'None', 'True', 'and', 'as', 'assert', 'async', 'await',
#  'break', 'class', 'continue', 'def', 'del', 'elif', 'else', 'except',
#  'finally', 'for', 'from', 'global', 'if', 'import', 'in', 'is',
#  'lambda', 'nonlocal', 'not', 'or', 'pass', 'raise', 'return',
#  'try', 'while', 'with', 'yield']
```

---

## 🎯 Resumen del Módulo 1

### Lo aprendido

✅ Python es un lenguaje interpretado, versátil y con sintaxis clara  
✅ Creado por Guido van Rossum en 1991  
✅ Ampliamente usado en web, IA, ciencia de datos y automatización  
✅ Instalación sencilla en cualquier plataforma  
✅ Conceptos básicos: variables, comentarios, indentación  
✅ Filosofía centrada en legibilidad y simplicidad  

### Próximos pasos

➡️ **Módulo 2:** Características básicas del lenguaje  
- Tipos de datos avanzados  
- Operadores  
- Estructuras de control  
- Funciones y módulos  

---

## 📖 Recursos adicionales

### Documentación oficial
- [Python.org](https://www.python.org/)
- [Python Documentation](https://docs.python.org/3/)
- [PEP 8 - Style Guide](https://pep8.org/)

### Práctica
- [Python Tutor](https://pythontutor.com/) - Visualizador de código
- [HackerRank Python](https://www.hackerrank.com/domains/python)
- [LeetCode](https://leetcode.com/) - Problemas de programación

### Comunidad
- [Stack Overflow](https://stackoverflow.com/questions/tagged/python)
- [Reddit r/learnpython](https://www.reddit.com/r/learnpython/)
- [Python Discord](https://pythondiscord.com/)

---

## ✅ Checklist de verificación

- [ ] Python instalado correctamente
- [ ] IDE/Editor configurado
- [ ] Ejecutado primer "Hola Mundo"
- [ ] Comprendida la filosofía Python
- [ ] Practicadas variables básicas
- [ ] Entendida la importancia de la indentación
- [ ] Explorado el modo interactivo
- [ ] Instalado y probado pip

---

**🚀 ¡Módulo 1 completado! Continuar con Módulo 2 →**