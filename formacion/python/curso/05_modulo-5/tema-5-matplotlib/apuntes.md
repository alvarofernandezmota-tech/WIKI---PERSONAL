# Tema 5. Introducción a Matplotlib

> M5 · Manipulación de Datos · Escuela Musk

**Estado:** ✅ Completado — 25 marzo 2026

---

## 📌 RECURSOS DEL TEMA

| Recurso | URL | Estado |
|---------|-----|--------|
| Tema 5. Introducción a Matplotlib (intro) | https://campus.escuelamusk.com/mod/resource/view.php?id=58&forceview=1 | ✅ |
| Tema 5.1 ¿Qué es matplotlib? | https://campus.escuelamusk.com/mod/videotime/view.php?id=199&forceview=1 | ✅ |
| Tema 5.2 Líneas múltiples, títulos, labels y grid lines | https://campus.escuelamusk.com/mod/videotime/view.php?id=204&forceview=1 | ✅ |
| Tema 5.3 Sub plot, scatter plots y bar plots | https://campus.escuelamusk.com/mod/videotime/view.php?id=206&forceview=1 | ✅ |
| Tema 5.4 Otros tipos de gráficos | https://campus.escuelamusk.com/mod/videotime/view.php?id=205&forceview=1 | ✅ |
| 🧰 Kit de Estudio Matplotlib | https://campus.escuelamusk.com/mod/page/view.php?id=3618&forceview=1 | ✅ |
| Tema 5 Quiz | https://campus.escuelamusk.com/mod/quiz/view.php?id=578&forceview=1 | ✅ |
| Tema 5. Block puzzle | https://campus.escuelamusk.com/mod/scorm/view.php?id=293&forceview=1 | ✅ |

---

## 📋 CHECKLIST

- [x] 5.1 — ¿Qué es Matplotlib? Importación, figura básica
- [x] 5.2 — Líneas múltiples, títulos, labels, grid
- [x] 5.3 — Subplot, scatter, bar
- [x] 5.4 — Otros gráficos: pie, histograma
- [x] Kit de Estudio
- [x] Quiz T5
- [x] Block puzzle T5

---

## 📝 5.1 — ¿Qué es Matplotlib?

Matplotlib es la librería de visualización de datos más utilizada en Python. Permite crear gráficas de todo tipo: líneas, barras, dispersión, pastel, histogramas, etc.

**Importación — siempre como `plt` por convención:**
```python
import matplotlib.pyplot as plt
```

> ⚠️ Siempre usar el alias `plt` — es el estándar universal.

**Flujo básico:**
```python
import matplotlib.pyplot as plt

plt.plot([1, 2, 3, 4])   # datos
plt.show()               # mostrar la gráfica
```

> **Analogía:** Matplotlib es como un lienzo en blanco. Tú decides qué pintar, cómo y con qué colores.

**Relación con NumPy y Pandas:**
- Matplotlib se combina con NumPy para graficar arrays
- Pandas tiene integración directa con Matplotlib para graficar DataFrames
- Stack básico de datos: NumPy + Pandas + Matplotlib

---

## 📝 5.2 — Líneas múltiples, Títulos y Labels

### Gráfica de línea básica
```python
x = [1, 2, 3, 4, 5]
y = [2, 4, 6, 8, 10]

plt.plot(x, y)
plt.show()
```

### Título y etiquetas de ejes
```python
plt.plot(x, y)
plt.title("Mi primera gráfica")
plt.xlabel("Eje X")
plt.ylabel("Eje Y")
plt.show()
```

### Líneas múltiples en una misma gráfica
```python
x = [1, 2, 3, 4, 5]
y1 = [2, 4, 6, 8, 10]
y2 = [1, 3, 5, 7, 9]

plt.plot(x, y1, label="Serie A")
plt.plot(x, y2, label="Serie B")
plt.legend()
plt.title("Líneas múltiples")
plt.show()
```

### Colores y estilos de línea
```python
plt.plot(x, y, color="red")        # color por nombre
plt.plot(x, y, color="#FF5733")    # color hex
plt.plot(x, y, linestyle="--")     # línea discontinua
plt.plot(x, y, linewidth=3)        # grosor
plt.plot(x, y, marker="o")         # marcador en cada punto
```

| Parámetro | Opciones comunes |
|-----------|------------------|
| `color` | `"red"`, `"blue"`, `"green"`, `"#hex"` |
| `linestyle` | `"-"` (sólido), `"--"` (guiones), `":"` (puntos), `"-."` (mixto) |
| `marker` | `"o"` (círculo), `"s"` (cuadrado), `"^"` (triángulo), `"*"` (estrella) |
| `linewidth` | número entero o decimal |

### Grid (cuadrícula)
```python
plt.grid(True)
```

### Límites de ejes
```python
plt.xlim(0, 10)
plt.ylim(0, 20)
```

---

## 📝 5.3 — Subplot, Scatter y Bar

### Subplot — múltiples gráficas en una figura
```python
plt.subplot(filas, columnas, posicion)
```

```python
x = [1, 2, 3, 4, 5]
y1 = [1, 4, 9, 16, 25]
y2 = [1, 2, 3, 4, 5]

plt.subplot(1, 2, 1)       # 1 fila, 2 columnas, posición 1
plt.plot(x, y1)
plt.title("Cuadrados")

plt.subplot(1, 2, 2)       # posición 2
plt.plot(x, y2)
plt.title("Lineal")

plt.tight_layout()         # evita solapamiento
plt.show()
```

> `plt.tight_layout()` ajusta automáticamente los márgenes.

### Scatter (dispersión)
```python
x = [1, 2, 3, 4, 5]
y = [5, 7, 3, 8, 6]

plt.scatter(x, y)
plt.title("Gráfica de dispersión")
plt.xlabel("X")
plt.ylabel("Y")
plt.show()
```

```python
# Con tamaño y color
plt.scatter(x, y, color="purple", s=100)   # s = tamaño puntos
```

> Scatter se usa para ver si hay correlación entre dos variables.

### Bar chart (barras)
```python
categorias = ["Python", "JavaScript", "Java", "C++"]
valores = [45, 30, 15, 10]

plt.bar(categorias, valores)
plt.title("Lenguajes más populares")
plt.xlabel("Lenguaje")
plt.ylabel("Popularidad (%)")
plt.show()
```

```python
# Barras horizontales
plt.barh(categorias, valores)
```

| Tipo | Función | Cuándo usarlo |
|------|---------|---------------|
| Línea | `plt.plot()` | Evolución temporal, tendencias |
| Dispersión | `plt.scatter()` | Relación entre dos variables |
| Barras | `plt.bar()` / `plt.barh()` | Comparar categorías |

---

## 📝 5.4 — Otros Gráficos

### Histograma — distribución de datos
```python
import numpy as np

datos = np.random.randn(1000)

plt.hist(datos, bins=30)
plt.title("Histograma")
plt.xlabel("Valor")
plt.ylabel("Frecuencia")
plt.show()
```

> `bins` = número de barras. Más bins = más detalle.

### Gráfica de pastel (pie chart)
```python
etiquetas = ["Python", "JavaScript", "Java", "Otros"]
tamaños = [45, 30, 15, 10]
explotar = (0.1, 0, 0, 0)   # destacar primer sector

plt.pie(tamaños, explode=explotar, labels=etiquetas, autopct="%1.1f%%")
plt.title("Distribución de lenguajes")
plt.show()
```

> `autopct` muestra el porcentaje dentro de cada sector.

### Tamaño de figura
```python
plt.figure(figsize=(10, 6))   # ancho x alto en pulgadas
```

### Guardar figura
```python
plt.savefig("grafica.png", dpi=300, bbox_inches="tight")
```

> ⚠️ `savefig()` debe ir ANTES de `show()` — si no, guarda imagen en blanco.

---

## 📊 RESUMEN — Matplotlib de un vistazo

| Categoría | Funciones clave |
|-----------|----------------|
| **Importar** | `import matplotlib.pyplot as plt` |
| **Gráficas** | `plt.plot()`, `plt.scatter()`, `plt.bar()`, `plt.barh()`, `plt.hist()`, `plt.pie()` |
| **Texto** | `plt.title()`, `plt.xlabel()`, `plt.ylabel()`, `plt.legend()` |
| **Ejes** | `plt.xlim()`, `plt.ylim()`, `plt.grid()` |
| **Layout** | `plt.subplot()`, `plt.tight_layout()`, `plt.figure(figsize=)` |
| **Exportar** | `plt.savefig()` |
| **Mostrar** | `plt.show()` |

### Orden recomendado:
1. `plt.figure(figsize=...)` — opcional
2. `plt.plot/scatter/bar/...()` — datos
3. `plt.title/xlabel/ylabel/legend()` — etiquetas
4. `plt.savefig()` — si quieres guardar
5. `plt.show()` — siempre al final

---

## 🔗 CONEXIÓN CON THDORA

- **Fase 8+**: gráficas de progreso semanal de hábitos
- **Dashboard**: visualizar sueño, estudio, tabaco, THC en el tiempo
- **Bot Telegram**: enviar imágenes generadas con `savefig()`

---

## ✅ QUIZ / BLOQUE PUZZLE — Resultados

### Quiz T5
| Pregunta | Respuesta correcta | Resultado |
|----------|--------------------|-----------|
| ¿Qué hace `plot()`? | Dibuja puntos o marcadores en un diagrama | ✅ |
| ¿Qué hace `subplot()`? | Representar más de un plot en una misma figura | ✅ |
| `plt.piech()` ¿verdadero o falso? | Falso (la función correcta es `plt.pie()`) | ✅ |

### Block Puzzle T5 — 4.100 puntos
| Ejercicio | Concepto | Puntos |
|-----------|----------|--------|
| 1/8 | Gráfico de línea básico con título | — |
| 2/8 | Gráfico básico con `plt.grid(True)` | 800 |
| 3/8 | Subplot con dos gráficas | 300 |
| 4/8 | Bar chart con título y etiquetas de ejes | 400 |
| 5/8 | Histograma con `bins=5` | 500 |
| 6/8 | Graficar puntos concretos con título | 600 |
| 7/8 | Bar chart "Gráfica Cantidad/Días" | 700 |
| 8/8 | Histograma de edades con `bins=10` | 800 |
| **TOTAL** | | **4.100 pts** |

---
_Creado: 16 marzo 2026 | Actualizado: 25 marzo 2026 17:08 CET — T5 completado_
