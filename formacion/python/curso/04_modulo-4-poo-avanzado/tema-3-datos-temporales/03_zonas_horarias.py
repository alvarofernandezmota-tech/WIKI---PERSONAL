"""Tema 3.3: Zonas Horarias - pytz y timezone

Este archivo demuestra cómo trabajar con zonas horarias
usando pytz y el módulo zoneinfo (Python 3.9+).
"""

from datetime import datetime, timezone, timedelta
import pytz


# =============================================================================
# EJEMPLO 1: Naive vs Aware datetime
# =============================================================================

print("=" * 60)
print("EJEMPLO 1: Naive vs Aware datetime")
print("=" * 60)

# NAIVE: sin información de zona horaria
dt_naive = datetime.now()
print(f"\nNaive datetime:   {dt_naive}")
print(f"tzinfo:           {dt_naive.tzinfo}  ← None = naive")

# AWARE: con información de zona horaria
dt_utc = datetime.now(timezone.utc)
print(f"\nAware UTC:        {dt_utc}")
print(f"tzinfo:           {dt_utc.tzinfo}")


# =============================================================================
# EJEMPLO 2: pytz - Zonas horarias del mundo
# =============================================================================

print("\n" + "=" * 60)
print("EJEMPLO 2: Zonas horarias con pytz")
print("=" * 60)

# Crear datetimes en diferentes zonas
zonas = {
    "Madrid":    "Europe/Madrid",
    "Nueva York": "America/New_York",
    "Tokio":     "Asia/Tokyo",
    "Londres":   "Europe/London",
    "Dubai":     "Asia/Dubai",
}

print("\nMismo instante en diferentes zonas:")
for ciudad, zona_str in zonas.items():
    zona = pytz.timezone(zona_str)
    dt_zona = datetime.now(zona)
    print(f"  {ciudad:<15} {dt_zona.strftime('%d/%m/%Y %H:%M:%S %Z')}")


# =============================================================================
# EJEMPLO 3: Convertir entre zonas horarias
# =============================================================================

print("\n" + "=" * 60)
print("EJEMPLO 3: Convertir entre zonas")
print("=" * 60)

# Crear un datetime en Madrid
madrid_tz = pytz.timezone("Europe/Madrid")
dt_madrid = datetime.now(madrid_tz)
print(f"\nMadrid:    {dt_madrid.strftime('%H:%M:%S %Z')}")

# Convertir a otras zonas
ny_tz     = pytz.timezone("America/New_York")
tokio_tz  = pytz.timezone("Asia/Tokyo")
utc_tz    = pytz.utc

dt_ny     = dt_madrid.astimezone(ny_tz)
dt_tokio  = dt_madrid.astimezone(tokio_tz)
dt_utc    = dt_madrid.astimezone(utc_tz)

print(f"Nueva York:{dt_ny.strftime('%H:%M:%S %Z')}")
print(f"Tokio:     {dt_tokio.strftime('%H:%M:%S %Z')}")
print(f"UTC:       {dt_utc.strftime('%H:%M:%S %Z')}")


# =============================================================================
# EJEMPLO 4: Localizar un datetime naive
# =============================================================================

print("\n" + "=" * 60)
print("EJEMPLO 4: Localizar datetime naive")
print("=" * 60)

# Datetime naive (sin zona)
dt_sin_zona = datetime(2026, 6, 15, 10, 0, 0)
print(f"\nNaive:     {dt_sin_zona}  (sin zona)")

# Asignarle una zona horaria
dt_localizado = madrid_tz.localize(dt_sin_zona)
print(f"Localizado: {dt_localizado}  (con zona)")

# Convertir a UTC
dt_en_utc = dt_localizado.astimezone(pytz.utc)
print(f"En UTC:    {dt_en_utc}")


# =============================================================================
# EJEMPLO 5: UTC como referencia universal
# =============================================================================

print("\n" + "=" * 60)
print("EJEMPLO 5: UTC como referencia")
print("=" * 60)

print("""
💡 Buenas prácticas con zonas horarias:

  ✅ Guardar siempre en UTC en base de datos
  ✅ Convertir a zona local solo para mostrar al usuario
  ✅ Usar always aware datetimes en producción
  ✅ pytz.utc para crear datetimes UTC
  ⚠️  Nunca mezclar naive y aware en operaciones
  ⚠️  Cuidado con el horario de verano (DST)
""")

utc_ahora = datetime.now(pytz.utc)
print(f"UTC ahora:  {utc_ahora.strftime('%Y-%m-%d %H:%M:%S %Z')}")
print(f"Timestamp: {utc_ahora.timestamp():.0f}  ← siempre único, sin ambigüedad")


print("\n" + "=" * 60)
print("✅ Zonas horarias y pytz dominados")
print("=" * 60)
