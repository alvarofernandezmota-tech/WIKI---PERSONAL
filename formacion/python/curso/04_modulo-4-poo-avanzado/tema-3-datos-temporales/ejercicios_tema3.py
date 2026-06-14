"""Ejercicios Prácticos - Tema 3: Datos Temporales

Ejercicios progresivos para consolidar los conceptos de:
- Módulo datetime: date, time, datetime
- timedelta: operaciones aritméticas con fechas
- Formateo y parsing de fechas (strftime / strptime)
- Zonas horarias con pytz
- Datos temporales aplicados a POO
"""

from datetime import datetime, date, time, timedelta
import pytz

print("📚 MÓDULO 4 - TEMA 3: DATOS TEMPORALES - EJERCICIOS")
print("=" * 70)
print()


# =============================================================================
# EJERCICIO 1: Fecha de hoy
# =============================================================================

print("=" * 70)
print("📝 EJERCICIO 1: Fecha de hoy")
print("=" * 70)

# Obtener y mostrar la fecha de hoy
hoy = date.today()
print(f"\n📅 La fecha de hoy es: {hoy}")
print(f"   Año:  {hoy.year}")
print(f"   Mes:  {hoy.month}")
print(f"   Día:  {hoy.day}")
print(f"   Formato español: {hoy.strftime('%d/%m/%Y')}")
print(f"   Día de la semana: {hoy.strftime('%A')}")

print("\n" + "=" * 70)
print("✅ EJERCICIO 1 COMPLETADO")
print("=" * 70)


# =============================================================================
# EJERCICIO 2: Zona horaria Nueva York con pytz
# =============================================================================

print("\n\n" + "=" * 70)
print("📝 EJERCICIO 2: Zona horaria Nueva York")
print("=" * 70)

import pytz
from datetime import datetime, timedelta

dt_aware = datetime.now(pytz.timezone("America/New_York"))
print(f"\n🗽 Aware datetime (Nueva York): {dt_aware}")
print(f"   Zona horaria: {dt_aware.tzinfo}")
print(f"   Formato legible: {dt_aware.strftime('%d/%m/%Y %H:%M:%S %Z')}")

# Comparar con Madrid
dt_madrid = datetime.now(pytz.timezone("Europe/Madrid"))
print(f"\n🇪🇸 Madrid:     {dt_madrid.strftime('%H:%M:%S %Z')}")
print(f"🗽 Nueva York:  {dt_aware.strftime('%H:%M:%S %Z')}")
dif_horas = (dt_madrid.utcoffset() - dt_aware.utcoffset()).total_seconds() / 3600
print(f"⏱️  Diferencia:  {dif_horas:.0f} horas")

print("\n" + "=" * 70)
print("✅ EJERCICIO 2 COMPLETADO")
print("=" * 70)


# =============================================================================
# EJERCICIO 3: Operaciones con timedelta
# =============================================================================

print("\n\n" + "=" * 70)
print("📝 EJERCICIO 3: Operaciones con timedelta")
print("=" * 70)

hoy = date.today()

# Calcular fechas pasadas y futuras
print(f"\n📅 Hoy:             {hoy}")
print(f"   Ayer:           {hoy - timedelta(days=1)}")
print(f"   Mañana:         {hoy + timedelta(days=1)}")
print(f"   Hace 1 semana:  {hoy - timedelta(weeks=1)}")
print(f"   En 30 días:     {hoy + timedelta(days=30)}")
print(f"   En 1 año:       {hoy + timedelta(days=365)}")

# Diferencia entre dos fechas
fecha_inicio = date(2026, 1, 1)
fecha_hoy = date.today()
dias_pasados = (fecha_hoy - fecha_inicio).days
print(f"\n📊 Desde el 1 enero 2026:")
print(f"   Han pasado:     {dias_pasados} días")
print(f"   En semanas:     {dias_pasados // 7} semanas y {dias_pasados % 7} días")

# Operaciones con datetime (incluye horas)
entrada = datetime(2026, 3, 11, 8, 30, 0)
salida  = datetime(2026, 3, 11, 17, 0, 0)
jornada = salida - entrada
print(f"\n⏱️  Jornada laboral:")
print(f"   Entrada:        {entrada.strftime('%H:%M')}")
print(f"   Salida:         {salida.strftime('%H:%M')}")
print(f"   Horas:          {jornada.total_seconds()/3600:.1f}h")

print("\n" + "=" * 70)
print("✅ EJERCICIO 3 COMPLETADO")
print("=" * 70)


# =============================================================================
# EJERCICIO 4: Formateo y Parsing de fechas
# =============================================================================

print("\n\n" + "=" * 70)
print("📝 EJERCICIO 4: Formateo y Parsing (strftime / strptime)")
print("=" * 70)

ahora = datetime.now()

# strftime: datetime → string
print("\n🔄 strftime (datetime → string):")
print(f"   ISO 8601:       {ahora.strftime('%Y-%m-%d')}")
print(f"   Español:        {ahora.strftime('%d/%m/%Y')}")
print(f"   Con hora:       {ahora.strftime('%d/%m/%Y %H:%M:%S')}")
print(f"   Hora 12h:       {ahora.strftime('%I:%M %p')}")
print(f"   Largo:          {ahora.strftime('%A, %d de %B de %Y')}")
print(f"   Solo tiempo:    {ahora.strftime('%H:%M:%S')}")

# strptime: string → datetime
print("\n🔄 strptime (string → datetime):")
fechas_strings = [
    ("25/12/2026",          "%d/%m/%Y"),
    ("2026-06-15 14:30:00", "%Y-%m-%d %H:%M:%S"),
    ("11 Mar 2026",         "%d %b %Y"),
]

for fecha_str, formato in fechas_strings:
    dt = datetime.strptime(fecha_str, formato)
    print(f"   '{fecha_str}' → {dt}")

print("\n" + "=" * 70)
print("✅ EJERCICIO 4 COMPLETADO")
print("=" * 70)


# =============================================================================
# EJERCICIO 5: Calculadora de edad
# =============================================================================

print("\n\n" + "=" * 70)
print("📝 EJERCICIO 5: Calculadora de edad")
print("=" * 70)


def calcular_edad(fecha_nacimiento: date) -> dict:
    """Calcula edad completa con años, meses y días."""
    hoy = date.today()
    años = hoy.year - fecha_nacimiento.year
    if (hoy.month, hoy.day) < (fecha_nacimiento.month, fecha_nacimiento.day):
        años -= 1

    # Próximo cumpleaños
    try:
        proximo = date(hoy.year, fecha_nacimiento.month, fecha_nacimiento.day)
    except ValueError:
        proximo = date(hoy.year, fecha_nacimiento.month + 1, 1)
    if proximo <= hoy:
        try:
            proximo = date(hoy.year + 1, fecha_nacimiento.month, fecha_nacimiento.day)
        except ValueError:
            proximo = date(hoy.year + 1, fecha_nacimiento.month + 1, 1)

    dias_cumple = (proximo - hoy).days
    dias_vividos = (hoy - fecha_nacimiento).days

    return {
        "años": años,
        "dias_vividos": dias_vividos,
        "dias_cumple": dias_cumple,
        "proximo_cumple": proximo
    }


fechas_prueba = [
    date(1995, 7, 20),
    date(2000, 1, 1),
    date(1990, 12, 25),
]

for nacimiento in fechas_prueba:
    datos = calcular_edad(nacimiento)
    print(f"\n👤 Nacido el {nacimiento.strftime('%d/%m/%Y')}:")
    print(f"   Edad:           {datos['años']} años")
    print(f"   Días vividos:   {datos['dias_vividos']:,}")
    print(f"   Próximo cumple: {datos['proximo_cumple'].strftime('%d/%m/%Y')} (en {datos['dias_cumple']} días)")

print("\n" + "=" * 70)
print("✅ EJERCICIO 5 COMPLETADO")
print("=" * 70)


# =============================================================================
# EJERCICIO 6: Convertidor de zonas horarias
# =============================================================================

print("\n\n" + "=" * 70)
print("📝 EJERCICIO 6: Convertidor de zonas horarias")
print("=" * 70)


class ConvertidorHorario:
    """Convierte un datetime entre múltiples zonas horarias."""

    ZONAS = {
        "Madrid":     "Europe/Madrid",
        "Londres":    "Europe/London",
        "Nueva York": "America/New_York",
        "Los Ángeles":"America/Los_Angeles",
        "São Paulo":  "America/Sao_Paulo",
        "Dubai":      "Asia/Dubai",
        "Tokio":      "Asia/Tokyo",
        "Sídney":     "Australia/Sydney",
    }

    def __init__(self, dt_utc: datetime = None):
        self.dt_utc = dt_utc or datetime.now(pytz.utc)
        if self.dt_utc.tzinfo is None:
            self.dt_utc = pytz.utc.localize(self.dt_utc)

    def en_zona(self, ciudad: str) -> str:
        if ciudad not in self.ZONAS:
            return f"❌ Ciudad '{ciudad}' no encontrada"
        tz = pytz.timezone(self.ZONAS[ciudad])
        dt_local = self.dt_utc.astimezone(tz)
        return dt_local.strftime('%d/%m/%Y %H:%M %Z')

    def mostrar_todas(self) -> None:
        print(f"\n🌍 {self.dt_utc.strftime('%d/%m/%Y %H:%M UTC')} en el mundo:")
        for ciudad in self.ZONAS:
            print(f"   {ciudad:<15} {self.en_zona(ciudad)}")


convertidor = ConvertidorHorario()
convertidor.mostrar_todas()

print("\n" + "=" * 70)
print("✅ EJERCICIO 6 COMPLETADO")
print("=" * 70)


# =============================================================================
# EJERCICIO 7: Agenda de eventos
# =============================================================================

print("\n\n" + "=" * 70)
print("📝 EJERCICIO 7: Agenda de eventos")
print("=" * 70)


class EventoAgenda:
    """Evento con fecha, duración y recordatorios."""

    def __init__(self, titulo: str, fecha_hora: datetime, duracion_min: int, zona: str = "Europe/Madrid"):
        self.titulo = titulo
        tz = pytz.timezone(zona)
        self.fecha_hora = tz.localize(fecha_hora) if fecha_hora.tzinfo is None else fecha_hora
        self.duracion = timedelta(minutes=duracion_min)
        self.zona = zona

    @property
    def fin(self) -> datetime:
        return self.fecha_hora + self.duracion

    @property
    def ya_paso(self) -> bool:
        return self.fecha_hora < datetime.now(pytz.timezone(self.zona))

    @property
    def tiempo_restante(self) -> str:
        ahora = datetime.now(pytz.timezone(self.zona))
        if self.ya_paso:
            return "Ya pasó"
        delta = self.fecha_hora - ahora
        dias = delta.days
        horas = delta.seconds // 3600
        minutos = (delta.seconds % 3600) // 60
        if dias > 0:
            return f"en {dias}d {horas}h {minutos}m"
        elif horas > 0:
            return f"en {horas}h {minutos}m"
        else:
            return f"en {minutos} min"

    def __str__(self):
        estado = "✅ Pasado" if self.ya_paso else f"⏳ {self.tiempo_restante}"
        return (f"📅 {self.titulo}\n"
                f"   Inicio: {self.fecha_hora.strftime('%d/%m/%Y %H:%M %Z')}\n"
                f"   Fin:    {self.fin.strftime('%H:%M %Z')}\n"
                f"   Estado: {estado}")


class Agenda:
    """Gestiona una colección de eventos."""

    def __init__(self, nombre: str):
        self.nombre = nombre
        self.eventos: list[EventoAgenda] = []

    def agregar(self, evento: EventoAgenda) -> None:
        self.eventos.append(evento)
        self.eventos.sort(key=lambda e: e.fecha_hora)

    def proximos(self, n: int = 3) -> list:
        futuros = [e for e in self.eventos if not e.ya_paso]
        return futuros[:n]

    def mostrar(self) -> None:
        print(f"\n📓 Agenda: {self.nombre} ({len(self.eventos)} eventos)")
        for evento in self.eventos:
            print(f"\n{evento}")


agenda = Agenda("Escuela Musk")
agenda.agregar(EventoAgenda("Clase Tema 3",      datetime(2026, 3, 11, 9, 0),  90))
agenda.agregar(EventoAgenda("Entrega Proyecto",  datetime(2026, 3, 20, 23, 59), 0))
agenda.agregar(EventoAgenda("Examen Final M4",   datetime(2026, 4, 1, 10, 0), 120))
agenda.agregar(EventoAgenda("Clase Tema 1",      datetime(2026, 3, 8, 9, 0),  90))

agenda.mostrar()

print(f"\n🔜 Próximos {len(agenda.proximos())} eventos:")
for e in agenda.proximos():
    print(f"  → {e.titulo} ({e.tiempo_restante})")

print("\n" + "=" * 70)
print("✅ EJERCICIO 7 COMPLETADO")
print("=" * 70)


# =============================================================================
# EJERCICIO 8: Sistema de fichajes
# =============================================================================

print("\n\n" + "=" * 70)
print("📝 EJERCICIO 8: Sistema de fichajes")
print("=" * 70)


class Fichaje:
    """Registro de entrada/salida de un trabajador."""

    def __init__(self, empleado: str):
        self.empleado = empleado
        self.entrada: datetime = datetime.now(pytz.timezone("Europe/Madrid"))
        self.salida: datetime = None

    def registrar_salida(self) -> None:
        self.salida = datetime.now(pytz.timezone("Europe/Madrid"))

    @property
    def horas_trabajadas(self) -> float:
        if not self.salida:
            return 0.0
        delta = self.salida - self.entrada
        return round(delta.total_seconds() / 3600, 2)

    @property
    def es_jornada_completa(self) -> bool:
        return self.horas_trabajadas >= 8.0

    def __str__(self):
        salida_str = self.salida.strftime('%H:%M:%S') if self.salida else "Sin registrar"
        return (f"👤 {self.empleado}\n"
                f"   Entrada: {self.entrada.strftime('%d/%m/%Y %H:%M:%S')}\n"
                f"   Salida:  {salida_str}\n"
                f"   Horas:   {self.horas_trabajadas}h\n"
                f"   Jornada completa: {'✅' if self.es_jornada_completa else '❌'}")


class SistemaFichajes:
    """Gestiona fichajes de múltiples empleados."""

    def __init__(self):
        self.fichajes: list[Fichaje] = []

    def fichar_entrada(self, empleado: str) -> Fichaje:
        f = Fichaje(empleado)
        self.fichajes.append(f)
        print(f"  🟢 {empleado} fichó entrada: {f.entrada.strftime('%H:%M:%S')}")
        return f

    def total_horas_dia(self) -> float:
        return sum(f.horas_trabajadas for f in self.fichajes)

    def resumen(self) -> None:
        print(f"\n📊 Resumen de fichajes ({len(self.fichajes)} empleados):")
        for f in self.fichajes:
            print(f"\n{f}")
        print(f"\n⏱️  Total horas equipo: {self.total_horas_dia():.2f}h")


# Simulación de fichajes con timestamps fijos para demo reproducible
print("\n🏢 Sistema de fichajes - Simulación:")
print("-" * 70)

tz_madrid = pytz.timezone("Europe/Madrid")

f1 = Fichaje.__new__(Fichaje)
f1.empleado = "Álvaro"
f1.entrada = tz_madrid.localize(datetime(2026, 3, 11, 8, 30, 0))
f1.salida  = tz_madrid.localize(datetime(2026, 3, 11, 17, 0, 0))

f2 = Fichaje.__new__(Fichaje)
f2.empleado = "María"
f2.entrada = tz_madrid.localize(datetime(2026, 3, 11, 9, 0, 0))
f2.salida  = tz_madrid.localize(datetime(2026, 3, 11, 15, 30, 0))

f3 = Fichaje.__new__(Fichaje)
f3.empleado = "Carlos"
f3.entrada = tz_madrid.localize(datetime(2026, 3, 11, 7, 0, 0))
f3.salida  = tz_madrid.localize(datetime(2026, 3, 11, 16, 0, 0))

sistema = SistemaFichajes()
sistema.fichajes = [f1, f2, f3]
sistema.resumen()

print("\n" + "=" * 70)
print("✅ EJERCICIO 8 COMPLETADO")
print("=" * 70)


# =============================================================================
# RESUMEN FINAL - TEMA 3 COMPLETADO
# =============================================================================

print("\n\n" + "=" * 70)
print("🎉 TEMA 3 DATOS TEMPORALES - 8/8 EJERCICIOS COMPLETADOS")
print("=" * 70)
print()
print("📚 Todos los conceptos dominados:")
print("   ✅ EJ1 - date.today() y atributos")
print("   ✅ EJ2 - pytz y aware datetime")
print("   ✅ EJ3 - timedelta: sumas, restas y diferencias")
print("   ✅ EJ4 - strftime / strptime: formateo y parsing")
print("   ✅ EJ5 - Calculadora de edad con POO")
print("   ✅ EJ6 - Convertidor de zonas horarias")
print("   ✅ EJ7 - Agenda de eventos con datetime")
print("   ✅ EJ8 - Sistema de fichajes")
print()
print("🚀 Próximo: Tema 4 - Generadores y Cierres")
print("=" * 70)
