# Tema 2. Introducción a JSON

> M5 · Manipulación de Datos · Escuela Musk

**Estado:** ⏳ En curso — 16 marzo 2026

---

## 📌 RECURSOS DEL TEMA

| Recurso | URL | Estado |
|---------|-----|--------|
| Tema 2.1 Introducción a JSON | https://campus.escuelamusk.com/mod/videotime/view.php?id=187&forceview=1 | ⏳ |
| Tema 2.2 Métodos adicionales | https://campus.escuelamusk.com/mod/videotime/view.php?id=189&forceview=1 | ⏳ |
| 🧰 Kit de Estudio JSON | https://campus.escuelamusk.com/mod/page/view.php?id=3616&forceview=1 | ⏳ |
| Tema 2 Quizz | https://campus.escuelamusk.com/mod/quiz/view.php?id=569&forceview=1 | ⏳ |
| Tema 2. Block puzzle | https://campus.escuelamusk.com/mod/scorm/view.php?id=291&forceview=1 | ⏳ |

---

## 📋 CHECKLIST

- [ ] 5.1 — Qué es JSON e importación del módulo
- [ ] 5.2 — Parsear objetos: `json.loads()` y `json.load()`
- [ ] 5.3 — Convertir a JSON: `json.dumps()`
- [ ] 5.4 — Guardar en archivo: `json.dump()`
- [ ] 5.5 — Imprimir con `indent` y `sort_keys`
- [ ] 5.6 — JSON vs XML
- [ ] 5.7 — JSON minifier
- [ ] Quiz T2
- [ ] Block puzzle T2

---

## 📝 5.1 — Qué es JSON

JSON (JavaScript Object Notation) es un formato de datos popular para representar datos estructurados. Se usa principalmente para transmitir datos entre servidor y aplicación web, y también para almacenar datos en ficheros.

En Python, JSON existe como una **cadena de texto (string)**:
```python
p = '{"name": "Bob", "languages": ["Python", "Java"]}'
```

Para trabajar con JSON hay que importar el módulo:
```python
import json
```

> ⚠️ `json` es un módulo **de la librería estándar** de Python — no necesita instalación, solo importarlo.

---

## 📝 5.2 — Parsear objetos (JSON → Python)

Dos métodos según si el JSON viene como **string** o como **archivo**:

### `json.loads()` — parsea un STRING JSON → diccionario Python
```python
import json

person = '{"name": "Bob", "languages": ["English", "French"]}'
person_dict = json.loads(person)

print(person_dict)              # {'name': 'Bob', 'languages': ['English', 'French']}
print(person_dict['languages']) # ['English', 'French']
```

### `json.load()` — lee un ARCHIVO JSON → diccionario Python
```python
import json

with open('person.json', 'r') as f:
    data = json.load(f)

print(data)  # {'name': 'Bob', 'languages': ['English', 'French']}
```

> **Truco para no confundirlos:**
> - `json.load**s**()` → la **s** es de **s**tring → parsea un string
> - `json.load()` → sin s → lee un **archivo**

---

## 📝 5.3 — Convertir objetos a JSON (Python → JSON)

### `json.dumps()` — diccionario Python → STRING JSON
```python
import json

person_dict = {'name': 'Bob', 'age': 12, 'children': None}
person_json = json.dumps(person_dict)

print(person_json)        # {"name": "Bob", "age": 12, "children": null}
print(type(person_json))  # <class 'str'>
```

### Tabla de equivalencias Python ↔ JSON

| Python | JSON |
|--------|------|
| `dict` | `object` |
| `list`, `tuple` | `array` |
| `str` | `string` |
| `int`, `float` | `number` |
| `True` | `true` |
| `False` | `false` |
| `None` | `null` |

> ⚠️ Ojo: en JSON las booleanas son minúsculas (`true`/`false`) y `None` se convierte a `null`.

---

## 📝 5.4 — Guardar JSON en archivo

### `json.dump()` — diccionario Python → ARCHIVO JSON
```python
import json

person_dict = {
    "name": "Bob",
    "languages": ["English", "French"],
    "married": True,
    "age": 32
}

with open('person.txt', 'w') as json_file:
    json.dump(person_dict, json_file)
# Resultado en person.txt:
# {"name": "Bob", "languages": ["English", "French"], "married": true, "age": 32}
```

> Si el archivo no existe, Python lo **crea automáticamente**.

---

## 📝 5.5 — Imprimir objetos JSON con formato

`indent` y `sort_keys` hacen el JSON legible para humanos:

```python
import json

person_string = '{"name": "Bob", "languages": "English", "numbers": [2, 1.6, null]}'
person_dict = json.loads(person_string)

print(json.dumps(person_dict, indent=4, sort_keys=True))
```
Salida:
```json
{
    "languages": "English",
    "name": "Bob",
    "numbers": [
        2,
        1.6,
        null
    ]
}
```

- `indent=4` → indenta con 4 espacios (por defecto `None`)
- `sort_keys=True` → ordena las claves alfabéticamente (por defecto `False`)

---

## 📝 5.6 — JSON vs XML

| | JSON | XML |
|--|------|-----|
| Tipo | Formato de datos | Lenguaje de marcado |
| Estructura | Pares clave-valor | Árbol de etiquetas |
| Tipado | Sí (string, number, array, boolean) | No (todo son strings) |
| Velocidad | Rápido de parsear | Lento de parsear |
| Tamaño | Ficheros más pequeños | Ficheros más grandes |
| Lectura | Fácil | Más compleja |
| Codificación | UTF y ASCII | UTF-8 y UTF-16 |
| Uso hoy | Estándar en APIs web modernas | Legacy, configuraciones |

> **Conclusión:** JSON ha ganado la batalla para APIs web. XML sigue usándose en sistemas antiguos y configuraciones (ej: Android, Maven).

---

## 📝 5.7 — JSON Minifier

La **minificación** elimina espacios, saltos de línea y caracteres innecesarios del JSON sin cambiar su contenido. Reduce el tamaño del archivo para transmisión más rápida por red.

```json
// Antes (legible, más pesado)
{
  "id": 5,
  "age": 38,
  "Name": "Siddhika"
}

// Después de minificar (más ligero y rápido en red)
{"id":5,"age":38,"Name":"Siddhika"}
```

En Python, `json.dumps()` **sin** `indent` ya produce JSON minificado por defecto.

---

## 📝 RESUMEN — Los 4 métodos clave

| Método | Entrada | Salida |
|--------|---------|--------|
| `json.loads(str)` | JSON string | dict Python |
| `json.load(file)` | Archivo JSON | dict Python |
| `json.dumps(dict)` | dict Python | JSON string |
| `json.dump(dict, file)` | dict Python | Archivo JSON |

---

## ✅ QUIZ / BLOQUE PUZZLE

_Pendiente completar_

---
_Creado: 16 marzo 2026 | Apuntes del PDF completados_
