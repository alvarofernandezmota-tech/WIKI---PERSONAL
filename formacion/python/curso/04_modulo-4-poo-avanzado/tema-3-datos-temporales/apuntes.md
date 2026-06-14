# Tema 3. Datos Temporales — datetime

> M4 · POO Avanzado · Escuela Musk  
> Clase en vivo: Jueves 5 Febrero 2026, 19:30

**Estado:** ✅ Apuntes clase en vivo completos

---

## 📌 RECURSOS DEL TEMA

| Recurso | Estado |
|---------|--------|
| M4-T3.pdf | ✅ |
| 01_datetime_basico.py | ✅ |
| 02_timedelta.py | ✅ |
| 03_zonas_horarias.py | ✅ |
| ejercicios_tema3.py | ✅ |

---

## 📝 APUNTES — Clase en vivo 05/02/2026

### 1. OBJETO DATE — Fechas

```python
from datetime import date

# Fecha específica
fecha = date(2026, 2, 5)  # año, mes, día

# Fecha de HOY
hoy = date.today()

# Acceder a componentes
print(fecha.year)      # 2026
print(fecha.month)     # 2
print(fecha.day)       # 5
print(fecha.weekday()) # 3 (jueves — 0=lunes, 6=domingo)

# Comparar fechas
fecha1 = date(2026, 2, 5)
fecha2 = date(2026, 2, 10)
if fecha1 < fecha2:
    print("fecha1 es anterior")  # ✅
```

---

### 2. OBJETO TIME — Horas

```python
from datetime import time

hora = time(15, 30, 0)        # hora, minuto, segundo
hora2 = time(15, 30, 45, 123456)  # con microsegundos

print(hora.hour)    # 15
print(hora.minute)  # 30
print(hora.second)  # 45
```

---

### 3. OBJETO DATETIME — Fecha + Hora

```python
from datetime import datetime

fecha_hora = datetime(2026, 2, 5, 15, 30, 0)
ahora = datetime.now()     # AHORA (fecha + hora actual)
hoy = datetime.today()     # Solo fecha de hoy

# Extraer partes
solo_fecha = ahora.date()  # objeto date
solo_hora = ahora.time()   # objeto time
```

---

### 4. TIMEDELTA — Duraciones

```python
from datetime import timedelta

# Crear duraciones
una_semana  = timedelta(weeks=1)
cinco_dias  = timedelta(days=5)
tres_horas  = timedelta(hours=3)
duracion    = timedelta(days=5, hours=3, minutes=30)

# Sumar/restar a fechas
hoy = date.today()
manana    = hoy + timedelta(days=1)
ayer      = hoy - timedelta(days=1)
en_semana = hoy + timedelta(weeks=1)

# Diferencia entre fechas
fecha1 = date(2026, 2, 5)
fecha2 = date(2026, 2, 10)
diferencia = fecha2 - fecha1
print(diferencia.days)            # 5
print(duracion.total_seconds())   # total en segundos
```

---

### 5. strftime() — Fecha a String

> **strftime = String FROM Time**

```python
hoy = date.today()

hoy.strftime("%Y-%m-%d")        # 2026-02-05
hoy.strftime("%d/%m/%Y")        # 05/02/2026
hoy.strftime("%d de %B de %Y")  # 05 de February de 2026
ahora.strftime("%d/%m/%Y %H:%M:%S")  # 05/02/2026 19:30:15
```

**Códigos más usados:**

| Código | Significado | Ejemplo |
|--------|-------------|--------|
| `%Y` | Año con siglo | 2026 |
| `%m` | Mes número (01-12) | 02 |
| `%B` | Mes nombre completo | February |
| `%d` | Día del mes | 05 |
| `%A` | Día semana completo | Thursday |
| `%H` | Hora 24h | 19 |
| `%M` | Minuto | 30 |
| `%S` | Segundo | 45 |
| `%p` | AM/PM | PM |

---

### 6. strptime() — String a Fecha

> **strptime = String PARSE Time**

```python
from datetime import datetime

# String → datetime
fecha_obj = datetime.strptime("2026-02-05", "%Y-%m-%d")
fecha_obj = datetime.strptime("05/02/2026", "%d/%m/%Y")
fecha_obj = datetime.strptime("05/02/2026 19:30", "%d/%m/%Y %H:%M")

# Convertir a solo date
fecha_solo = fecha_obj.date()
```

---

### 7. Validar fechas

```python
def validar_fecha(fecha_str):
    try:
        datetime.strptime(fecha_str, "%Y-%m-%d")
        return True
    except ValueError:
        return False
```

---

### 8. Casos de uso — THDORA 🏥

```python
# Citas de hoy
def citas_de_hoy(lista_citas):
    hoy = date.today()
    return [c for c in lista_citas if c["fecha"] == str(hoy)]

# Próximas citas (7 días)
def proximas_citas(lista_citas, dias=7):
    hoy = date.today()
    limite = hoy + timedelta(days=dias)
    return [c for c in lista_citas
            if hoy <= datetime.strptime(c["fecha"], "%Y-%m-%d").date() <= limite]

# Días que faltan
def dias_restantes(fecha_cita_str):
    return (datetime.strptime(fecha_cita_str, "%Y-%m-%d").date() - date.today()).days

# Mensaje inteligente
def mensaje_cita(fecha_str):
    dias = dias_restantes(fecha_str)
    if dias == 0: return "¡HOY!"
    if dias == 1: return "Mañana"
    if dias > 1:  return f"En {dias} días"
    return f"Hace {abs(dias)} días"
```

---

## 🧠 RESUMEN RÁPIDO

| Objeto | Para qué |
|--------|----------|
| `date` | Solo fechas (sin hora) |
| `time` | Solo horas (sin fecha) |
| `datetime` | Fecha + hora combinadas |
| `timedelta` | Duraciones y diferencias |
| `strftime` | Fecha → String (formato) |
| `strptime` | String → Fecha (parsear) |

---
_Documentado: 5 febrero 2026 · Clase en vivo Escuela Musk_
