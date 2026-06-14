"""Tema 3: Ejemplos Prácticos - Datos Temporales con POO

Ejemplos que combinan datos temporales con Programación
Orientada a Objetos: clases que usan datetime de forma real.
"""

from datetime import datetime, date, timedelta
import pytz


# =============================================================================
# EJEMPLO 1: Clase Persona con fecha de nacimiento
# =============================================================================

print("=" * 60)
print("EJEMPLO 1: Persona con fecha nacimiento")
print("=" * 60)


class Persona:
    """Persona con fecha de nacimiento y cálculo de edad."""

    def __init__(self, nombre: str, fecha_nacimiento: date):
        self.nombre = nombre
        self.fecha_nacimiento = fecha_nacimiento

    @property
    def edad(self) -> int:
        hoy = date.today()
        años = hoy.year - self.fecha_nacimiento.year
        if (hoy.month, hoy.day) < (self.fecha_nacimiento.month, self.fecha_nacimiento.day):
            años -= 1
        return años

    @property
    def proximo_cumple(self) -> date:
        hoy = date.today()
        cumple = date(hoy.year, self.fecha_nacimiento.month, self.fecha_nacimiento.day)
        if cumple < hoy:
            cumple = date(hoy.year + 1, self.fecha_nacimiento.month, self.fecha_nacimiento.day)
        return cumple

    @property
    def dias_para_cumple(self) -> int:
        return (self.proximo_cumple - date.today()).days

    def __str__(self):
        return (f"{self.nombre} | Nacido: {self.fecha_nacimiento.strftime('%d/%m/%Y')} | "
                f"Edad: {self.edad} años | Próximo cumple en {self.dias_para_cumple} días")


persona = Persona("Álvaro", date(1995, 7, 20))
print(f"\n{persona}")


# =============================================================================
# EJEMPLO 2: Clase Evento con zona horaria
# =============================================================================

print("\n" + "=" * 60)
print("EJEMPLO 2: Evento con zona horaria")
print("=" * 60)


class Evento:
    """Evento con fecha/hora y zona horaria."""

    def __init__(self, nombre: str, dt_utc: datetime, duracion_min: int = 60):
        self.nombre = nombre
        self.dt_utc = dt_utc.replace(tzinfo=pytz.utc) if dt_utc.tzinfo is None else dt_utc
        self.duracion = timedelta(minutes=duracion_min)

    @property
    def fin(self) -> datetime:
        return self.dt_utc + self.duracion

    def hora_en(self, zona: str) -> str:
        tz = pytz.timezone(zona)
        dt_local = self.dt_utc.astimezone(tz)
        return dt_local.strftime('%d/%m/%Y %H:%M %Z')

    def ya_paso(self) -> bool:
        return self.dt_utc < datetime.now(pytz.utc)

    def __str__(self):
        return (f"📅 {self.nombre} | "
                f"UTC: {self.dt_utc.strftime('%H:%M')} | "
                f"Duración: {int(self.duracion.total_seconds()//60)} min | "
                f"Pasado: {'✅' if self.ya_paso() else '⏳'}")


evento = Evento("Clase Python M4", datetime(2026, 3, 11, 9, 0, 0), duracion_min=90)
print(f"\n{evento}")
print(f"  Madrid:    {evento.hora_en('Europe/Madrid')}")
print(f"  NY:        {evento.hora_en('America/New_York')}")
print(f"  Tokio:     {evento.hora_en('Asia/Tokyo')}")


# =============================================================================
# EJEMPLO 3: Registro de actividad con timestamps
# =============================================================================

print("\n" + "=" * 60)
print("EJEMPLO 3: Registro de actividad")
print("=" * 60)


class RegistroActividad:
    """Registra actividades con timestamp automático."""

    def __init__(self, usuario: str):
        self.usuario = usuario
        self.actividades = []
        self.creado_en = datetime.now(pytz.utc)

    def registrar(self, accion: str) -> None:
        self.actividades.append({
            "accion": accion,
            "timestamp": datetime.now(pytz.utc)
        })

    def resumen(self) -> None:
        print(f"\n👤 Usuario: {self.usuario}")
        print(f"   Registro creado: {self.creado_en.strftime('%H:%M:%S UTC')}")
        print(f"   Actividades ({len(self.actividades)}):")
        for act in self.actividades:
            ts = act['timestamp'].strftime('%H:%M:%S')
            print(f"     [{ts}] {act['accion']}")


registro = RegistroActividad("alvaro")
registro.registrar("Login")
registro.registrar("Abrió ejercicios_tema3.py")
registro.registrar("Ejecutó ejercicio 1")
registro.registrar("Completó todos los ejercicios")
registro.resumen()


print("\n" + "=" * 60)
print("✅ Datos temporales + POO en la práctica")
print("=" * 60)
