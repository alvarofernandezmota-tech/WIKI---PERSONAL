# 📅 Apuntes - Clase 17 Febrero 2026
## Módulo 3 - POO: datetime y timedelta

**Fecha:** Martes, 17 de febrero 2026  
**Horario:** 20:00-21:00  
**Profesor:** José Antonio Mosqueda  
**Tema:** Objetos tipo date - datetime y timedelta  

---

## 📚 LIBRERÍAS PRINCIPALES

### Importación
```python
from datetime import datetime, timedelta, timezone
```

---

## 🌍 DOS TIPOS DE OBJETOS DATETIME

### **1. NAIVE (Sin timezone)**
❌ **NO tiene información de zona horaria**

```python
fecha_naive = datetime.now()  # ← NAIVE
print(fecha_naive)  # 2026-02-17 19:34:00
print(fecha_naive.tzinfo)  # None
```

**Características:**
- `.tzinfo` es `None`
- Asume zona horaria local (pero no la guarda)
- Más simple pero menos preciso
- **Uso:** Proyectos personales, ejercicios, apps locales

### **2. AWARE (Con timezone)**
✅ **SÍ tiene información de zona horaria**

```python
fecha_aware = datetime.now(timezone.utc)  # ← AWARE
print(fecha_aware)  # 2026-02-17 18:34:00+00:00
print(fecha_aware.tzinfo)  # UTC
```

**Características:**
- `.tzinfo` tiene valor (UTC, etc.)
- Sabe exactamente en qué zona horaria está
- Más preciso y correcto
- **Uso:** Apps profesionales, usuarios internacionales

### **Comparación:**

| Aspecto | NAIVE | AWARE |
|---------|-------|-------|
| **Zona horaria** | ❌ NO tiene | ✅ SÍ tiene |
| **tzinfo** | `None` | Objeto timezone |
| **Creación** | `datetime.now()` | `datetime.now(timezone.utc)` |
| **Uso** | Simple, local | Preciso, global |
| **Ejemplo** | `2026-02-17 19:34:00` | `2026-02-17 18:34:00+00:00` |

### **⚠️ IMPORTANTE:**
```python
# ❌ NO puedes comparar NAIVE con AWARE
naive = datetime.now()
aware = datetime.now(timezone.utc)

if naive < aware:  # TypeError!
    print("Error")

# ✅ Ambos deben ser del mismo tipo
```

### **Convertir entre NAIVE y AWARE:**

```python
# NAIVE → AWARE
naive = datetime.now()
aware = naive.replace(tzinfo=timezone.utc)

# AWARE → NAIVE
aware = datetime.now(timezone.utc)
naive = aware.replace(tzinfo=None)
```

---

## 🕐 DATETIME

### ¿Qué es?
- Clase de Python para trabajar con fechas y horas
- Representa un momento específico en el tiempo
- **Objeto INMUTABLE** (no se puede modificar, se crea uno nuevo)

### Métodos principales

#### `datetime.now()` - Momento actual
```python
ahora = datetime.now()  # NAIVE
print(ahora)  # 2026-02-17 20:15:30.123456

ahora_utc = datetime.now(timezone.utc)  # AWARE
print(ahora_utc)  # 2026-02-17 19:15:30.123456+00:00
```

#### Crear fecha específica
```python
fecha = datetime(2026, 2, 17, 19, 0, 0)
# año, mes, día, hora, minuto, segundo

# Con timezone (AWARE)
fecha_aware = datetime(2026, 2, 17, 19, 0, 0, tzinfo=timezone.utc)
```

#### Obtener componentes
```python
ahora = datetime.now()
print(ahora.year)    # 2026
print(ahora.month)   # 2
print(ahora.day)     # 17
print(ahora.hour)    # 20
print(ahora.minute)  # 15
print(ahora.second)  # 30
```

#### Formatear fechas (strftime)
```python
ahora = datetime.now()
print(ahora.strftime("%Y-%m-%d"))  # 2026-02-17
print(ahora.strftime("%d/%m/%Y"))  # 17/02/2026
print(ahora.strftime("%H:%M:%S"))  # 20:15:30
```

#### Parsear fechas (strptime)
```python
fecha_texto = "2026-02-17"
fecha = datetime.strptime(fecha_texto, "%Y-%m-%d")

# Con timezone
fecha_con_tz = "17-Feb-2026 14:45:00 +0200"
fecha_aware = datetime.strptime(fecha_con_tz, "%d-%b-%Y %H:%M:%S %z")
```

#### Conversión de zonas horarias
```python
# Convertir a UTC
fecha_local = datetime.now()
fecha_utc = fecha_local.astimezone(timezone.utc)

# Convertir entre zonas
fecha_aware = datetime.now(timezone.utc)
fecha_otra_zona = fecha_aware.astimezone(otra_timezone)
```

---

## ⏱️ TIMEDELTA

### ¿Qué es?
- Representa una duración o diferencia entre dos momentos
- Se usa para sumar/restar tiempo a fechas

### Crear timedelta
```python
una_semana = timedelta(days=7)
tres_horas = timedelta(hours=3)
dos_dias_medio = timedelta(days=2, hours=12)
```

### Parámetros disponibles
```python
timedelta(
    days=0,
    seconds=0,
    microseconds=0,
    milliseconds=0,
    minutes=0,
    hours=0,
    weeks=0
)
```

### Sumar tiempo a una fecha
```python
ahora = datetime.now()
manana = ahora + timedelta(days=1)
la_proxima_semana = ahora + timedelta(weeks=1)
en_tres_horas = ahora + timedelta(hours=3)
```

### Restar tiempo a una fecha
```python
ahora = datetime.now()
ayer = ahora - timedelta(days=1)
hace_una_semana = ahora - timedelta(weeks=1)
```

### Diferencia entre dos fechas
```python
fecha1 = datetime(2026, 2, 17)
fecha2 = datetime(2026, 2, 25)

diferencia = fecha2 - fecha1  # Devuelve timedelta
print(diferencia.days)  # 8
print(diferencia.seconds)  # 0
print(diferencia.total_seconds())  # 691200.0
```

---

## 🔄 OPERACIONES CON FECHAS

### Comparar fechas
```python
fecha1 = datetime(2026, 2, 17)
fecha2 = datetime(2026, 2, 20)

if fecha1 < fecha2:
    print("fecha1 es anterior")

if fecha2 > fecha1:
    print("fecha2 es posterior")

if fecha1 == fecha1:
    print("Son iguales")
```

### Calcular días entre fechas
```python
hoy = datetime.now()
vencimiento = datetime(2026, 2, 25)
diferencia = vencimiento - hoy
dias_restantes = diferencia.days
print(f"Quedan {dias_restantes} días")
```

---

## 💡 EJEMPLOS PRÁCTICOS

### Ejemplo 1: Tarea con fecha de vencimiento
```python
from datetime import datetime, timedelta

class Tarea:
    def __init__(self, titulo, dias_plazo=7):
        self.titulo = titulo
        self.fecha_creacion = datetime.now()
        self.fecha_vencimiento = datetime.now() + timedelta(days=dias_plazo)
        self.completada = False
    
    def dias_restantes(self):
        if self.completada:
            return 0
        diferencia = self.fecha_vencimiento - datetime.now()
        return diferencia.days
    
    def esta_vencida(self):
        return datetime.now() > self.fecha_vencimiento and not self.completada

# Uso
tarea = Tarea("Estudiar POO", dias_plazo=3)
print(f"Días restantes: {tarea.dias_restantes()}")
print(f"¿Vencida?: {tarea.esta_vencida()}")
```

### Ejemplo 2: Registro de hábitos
```python
from datetime import datetime, timedelta

class Habito:
    def __init__(self, nombre):
        self.nombre = nombre
        self.registros = []  # Lista de fechas
    
    def registrar(self):
        self.registros.append(datetime.now())
    
    def hecho_hoy(self):
        if not self.registros:
            return False
        hoy = datetime.now().date()
        ultimo = self.registros[-1].date()
        return ultimo == hoy
    
    def registros_ultima_semana(self):
        hace_7_dias = datetime.now() - timedelta(days=7)
        return [r for r in self.registros if r >= hace_7_dias]

# Uso
habito = Habito("Ejercicio")
habito.registrar()
print(f"¿Hecho hoy?: {habito.hecho_hoy()}")
print(f"Registros semana: {len(habito.registros_ultima_semana())}")
```

### Ejemplo 3: Filtrar tareas próximas
```python
class GestorTareas:
    def __init__(self):
        self.tareas = []
    
    def agregar_tarea(self, titulo, dias_plazo):
        tarea = Tarea(titulo, dias_plazo)
        self.tareas.append(tarea)
    
    def tareas_proximas(self, dias=7):
        """Tareas que vencen en los próximos X días"""
        limite = datetime.now() + timedelta(days=dias)
        return [t for t in self.tareas 
                if not t.completada and t.fecha_vencimiento <= limite]
    
    def tareas_vencidas(self):
        """Tareas que ya pasaron su fecha de vencimiento"""
        return [t for t in self.tareas if t.esta_vencida()]
```

---

## 🎯 EJERCICIO AVANZADO: SERVIDOR CON TIMEZONES

### **Enunciado:**
Tienes un servidor en Londres (UTC) que registra eventos. Debes calcular cuánto tiempo ha pasado entre un error y su resolución, pero los datos vienen en formatos distintos y uno de ellos incluye un desfase horario manual.

- **Evento A (Error):** "2026-02-15 08:30:00" (Asume que es UTC)
- **Evento B (Resolución):** "17-Feb-2026 14:45:00 +0200" (Tiene un offset de +2 horas)
- **Objetivo:** Calcular la diferencia exacta en formato: "X días, Y horas y Z minutos"

### **Solución completa:**

```python
from datetime import datetime, timezone

# ============================================
# PASO 1: PARSEAR EVENTO A (Error)
# ============================================

# Texto del evento A
evento_a_texto = "2026-02-15 08:30:00"

# Convertir texto a datetime (NAIVE)
evento_a_naive = datetime.strptime(evento_a_texto, "%Y-%m-%d %H:%M:%S")
print(f"Evento A naive: {evento_a_naive}")
# 2026-02-15 08:30:00

# Hacerlo AWARE (añadir que es UTC)
evento_a_utc = evento_a_naive.replace(tzinfo=timezone.utc)
print(f"Evento A UTC: {evento_a_utc}")
# 2026-02-15 08:30:00+00:00

# ============================================
# PASO 2: PARSEAR EVENTO B (Resolución)
# ============================================

# Texto del evento B
evento_b_texto = "17-Feb-2026 14:45:00 +0200"

# Convertir texto a datetime (ya incluye timezone)
evento_b_con_offset = datetime.strptime(evento_b_texto, "%d-%b-%Y %H:%M:%S %z")
print(f"Evento B con offset: {evento_b_con_offset}")
# 2026-02-17 14:45:00+02:00

# Convertir B a UTC (para comparar igual)
evento_b_utc = evento_b_con_offset.astimezone(timezone.utc)
print(f"Evento B en UTC: {evento_b_utc}")
# 2026-02-17 12:45:00+00:00
# ↑ Nota: 14:45 con +2 = 12:45 UTC

# ============================================
# PASO 3: CALCULAR DIFERENCIA
# ============================================

diferencia = evento_b_utc - evento_a_utc
print(f"Diferencia: {diferencia}")
# 2 days, 4:15:00

# ============================================
# PASO 4: EXTRAER DÍAS, HORAS, MINUTOS
# ============================================

dias = diferencia.days
segundos_restantes = diferencia.seconds

# Calcular horas y minutos
horas = segundos_restantes // 3600  # 3600 segundos = 1 hora
minutos = (segundos_restantes % 3600) // 60  # Resto en minutos

# ============================================
# PASO 5: MOSTRAR RESULTADO
# ============================================

print(f"\n✅ RESULTADO:")
print(f"La resolución tardó {dias} días, {horas} horas y {minutos} minutos")
```

### **Resultado:**
```
Evento A naive: 2026-02-15 08:30:00
Evento A UTC: 2026-02-15 08:30:00+00:00
Evento B con offset: 2026-02-17 14:45:00+02:00
Evento B en UTC: 2026-02-17 12:45:00+00:00
Diferencia: 2 days, 4:15:00

✅ RESULTADO:
La resolución tardó 2 días, 4 horas y 15 minutos
```

### **Conceptos clave usados:**
- `strptime()` → Convertir texto a datetime
- `replace(tzinfo=...)` → NAIVE → AWARE
- `astimezone()` → Convertir entre zonas horarias
- `datetime - datetime` → Calcular diferencia (timedelta)
- `timedelta.days` y `timedelta.seconds` → Extraer componentes
- `//` (división entera) y `%` (módulo) → Calcular horas y minutos

---

## 📊 FORMATO DE FECHAS (CÓDIGOS)

| Código | Significado | Ejemplo |
|--------|-------------|----------|
| `%Y` | Año (4 dígitos) | 2026 |
| `%y` | Año (2 dígitos) | 26 |
| `%m` | Mes (2 dígitos) | 02 |
| `%b` | Mes abreviado | Feb |
| `%B` | Mes completo | February |
| `%d` | Día (2 dígitos) | 17 |
| `%H` | Hora (24h) | 20 |
| `%I` | Hora (12h) | 08 |
| `%M` | Minuto | 15 |
| `%S` | Segundo | 30 |
| `%p` | AM/PM | PM |
| `%A` | Día de semana completo | Tuesday |
| `%a` | Día de semana abreviado | Tue |
| `%z` | Offset timezone | +0200 |
| `%Z` | Nombre timezone | UTC |

### Ejemplos de formato
```python
ahora = datetime.now()

print(ahora.strftime("%Y-%m-%d"))           # 2026-02-17
print(ahora.strftime("%d/%m/%Y"))           # 17/02/2026
print(ahora.strftime("%Y-%m-%d %H:%M:%S"))  # 2026-02-17 20:15:30
print(ahora.strftime("%A, %d %B %Y"))      # Tuesday, 17 February 2026
print(ahora.strftime("%d-%b-%Y %H:%M:%S"))  # 17-Feb-2026 20:15:30
```

---

## ⚡ MÉTODOS ÚTILES

### `.date()` - Solo la fecha (sin hora)
```python
ahora = datetime.now()
solo_fecha = ahora.date()
print(solo_fecha)  # 2026-02-17
```

### `.time()` - Solo la hora (sin fecha)
```python
ahora = datetime.now()
solo_hora = ahora.time()
print(solo_hora)  # 20:15:30.123456
```

### `.total_seconds()` - Timedelta a segundos
```python
una_semana = timedelta(days=7)
segundos = una_semana.total_seconds()
print(segundos)  # 604800.0
```

### `.replace()` - Cambiar componentes
```python
ahora = datetime.now()
manana_misma_hora = ahora.replace(day=ahora.day + 1)

# Añadir timezone
naive = datetime.now()
aware = naive.replace(tzinfo=timezone.utc)
```

### `.astimezone()` - Convertir zona horaria
```python
utc_time = datetime.now(timezone.utc)
local_time = utc_time.astimezone()  # Zona local del sistema
```

---

## 🎯 CASOS DE USO EN GESTOR DE TAREAS

### 1. Agregar tarea con vencimiento
```python
def agregar_tarea(self, titulo, dias_plazo=7):
    fecha_vencimiento = datetime.now() + timedelta(days=dias_plazo)
    tarea = Tarea(titulo, fecha_vencimiento)
    self.tareas.append(tarea)
```

### 2. Listar tareas urgentes (vencen en 3 días)
```python
def tareas_urgentes(self):
    limite = datetime.now() + timedelta(days=3)
    return [t for t in self.tareas 
            if not t.completada and t.fecha_vencimiento <= limite]
```

### 3. Ordenar tareas por fecha
```python
def ordenar_por_fecha(self):
    return sorted(self.tareas, key=lambda t: t.fecha_vencimiento)
```

### 4. Estadísticas de completado
```python
def tiempo_promedio_completado(self):
    completadas = [t for t in self.tareas if t.completada]
    if not completadas:
        return 0
    
    total_segundos = 0
    for tarea in completadas:
        diferencia = tarea.fecha_completado - tarea.fecha_creacion
        total_segundos += diferencia.total_seconds()
    
    promedio_segundos = total_segundos / len(completadas)
    return promedio_segundos / 86400  # Convertir a días
```

---

## 🔑 CONCEPTOS CLAVE

### **Objetos inmutables:**
- **datetime** es INMUTABLE (no se modifica, se crea nuevo)
- **timedelta** es INMUTABLE
- Para "cambiar" un datetime, usas `.replace()` que devuelve uno nuevo

### **Operaciones:**
- **datetime** = Momento específico en el tiempo
- **timedelta** = Duración o diferencia de tiempo
- **datetime + timedelta** = Nueva fecha en el futuro
- **datetime - timedelta** = Nueva fecha en el pasado
- **datetime - datetime** = timedelta (diferencia)
- **Comparaciones** = `<`, `>`, `==`, `<=`, `>=` funcionan con datetime

### **Tipos de datetime:**
- **NAIVE** = Sin timezone (`.tzinfo` es `None`)
- **AWARE** = Con timezone (`.tzinfo` tiene valor)
- ⚠️ No mezclar NAIVE y AWARE en operaciones

---

## ✅ RESUMEN

### Para trabajar con fechas:
1. Importar: `from datetime import datetime, timedelta, timezone`
2. Momento actual: `datetime.now()` (NAIVE) o `datetime.now(timezone.utc)` (AWARE)
3. Crear fecha: `datetime(año, mes, día, hora, minuto, segundo)`
4. Parsear texto: `datetime.strptime(texto, formato)`
5. Sumar tiempo: `fecha + timedelta(days=X)`
6. Restar tiempo: `fecha - timedelta(days=X)`
7. Diferencia: `fecha2 - fecha1` devuelve timedelta
8. Comparar: `fecha1 < fecha2`, `fecha1 > fecha2`
9. Convertir timezone: `.astimezone(timezone_destino)`
10. NAIVE → AWARE: `.replace(tzinfo=timezone.utc)`

### Para tu Gestor de Tareas:
- ✅ Fecha de vencimiento de tareas
- ✅ Calcular días restantes
- ✅ Detectar tareas vencidas
- ✅ Filtrar tareas próximas
- ✅ Ordenar por urgencia
- ✅ Estadísticas temporales

---

## 📝 NOTAS ADICIONALES

### **Ejercicios adicionales de clase:**

*(Aquí irán los ejercicios que compartas)*



---

## 🔗 ENLACES ÚTILES

- Documentación Python datetime: https://docs.python.org/3/library/datetime.html
- Códigos de formato: https://strftime.org/
- Zonas horarias (pytz): https://pypi.org/project/pytz/

---

**Siguiente clase:** [Pendiente]
**Tema relacionado:** Gestor de Tareas (Práctica POO)
========================================================
Tienes un servidor en Londres (UTC) que registra eventos. Debes calcular cuánto tiempo ha pasado entre un error y su resolución, pero los datos vienen en formatos distintos y uno de ellos incluye un desfase horario manual.

El Reto:

Evento A (Error): "2026-02-15 08:30:00" (Asume que es UTC).

Evento B (Resolución): "17-Feb-2026 14:45:00 +0200" (Tiene un offset de +2 horas).

Objetivo: Calcula la diferencia exacta. El resultado debe mostrarse en un formato amigable: "La resolución tardó X días, Y horas y Z minuto".

evento_a_texto = "2026-02-15 08:30:00"