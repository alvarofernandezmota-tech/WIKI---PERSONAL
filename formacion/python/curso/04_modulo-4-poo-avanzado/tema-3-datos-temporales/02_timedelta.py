"""Tema 3.2: timedelta - Operaciones con Fechas y Horas

Este archivo demuestra cómo realizar operaciones aritméticas
con fechas y horas usando timedelta.
"""

from datetime import datetime, date, timedelta


# =============================================================================
# EJEMPLO 1: Crear timedelta
# =============================================================================

print("=" * 60)
print("EJEMPLO 1: Crear timedelta")
print("=" * 60)

# Diferentes formas de crear timedelta
un_dia       = timedelta(days=1)
una_semana   = timedelta(weeks=1)
tres_horas   = timedelta(hours=3)
diez_minutos = timedelta(minutes=10)
delta_mixto  = timedelta(days=2, hours=5, minutes=30)

print(f"\n1 día:          {un_dia}")
print(f"1 semana:       {una_semana}")
print(f"3 horas:        {tres_horas}")
print(f"10 minutos:     {diez_minutos}")
print(f"2d 5h 30m:      {delta_mixto}")
print(f"\nEn segundos:    {delta_mixto.total_seconds()} segundos")


# =============================================================================
# EJEMPLO 2: Aritmética con fechas
# =============================================================================

print("\n" + "=" * 60)
print("EJEMPLO 2: Sumar y restar fechas")
print("=" * 60)

hoy = date.today()
ahora = datetime.now()

# Sumar
mañana      = hoy + timedelta(days=1)
pasado      = hoy + timedelta(days=2)
la_semana_q = hoy + timedelta(weeks=1)
en_30_dias  = hoy + timedelta(days=30)

print(f"\nHoy:              {hoy}")
print(f"Mañana:           {mañana}")
print(f"Pasado mañana:    {pasado}")
print(f"En 1 semana:      {la_semana_q}")
print(f"En 30 días:       {en_30_dias}")

# Restar
ayer        = hoy - timedelta(days=1)
hace_semana = hoy - timedelta(weeks=1)
hace_mes    = hoy - timedelta(days=30)

print(f"\nAyer:             {ayer}")
print(f"Hace 1 semana:    {hace_semana}")
print(f"Hace 30 días:     {hace_mes}")


# =============================================================================
# EJEMPLO 3: Diferencia entre fechas
# =============================================================================

print("\n" + "=" * 60)
print("EJEMPLO 3: Diferencia entre fechas")
print("=" * 60)

fecha_inicio = date(2026, 1, 1)
fecha_fin    = date(2026, 12, 31)

delta = fecha_fin - fecha_inicio
print(f"\nInicio:           {fecha_inicio}")
print(f"Fin:              {fecha_fin}")
print(f"Diferencia:       {delta}")
print(f"Días totales:     {delta.days}")
print(f"Semanas:          {delta.days // 7}")

# Diferencia con datetime (incluye horas)
dt1 = datetime(2026, 3, 11, 8, 0, 0)
dt2 = datetime(2026, 3, 11, 17, 30, 0)
jornada = dt2 - dt1
print(f"\nEntrada trabajo:  {dt1.time()}")
print(f"Salida trabajo:   {dt2.time()}")
print(f"Horas trabajadas: {jornada}")
print(f"En segundos:      {jornada.total_seconds()}")
print(f"En horas:         {jornada.total_seconds() / 3600:.1f}h")


# =============================================================================
# EJEMPLO 4: Casos prácticos
# =============================================================================

print("\n" + "=" * 60)
print("EJEMPLO 4: Casos prácticos")
print("=" * 60)

# Calcular edad
def calcular_edad(fecha_nacimiento: date) -> int:
    hoy = date.today()
    edad = hoy.year - fecha_nacimiento.year
    # Ajustar si aún no ha pasado el cumpleaños este año
    if (hoy.month, hoy.day) < (fecha_nacimiento.month, fecha_nacimiento.day):
        edad -= 1
    return edad

nacimiento = date(1995, 7, 20)
print(f"\nFecha nacimiento: {nacimiento}")
print(f"Edad actual:      {calcular_edad(nacimiento)} años")

# Días hasta evento
def dias_hasta(fecha_evento: date) -> int:
    return (fecha_evento - date.today()).days

navidad = date(2026, 12, 25)
print(f"\nNavidad:          {navidad}")
print(f"Días hasta:       {dias_hasta(navidad)} días")

# Verificar si una fecha ya pasó
def ya_paso(fecha: date) -> bool:
    return fecha < date.today()

fecha_pasada = date(2025, 1, 1)
fecha_futura = date(2027, 1, 1)
print(f"\n{fecha_pasada} ya pasó: {ya_paso(fecha_pasada)}")
print(f"{fecha_futura} ya pasó: {ya_paso(fecha_futura)}")


print("\n" + "=" * 60)
print("✅ timedelta y operaciones con fechas dominados")
print("=" * 60)
