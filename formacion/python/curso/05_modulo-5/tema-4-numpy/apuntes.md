# Tema 4. Librerías Adicionales: NumPy

> M5 · Manipulación de Datos · Escuela Musk

**Estado:** ✅ Completado — 24 marzo 2026

---

## 📌 RECURSOS DEL TEMA

| Recurso | URL | Estado |
|---------|-----|--------|
| Tema 4. Librerías Adicionales a Numpy (intro) | https://campus.escuelamusk.com/mod/resource/view.php?id=59&forceview=1 | ✅ |
| Tema 4.1 ¿Qué es numpy? | https://campus.escuelamusk.com/mod/videotime/view.php?id=198&forceview=1 | ✅ |
| Tema 4.2 Generación de datos con numpy e indexación | https://campus.escuelamusk.com/mod/videotime/view.php?id=203&forceview=1 | ✅ |
| Tema 4.3 Axis, axis concatenation y operadores lógicos | https://campus.escuelamusk.com/mod/videotime/view.php?id=202&forceview=1 | ✅ |
| Tema 4.4 Funciones en numpy | https://campus.escuelamusk.com/mod/videotime/view.php?id=201&forceview=1 | ✅ |
| Tema 4.5 Broadcasting y sorting | https://campus.escuelamusk.com/mod/videotime/view.php?id=200&forceview=1 | ✅ |
| 🧰 Kit de Estudio Numpy | https://campus.escuelamusk.com/mod/page/view.php?id=3617&forceview=1 | ✅ |
| Tema 4 Quizz | https://campus.escuelamusk.com/mod/quiz/view.php?id=577&forceview=1 | ✅ |
| Tema 4. Block puzzle | https://campus.escuelamusk.com/mod/scorm/view.php?id=292&forceview=1 | ✅ |

---

## 📋 CHECKLIST

- [x] 4.1 — Qué es NumPy, arrays, shape, dtype
- [x] 4.2 — Generación de datos: arange, linspace, ones, zeros, eye, empty
- [x] 4.3 — Indexado
- [x] 4.4 — Axes: reshape, concatenate + operadores lógicos
- [x] 4.5 — Aggregate functions + Broadcasting + Ordenación
- [x] Kit de Estudio
- [x] Quiz T4 — 7/10 (67%)
- [x] Block puzzle T4 — 7/7 ✅

---

## 📝 4.1 — NumPy

NumPy es una biblioteca que se utiliza para realizar cálculos matemáticos avanzados sobre matrices y arrays multidimensionales manteniendo altos niveles de rendimiento.

**Características principales:**
- Mecanismo de almacenamiento eficiente y operaciones más rápidas que las listas Python
- Posibilidad de especificar el tipo de datos de las matrices
- Creación de arrays n-dimensionales y operaciones sobre ellos

Importación — siempre como `np` por convención:
```python
import numpy as np
```

> ⚠️ Siempre usar el alias `np` — es el estándar universal, lo encontrarás en toda la documentación.

Un **array** es un contenedor genérico multidimensional para datos homogéneos. Dos propiedades clave:
- `shape` → tupla que indica la dimensión del array
- `dtype` → tipo de dato del array (puede especificarse explícitamente)

```python
nparray = np.array([1, 2, 3])
print(nparray)        # [1 2 3]
print(type(nparray))  # <class 'numpy.ndarray'>
print(nparray.dtype)  # int64
print(nparray.shape)  # (3,)
```

> **Analogía:** NumPy = ladrillos. Pandas = arquitecto que los usa para construir DataFrames. Pandas usa NumPy por debajo.

---

## 📝 4.2 — Generación de datos

Métodos para crear arrays NumPy:

### `np.arange()` — secuencia de números desde 0
```python
np.arange(10)
# array([0, 1, 2, 3, 4, 5, 6, 7, 8, 9])
```

### `np.linspace()` — n elementos espaciados linealmente en un rango
```python
np.linspace(0, 10, 5)
# array([ 0. ,  2.5,  5. ,  7.5, 10. ])
```

### `np.ones()` — array lleno de unos
```python
np.ones(5)
# array([1., 1., 1., 1., 1.])
```

### `np.zeros()` — array lleno de ceros
```python
np.zeros(5)
# array([0., 0., 0., 0., 0.])
```

### `np.eye()` — matriz identidad
```python
np.eye(5)
# array([[1., 0., 0., 0., 0.],
#        [0., 1., 0., 0., 0.],
#        [0., 0., 1., 0., 0.],
#        [0., 0., 0., 1., 0.],
#        [0., 0., 0., 0., 1.]])
```

### `np.empty()` — array sin inicializar (valores de memoria)
```python
np.empty(4)
# Los elementos dependen del estado de la memoria — valores no determinados
```

| Función | Resultado |
|---------|-----------|
| `np.arange(n)` | Secuencia 0 → n-1 |
| `np.linspace(a, b, n)` | n puntos entre a y b |
| `np.ones(n)` | Array de 1s |
| `np.zeros(n)` | Array de 0s |
| `np.eye(n)` | Matriz identidad n×n |
| `np.empty(n)` | Array sin inicializar |

---

## 📝 4.3 — Indexado

NumPy sigue las reglas habituales de Python para indexar y seleccionar:

```python
nparray = np.array([1, 2, 3])
nparray[1]     # 2  → elemento en índice 1
nparray[0:2]   # array([1, 2])  → slicing
```

> ⚠️ Índice empieza en 0. Slicing `[a:b]` incluye `a` pero excluye `b`.

---

## 📝 4.4 — Axes (Arrays multidimensionales)

`reshape` redimensiona un array sin cambiar sus datos:

```python
t = np.arange(1, 7)
print(t, t.shape)        # [1 2 3 4 5 6] (6,)

t = t.reshape((2, 3))
print(t, t.shape)
# [[1 2 3]
#  [4 5 6]] (2, 3)
```

### Concatenar arrays — `np.concatenate()`
```python
small = np.arange(10)
big = np.arange(50)
result = np.concatenate([small, big])
# array([ 0,  1, ...,  9,  0,  1, ..., 49])
```

> **Axes:** en arrays 2D — `axis=0` = filas (↓), `axis=1` = columnas (→)

---

## 📝 4.5 — Operadores Lógicos

```python
list1 = [True, False, True, False]
list2 = [True, True, False, True]

np.logical_and(list1, list2)  # [ True False False False]
np.logical_or(list1, list2)   # [ True  True  True  True]
np.logical_xor(list1, list2)  # [False  True  True  True]
np.logical_not(list1)         # [False  True False  True]
```

### `any()` y `all()`
```python
np.all([True, True, True])    # True  → ¿todos cumplen?
np.any([True, False, False])  # True  → ¿alguno cumple?
```

---

## 📝 4.6 — Aggregate Functions

Funciones estadísticas: `sum`, `min`, `max`, `mean`, `average`, `product`, `median`, `std`, `var`, `argmin`, `argmax`, `percentile`, `cumprod`, `cumsum`, `corrcoef`.

```python
arr1 = np.array([10, 20, 30, 40, 50])
arr2 = np.array([[0, 10, 20], [30, 40, 50], [60, 70, 80]])
```

```python
# sum
arr2.sum(axis=0)   # columnas → array([ 90, 120, 150])
arr2.sum(axis=1)   # filas    → array([ 30, 120, 210])
arr2.sum()         # total    → 360

# average
np.average(arr2)           # 40.0
np.average(arr2, axis=0)   # array([30., 40., 50.])
np.average(arr2, axis=1)   # array([10., 40., 70.])

# prod
np.prod(arr2)   # 0  (cualquier nº × 0 = 0)
np.prod(arr1)   # 12000000

# min / max
arr2.min(axis=0)   # array([ 0, 10, 20])
arr2.max(axis=0)   # array([60, 70, 80])
np.min(arr2)       # 0
np.max(arr2)       # 80

# maximum — posición a posición entre dos arrays
a = np.array([1, 20, 5, 22, 8, 15])
b = np.array([12, 9, 3, 42, 6, 33])
np.maximum(a, b)   # [12 20  5 42  8 33]
```

> ⚠️ `max()` = máximo global | `maximum()` = compara dos arrays elemento a elemento.

---

## 📝 4.7 — Broadcasting

Broadcasting = aplicar una operación a TODOS los elementos del array de golpe. El valor pequeño se "estira" automáticamente.

```python
precios = np.array([100, 250, 80, 320])
precios * 1.10   # [110. 275.  88. 352.]  → subida del 10% a todos

# Broadcasting en 2D
array1 = np.array([[1], [2], [3]])
array2 = np.array([[1, 2, 3]])
array1 + array2
# [[2 3 4]
#  [3 4 5]
#  [4 5 6]]
```

> Como Excel: seleccionas toda una columna y aplicas la fórmula a todas las celdas a la vez.

---

## 📝 4.8 — Ordenación

```python
a = np.array([3, 7, 9, 10, 34, 1])
np.random.shuffle(a)   # mezcla aleatoria in-place

# Forma 1 — np.sort() NO modifica el original
np.sort(a)   # array([ 1,  3,  7,  9, 10, 34])

# Forma 2 — a.sort() SÍ modifica el original (in-place)
a.sort()
a   # array([ 1,  3,  7,  9, 10, 34])
```

| Método | Modifica original | Devuelve |
|--------|-------------------|----------|
| `np.sort(a)` | ❌ No | Array ordenado nuevo |
| `a.sort()` | ✅ Sí | None (in-place) |

---

## 📝 RESUMEN — NumPy de un vistazo

| Categoría | Funciones clave |
|-----------|----------------|
| **Creación** | `array()`, `arange()`, `linspace()`, `ones()`, `zeros()`, `eye()`, `empty()` |
| **Propiedades** | `.shape`, `.dtype`, `.reshape()` |
| **Selección** | `[]`, `[a:b]` (slicing estándar Python) |
| **Multidim** | `reshape()`, `concatenate()` |
| **Lógica** | `logical_and/or/xor/not`, `any()`, `all()` |
| **Estadística** | `sum()`, `min()`, `max()`, `average()`, `prod()`, `maximum()` |
| **Broadcasting** | Operaciones entre arrays de distintos tamaños automáticamente |
| **Ordenación** | `np.sort()` (no modifica), `a.sort()` (in-place) |

---

## ✅ QUIZ / BLOQUE PUZZLE — Resultados

### Quiz T4
- **Nota:** 7/10 (67%) — 2/3 correctas
- **Fallo:** Pregunta 3 — *¿Cuál NO es función agregada?* → `Standard dimension` no existe (trampa: suena a `std` pero es inventado)

### Block Puzzle T4 — 7/7 ✅
1. Crear lista → array NumPy e imprimir
2. `np.empty(4)` — array sin inicializar
3. `np.ones(9)` + `reshape(3,3)` → matriz 3×3
4. `np.logical_and(a > 2, b < 4)` — operadores lógicos
5. `np.sum()` — suma de elementos
6. Broadcasting 2D — suma de arrays de distinta forma
7. `np.zeros(5)` — vector de ceros

---
_Creado: 16 marzo 2026 | Actualizado: 24 marzo 2026 — T4 completado al 100%_
