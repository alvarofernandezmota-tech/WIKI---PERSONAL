"""Tema 3.1: Datos Temporales - datetime, date y time

Este archivo demuestra el uso fundamental del módulo datetime
para trabajar con fechas y horas en Python.
"""

from datetime import datetime, date, time


# =============================================================================
# EJEMPLO 1: Clase date - Solo fechas
# =============================================================================

print("=" * 60)
print("EJEMPLO 1: Clase date")
print("=" * 60)

# Fecha de hoy
hoy = date.today()
print(f"\nFecha de hoy:     {hoy}")
print(f"Tipo:             {type(hoy)}")
print(f"Año:              {hoy.year}")
print(f"Mes:              {hoy.month}")
print(f"Día:              {hoy.day}")

# Crear fecha específica
nacimiento = date(1990, 5, 15)
print(f"\nFecha nacimiento: {nacimiento}")
print(f"Día de la semana: {nacimiento.weekday()}  (0=lunes, 6=domingo)")
print(f"Día del año:      {nacimiento.timetuple().tm_yday}")

# Formatear fechas
print(f"\nFormatos:")
print(f"  ISO:            {hoy.isoformat()}")
print(f"  strftime:       {hoy.strftime('%d/%m/%Y')}")
print(f"  Largo:          {hoy.strftime('%A, %d de %B de %Y')}")


# =============================================================================
# EJEMPLO 2: Clase time - Solo horas
# =============================================================================

print("\n" + "=" * 60)
print("EJEMPLO 2: Clase time")
print("=" * 60)

# Crear hora específica
hora = time(14, 30, 45)
print(f"\nHora creada:  {hora}")
print(f"Tipo:         {type(hora)}")
print(f"Hora:         {hora.hour}")
print(f"Minutos:      {hora.minute}")
print(f"Segundos:     {hora.second}")

# Formatear horas
print(f"\nFormatos:")
print(f"  ISO:          {hora.isoformat()}")
print(f"  strftime:     {hora.strftime('%H:%M:%S')}")
print(f"  12h:          {hora.strftime('%I:%M %p')}")


# =============================================================================
# EJEMPLO 3: Clase datetime - Fecha Y hora combinadas
# =============================================================================

print("\n" + "=" * 60)
print("EJEMPLO 3: Clase datetime")
print("=" * 60)

# Ahora mismo
ahora = datetime.now()
print(f"\nAhora mismo:  {ahora}")
print(f"Tipo:         {type(ahora)}")
print(f"Fecha:        {ahora.date()}")
print(f"Hora:         {ahora.time()}")
print(f"Año:          {ahora.year}")
print(f"Mes:          {ahora.month}")
print(f"Día:          {ahora.day}")
print(f"Hora:         {ahora.hour}")
print(f"Minuto:       {ahora.minute}")
print(f"Segundo:      {ahora.second}")

# Crear datetime específico
evento = datetime(2026, 12, 31, 23, 59, 59)
print(f"\nEvento:       {evento}")

# Formatear datetime
print(f"\nFormatos:")
print(f"  ISO:          {ahora.isoformat()}")
print(f"  strftime:     {ahora.strftime('%d/%m/%Y %H:%M:%S')}")
print(f"  Largo:        {ahora.strftime('%A %d de %B de %Y a las %H:%M')}")


# =============================================================================
# EJEMPLO 4: Parsing - Convertir string a datetime
# =============================================================================

print("\n" + "=" * 60)
print("EJEMPLO 4: Parsing con strptime")
print("=" * 60)

fecha_str = "25/12/2026 09:00:00"
fecha_dt = datetime.strptime(fecha_str, "%d/%m/%Y %H:%M:%S")
print(f"\nString original: '{fecha_str}'")
print(f"Convertido a:    {fecha_dt}")
print(f"Tipo:            {type(fecha_dt)}")
print(f"Solo la fecha:   {fecha_dt.date()}")
print(f"Solo la hora:    {fecha_dt.time()}")

fecha_str2 = "2026-03-11"
fecha_dt2 = datetime.strptime(fecha_str2, "%Y-%m-%d")
print(f"\nString:  '{fecha_str2}' → {fecha_dt2.date()}")


print("\n" + "=" * 60)
print("✅ datetime, date y time dominados")
print("=" * 60)
