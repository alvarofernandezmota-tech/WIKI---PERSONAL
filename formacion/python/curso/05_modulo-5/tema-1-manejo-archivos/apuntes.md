# Tema 1. Manejo de Archivos

> M5 · Manipulación de Datos · Escuela Musk  
> **PDF:** M5-T1.pdf

**Estado:** 🔄 En curso — 16 marzo 2026 (T1.1 y with open vistos)

---

## 📌 RECURSOS DEL TEMA

| Recurso | URL | Estado |
|---------|-----|--------|
| Tema 1. Manejo de Archivos (intro) | https://campus.escuelamusk.com/mod/resource/view.php?id=57&forceview=1 | ✅ |
| Tema 1.1 Manejo de Archivos en Python | https://campus.escuelamusk.com/mod/videotime/view.php?id=183&forceview=1 | ✅ |
| Tema 1.2 Métodos adicionales | https://campus.escuelamusk.com/mod/videotime/view.php?id=185&forceview=1 | ⏳ |
| 🧰 Kit de Estudio Manejo de archivos | https://campus.escuelamusk.com/mod/page/view.php?id=3614&forceview=1 | ⏳ |
| Tema 1 Quizz | https://campus.escuelamusk.com/mod/quiz/view.php?id=567&forceview=1 | ⏳ |
| Tema 1. Block puzzle | https://campus.escuelamusk.com/mod/scorm/view.php?id=289&forceview=1 | ⏳ |

---

## 📋 CHECKLIST

- [x] 5.1 — Qué es un archivo y por qué persistencia en disco
- [x] 5.2 — Abrir archivos con `open()` y modos
- [x] 5.3 — Cerrar archivos: `close()`, `try/finally`, `with open`
- [x] 5.4 — Escribir en archivos: `write()`, `writelines()`
- [x] 5.5 — Leer archivos: `read()`, `readline()`, `readlines()`
- [ ] Tema 1.2 — Métodos adicionales (video pendiente)
- [ ] Kit de Estudio
- [ ] Quiz T1
- [ ] Block puzzle T1

---

## 📝 5.1 — Qué es un archivo

Los archivos son ubicaciones con nombre en el disco para almacenar datos de forma **permanente** en memoria no volátil (disco duro). La RAM es volátil (pierde datos al apagar), por eso usamos archivos para persistencia.

**Orden de operación con archivos en Python:**
1. Abrir el archivo
2. Leer o escribir
3. Cerrar el archivo

---

## 📝 5.2 — Abrir archivos con `open()`

`open()` devuelve un **objeto archivo** (también llamado *handle*).

### Modos de apertura:

| Modo | Descripción |
|------|-------------|
| `r` | Lectura (por defecto). Error si no existe |
| `w` | Escritura. Crea si no existe, **trunca (borra)** si existe |
| `x` | Creación exclusiva. Falla si ya existe |
| `a` | Append. Escribe al final sin borrar. Crea si no existe |
| `t` | Modo texto (por defecto) |
| `b` | Modo binario (imágenes, ejecutables...) |
| `+` | Actualización (lectura + escritura) |

### ⚠️ Encoding:
- Windows por defecto: `cp1252`
- Linux por defecto: `utf-8`
- **Siempre especificar** `encoding='utf-8'` para evitar problemas

```python
f = open("test.txt", encoding='utf-8')
```

---

## 📝 5.3 — Cerrar archivos

### Método 1: `close()` directo — 🚫 NO RECOMENDADO
```python
f = open("test.txt", encoding='utf-8')
# operaciones...
f.close()  # si hay excepción antes, el archivo queda abierto!
```

### Método 2: `try/finally` — ✅ Seguro
```python
try:
    f = open("test.txt", encoding='utf-8')
    # operaciones...
finally:
    f.close()  # siempre se ejecuta, haya excepción o no
```

### Método 3: `with open()` — ✅✅ RECOMENDADO (Pythonic)
```python
with open("test.txt", encoding='utf-8') as f:
    # operaciones...
# f.close() se llama automáticamente al salir del bloque
```

> **`with open` es la forma correcta.** Cierra el archivo automáticamente aunque haya excepción, sin necesidad de llamar `close()` manualmente.

---

## 📝 5.4 — Escribir en archivos

Necesita modo `w`, `a` o `x`.

> ⚠️ **Cuidado con `w`:** sobrescribe todo el contenido si el archivo ya existe.

### `write()` — escribe un string
```python
with open("test.txt", 'w', encoding='utf-8') as f:
    f.write("primera linea\n")
    f.write("segunda linea\n")
    f.write("tercera linea\n")
# devuelve el número de caracteres escritos
```

### `writelines()` — escribe una lista
```python
lineas = ["primera linea\n", "segunda linea\n", "tercera linea\n"]
with open("test.txt", 'w', encoding='utf-8') as f:
    f.writelines(lineas)
# OJO: hay que añadir \n manualmente en cada elemento
```

---

## 📝 5.5 — Leer archivos

Necesita modo `r` (por defecto).

### `read(n)` — lee n caracteres (o todo si no se especifica)
```python
f = open("test.txt", 'r', encoding='utf-8')
f.read(4)    # 'This'  ← lee 4 caracteres
f.read(4)    # ' is '  ← continúa desde donde lo dejó
f.read()     # resto del archivo completo
f.read()     # ''  ← ya no queda nada, devuelve string vacío
```

### `readline()` — lee una línea cada vez
```python
f.readline()   # 'This is my first file\n'
f.readline()   # 'This file\n'
f.readline()   # 'contains three lines\n'
f.readline()   # ''  ← fin del archivo
```

### `readlines()` — devuelve lista con todas las líneas
```python
f.readlines()
# ['This is my first file\n', 'This file\n', 'contains three lines\n']
```

---

## 📝 Métodos del objeto File (tabla resumen)

| Método | Descripción |
|--------|-------------|
| `close()` | Cierra el archivo |
| `fileno()` | Devuelve el descriptor de archivo (entero) |
| `flush()` | Vacía el búfer de escritura |
| `read(n)` | Lee n caracteres (todo si no se especifica) |
| `readline()` | Lee una línea |
| `readlines()` | Lee todas las líneas → devuelve lista |
| `write(s)` | Escribe el string s en el archivo |
| `writelines(lista)` | Escribe todos los elementos de la lista |

---

## ✅ QUIZ / BLOQUE PUZZLE

_Pendiente completar tras ver T1.2_

---
_Creado: 16 marzo 2026 | Apuntes del PDF completados: 16 marzo 2026_
