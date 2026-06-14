"""Ejercicios Prácticos - Tema 2: ABC e Interfaces

Ejercicios progresivos para consolidar los conceptos de:
- Abstract Base Class (ABC)
- Interfaces formales e informales
- Métodos abstractos con @abstractmethod
- Polimorfismo con interfaces
"""

from abc import ABC, ABCMeta, abstractmethod

print("📚 MÓDULO 4 - TEMA 2: EJERCICIOS PRÁCTICOS")
print("=" * 70)
print()


# =============================================================================
# EJERCICIO 1: Interfaz Básica - Sistema de Voladores
# =============================================================================

print("=" * 70)
print("📝 EJERCICIO 1: Interfaz Volador")
print("=" * 70)


# INTERFAZ
class Volador(ABC):
    """Interfaz para objetos que pueden volar"""
    
    @abstractmethod
    def despegar(self):
        """Método para despegar"""
        pass

    @abstractmethod
    def volar(self):
        """Método para volar"""
        pass

    @abstractmethod
    def aterrizar(self):
        """Método para aterrizar"""
        pass
    
    def mostrar_estado(self):
        """Método concreto que todos heredan"""
        return "✅ En vuelo"


# IMPLEMENTACIONES
class Avion(Volador):
    """Avión comercial"""
    
    def __init__(self, modelo: str, num_pasajeros: int):
        self.modelo = modelo
        self.num_pasajeros = num_pasajeros
    
    def despegar(self):
        return f"🛫 {self.modelo} acelerando en pista... Despegando con {self.num_pasajeros} pasajeros"
    
    def volar(self):
        return f"✈️ {self.modelo} volando a 10,000 metros de altitud"
    
    def aterrizar(self):
        return f"🛬 {self.modelo} descendiendo suavemente hacia la pista"


class Pajaro(Volador):
    """Pájaro salvaje"""
    
    def __init__(self, especie: str, tamaño_alas: float):
        self.especie = especie
        self.tamaño_alas = tamaño_alas
    
    def despegar(self):
        return f"🦅 {self.especie} batiendo alas de {self.tamaño_alas}m... ¡Despegue!"
    
    def volar(self):
        return f"🦅 {self.especie} planeando con el viento"
    
    def aterrizar(self):
        return f"🦅 {self.especie} posándose suavemente en una rama"


class Helicoptero(Volador):
    """Helicóptero militar o civil"""
    
    def __init__(self, modelo: str, num_helices: int):
        self.modelo = modelo
        self.num_helices = num_helices
    
    def despegar(self):
        return f"🚁 {self.modelo} elevándose verticalmente con {self.num_helices} hélices..."
    
    def volar(self):
        return f"🚁 {self.modelo} volando a baja altitud (500m)"
    
    def aterrizar(self):
        return f"🚁 {self.modelo} descendiendo verticalmente... Aterrizaje seguro"


# PRUEBAS EJERCICIO 1
print("\n🔸 PRUEBA 1: Intentar instanciar Volador (debe fallar)")
print("-" * 70)
try:
    volador = Volador()
    print("❌ ERROR: ¡No debería poder instanciar Volador!")
except TypeError as e:
    print(f"✅ Correcto: No se puede instanciar clase abstracta")
    print(f"   Error: {e}")


print("\n🔸 PRUEBA 2: Crear instancias de las clases")
print("-" * 70)
avion = Avion("Boeing 747", 400)
pajaro = Pajaro("Águila Real", 2.5)
helicoptero = Helicoptero("Apache AH-64", 4)

print(f"✅ Avión creado: {avion.modelo} ({avion.num_pasajeros} pasajeros)")
print(f"✅ Pájaro creado: {pajaro.especie} (alas de {pajaro.tamaño_alas}m)")
print(f"✅ Helicóptero creado: {helicoptero.modelo} ({helicoptero.num_helices} hélices)")


print("\n🔸 PRUEBA 3: Probar métodos individuales")
print("-" * 70)

print("\n✈️ AVIÓN:")
print(avion.despegar())
print(avion.volar())
print(avion.aterrizar())

print("\n🦅 PÁJARO:")
print(pajaro.despegar())
print(pajaro.volar())
print(pajaro.aterrizar())

print("\n🚁 HELICÓPTERO:")
print(helicoptero.despegar())
print(helicoptero.volar())
print(helicoptero.aterrizar())


print("\n🔸 PRUEBA 4: Polimorfismo con función")
print("-" * 70)

def hacer_volar(volador: Volador):
    """Función que recibe cualquier Volador y ejecuta secuencia completa"""
    print(f"\n🔹 Iniciando vuelo de: {volador.__class__.__name__}")
    print(volador.despegar())
    print(volador.volar())
    print(volador.aterrizar())
    print(f"✅ {volador.__class__.__name__} completó el vuelo")

hacer_volar(avion)
hacer_volar(pajaro)
hacer_volar(helicoptero)


print("\n🔸 PRUEBA 5: Polimorfismo con lista")
print("-" * 70)

voladores = [
    Avion("Airbus A380", 850),
    Pajaro("Halcón Peregrino", 1.2),
    Helicoptero("Bell 407", 2),
    Pajaro("Cóndor", 3.0)
]

print(f"\n🚀 Haciendo volar {len(voladores)} objetos diferentes:\n")

for i, vol in enumerate(voladores, 1):
    print(f"--- Vuelo #{i}: {vol.__class__.__name__} ---")
    print(vol.despegar())
    print(vol.volar())
    print(vol.aterrizar())
    print()


print("\n" + "=" * 70)
print("✅ EJERCICIO 1 COMPLETADO")
print("=" * 70)


# =============================================================================
# EJERCICIO 2: Interfaces Múltiples - Dispositivo Multimedia
# =============================================================================

print("\n\n" + "=" * 70)
print("📝 EJERCICIO 2: Interfaces Múltiples")
print("=" * 70)


# INTERFACES
class Reproducible(ABC):
    """Interfaz para dispositivos que pueden reproducir contenido"""
    
    @abstractmethod
    def reproducir(self, archivo: str):
        """Reproduce un archivo de audio/video"""
        pass
    
    @abstractmethod
    def pausar(self):
        """Pausa la reproducción actual"""
        pass
    
    @abstractmethod
    def detener(self):
        """Detiene completamente la reproducción"""
        pass


class Grabable(ABC):
    """Interfaz para dispositivos que pueden grabar"""
    
    @abstractmethod
    def iniciar_grabacion(self):
        """Inicia el proceso de grabación"""
        pass
    
    @abstractmethod
    def detener_grabacion(self):
        """Detiene la grabación en curso"""
        pass
    
    @abstractmethod
    def guardar(self, nombre_archivo: str):
        """Guarda la grabación con un nombre específico"""
        pass


# IMPLEMENTACIONES - HERENCIA SIMPLE
class ReproductorMP3(Reproducible):
    """Reproductor de música MP3 - SOLO reproduce"""
    
    def __init__(self):
        self.canciones_guardadas = ["song1.mp3", "song2.mp3", "song3.mp3"]
        self.reproduciendo = False
        self.cancion_actual = None
    
    def reproducir(self, archivo: str):
        self.reproduciendo = True
        self.cancion_actual = archivo
        return f"🎵 ReproductorMP3: Reproduciendo '{archivo}'"
    
    def pausar(self):
        return f"⏸️ ReproductorMP3: Música pausada ('{self.cancion_actual}')"
    
    def detener(self):
        cancion = self.cancion_actual
        self.reproduciendo = False
        self.cancion_actual = None
        return f"⏹️ ReproductorMP3: Reproducción detenida (era '{cancion}')"


class Grabadora(Grabable):
    """Grabadora de voz/audio - SOLO graba"""
    
    def __init__(self):
        self.grabaciones = []
        self.grabando = False
    
    def iniciar_grabacion(self):
        self.grabando = True
        return "🔴 Grabadora: Grabando..."
    
    def detener_grabacion(self):
        self.grabando = False
        return "⏹️ Grabadora: Grabación detenida"
    
    def guardar(self, nombre_archivo: str):
        archivo_completo = f"{nombre_archivo}.wav"
        self.grabaciones.append(archivo_completo)
        return f"💾 Grabadora: Guardado como '{archivo_completo}'"


# IMPLEMENTACIÓN - HERENCIA MÚLTIPLE
class Smartphone(Reproducible, Grabable):
    """Smartphone - reproduce Y graba"""
    
    def __init__(self, marca: str, modelo: str, almacenamiento: int):
        self.marca = marca
        self.modelo = modelo
        self.almacenamiento = almacenamiento
        self.canciones = ["song1.mp3"]
        self.grabaciones = []
    
    # Métodos de Reproducible
    def reproducir(self, archivo: str):
        return f"📱 {self.marca} {self.modelo}: Reproduciendo '{archivo}'"
    
    def pausar(self):
        return f"⏸️ {self.marca} {self.modelo}: Pausado"
    
    def detener(self):
        return f"⏹️ {self.marca} {self.modelo}: Detenido"
    
    # Métodos de Grabable
    def iniciar_grabacion(self):
        return f"🔴 {self.marca} {self.modelo}: Grabando..."
    
    def detener_grabacion(self):
        return f"⏹️ {self.marca} {self.modelo}: Grabación detenida"
    
    def guardar(self, nombre_archivo: str):
        self.grabaciones.append(nombre_archivo)
        return f"💾 {self.marca} {self.modelo}: Guardado '{nombre_archivo}'"
    
    def mostrar_funciones(self):
        return f"📱 {self.marca} {self.modelo} - Reproduce: ✅ Graba: ✅"


# PRUEBAS EJERCICIO 2
print("\n🔸 PRUEBA 1: Crear instancias")
print("-" * 70)

mp3 = ReproductorMP3()
grabadora = Grabadora()
smartphone = Smartphone("Samsung", "Galaxy S24", 256)

print("✅ ReproductorMP3 creado")
print("✅ Grabadora creada")
print(f"✅ Smartphone creado: {smartphone.marca} {smartphone.modelo}")


print("\n🔸 PRUEBA 2: Verificar capacidades")
print("-" * 70)

print(f"¿MP3 es Reproducible? {isinstance(mp3, Reproducible)}")
print(f"¿MP3 es Grabable? {isinstance(mp3, Grabable)}")
print(f"¿Grabadora es Reproducible? {isinstance(grabadora, Reproducible)}")
print(f"¿Grabadora es Grabable? {isinstance(grabadora, Grabable)}")
print(f"¿Smartphone es Reproducible? {isinstance(smartphone, Reproducible)}")
print(f"¿Smartphone es Grabable? {isinstance(smartphone, Grabable)}")


print("\n🔸 PRUEBA 3: Polimorfismo con listas")
print("-" * 70)

reproducibles = [mp3, smartphone]
grabables = [grabadora, smartphone]

print("\n🎵 Reproducibles:")
for disp in reproducibles:
    print(f"  {disp.__class__.__name__}: {disp.reproducir('test.mp3')}")

print("\n🔴 Grabables:")
for disp in grabables:
    print(f"  {disp.__class__.__name__}: {disp.iniciar_grabacion()}")


print("\n" + "=" * 70)
print("✅ EJERCICIO 2 COMPLETADO")
print("=" * 70)


# =============================================================================
# EJERCICIO 3: Sistema de Notificaciones
# =============================================================================

print("\n\n" + "=" * 70)
print("📝 EJERCICIO 3: Sistema de Notificaciones")
print("=" * 70)


# INTERFAZ
class Notificacion(ABC):
    """Interfaz para sistemas de notificación"""
    
    def __init__(self):
        self.entregado = False
        self.mensaje_enviado = None
        self.destinatario_actual = None
    
    @abstractmethod
    def enviar(self, mensaje: str, destinatario: str):
        """Envía una notificación"""
        pass
    
    @abstractmethod
    def verificar_entrega(self):
        """Verifica si fue entregada"""
        pass
    
    def obtener_estado(self):
        """Método concreto: obtiene estado"""
        estado = "✅ Entregado" if self.entregado else "⏳ Pendiente"
        return f"{self.__class__.__name__}: {estado}"


# IMPLEMENTACIONES
class Email(Notificacion):
    def enviar(self, mensaje: str, destinatario: str):
        self.mensaje_enviado = mensaje
        self.destinatario_actual = destinatario
        self.entregado = True
        return f"📧 Email enviado a {destinatario}: {mensaje}"
    
    def verificar_entrega(self):
        return f"✅ Email entregado a {self.destinatario_actual}"


class SMS(Notificacion):
    def enviar(self, mensaje: str, destinatario: str):
        self.mensaje_enviado = mensaje
        self.destinatario_actual = destinatario
        self.entregado = True
        return f"📱 SMS enviado a {destinatario}: {mensaje}"
    
    def verificar_entrega(self):
        return f"✅ SMS entregado a {self.destinatario_actual}"


class PushNotification(Notificacion):
    def enviar(self, mensaje: str, destinatario: str):
        self.mensaje_enviado = mensaje
        self.destinatario_actual = destinatario
        self.entregado = True
        return f"🔔 Push enviado a {destinatario}: {mensaje}"
    
    def verificar_entrega(self):
        return f"✅ Push entregado a {self.destinatario_actual}"


class WhatsApp(Notificacion):
    def enviar(self, mensaje: str, destinatario: str):
        self.mensaje_enviado = mensaje
        self.destinatario_actual = destinatario
        self.entregado = True
        return f"💬 WhatsApp enviado a {destinatario}: {mensaje}"
    
    def verificar_entrega(self):
        return f"✅ WhatsApp entregado a {self.destinatario_actual}"


# CLASE GESTORA
class GestorNotificaciones:
    """Gestiona múltiples notificadores"""
    
    def __init__(self):
        self.notificadores = []
    
    def agregar_notificador(self, notificador: Notificacion):
        self.notificadores.append(notificador)
        return f"✅ {notificador.__class__.__name__} agregado"
    
    def enviar_a_todos(self, mensaje: str, destinatario: str):
        print(f"\n📤 Enviando a {destinatario} por {len(self.notificadores)} canales:")
        for notif in self.notificadores:
            print(f"  {notif.enviar(mensaje, destinatario)}")
    
    def verificar_todos(self):
        print("\n📊 Estado de notificaciones:")
        for notif in self.notificadores:
            print(f"  {notif.obtener_estado()}")


# PRUEBAS EJERCICIO 3
print("\n🔸 PRUEBA 1: Crear gestor y notificadores")
print("-" * 70)

gestor = GestorNotificaciones()
print(gestor.agregar_notificador(Email()))
print(gestor.agregar_notificador(SMS()))
print(gestor.agregar_notificador(PushNotification()))
print(gestor.agregar_notificador(WhatsApp()))


print("\n🔸 PRUEBA 2: Enviar a todos los canales")
print("-" * 70)

gestor.enviar_a_todos("Alerta importante del sistema", "Juan Pérez")


print("\n🔸 PRUEBA 3: Verificar estado")
print("-" * 70)

gestor.verificar_todos()


print("\n🔸 PRUEBA 4: Polimorfismo individual")
print("-" * 70)

notificadores = [Email(), SMS(), PushNotification(), WhatsApp()]

for notif in notificadores:
    print(notif.enviar("Mensaje de prueba", "test@example.com"))


print("\n" + "=" * 70)
print("✅ EJERCICIO 3 COMPLETADO")
print("=" * 70)


# =============================================================================
# EJERCICIO 4: Clases Virtuales con .register()
# =============================================================================

print("\n\n" + "=" * 70)
print("📝 EJERCICIO 4: Clases Virtuales (.register())")
print("=" * 70)


# INTERFAZ
class Nadador(ABC):
    """Interfaz para objetos que pueden nadar"""

    @abstractmethod
    def nadar(self):
        """Método para nadar"""
        pass

    @abstractmethod
    def sumergirse(self):
        """Método para sumergirse"""
        pass

    def mostrar_habilidad(self):
        """Método concreto compartido"""
        return f"🌊 {self.__class__.__name__} puede nadar"


# CLASE CON HERENCIA REAL
class Pez(Nadador):
    """Pez que hereda REALMENTE de Nadador"""

    def __init__(self, especie: str):
        self.especie = especie

    def nadar(self):
        return f"🐟 {self.especie} nada ondeando su cuerpo"

    def sumergirse(self):
        return f"🐟 {self.especie} se sumerge a 20m de profundidad"


# CLASE EXTERNA SIN HERENCIA
class Barco:
    """
    Barco que NO hereda de Nadador.
    Simula una clase de librería externa que no podemos modificar.
    Pero implementa los mismos métodos.
    """

    def __init__(self, nombre: str, eslora: float):
        self.nombre = nombre
        self.eslora = eslora

    def nadar(self):
        return f"⛵ Barco '{self.nombre}' ({self.eslora}m) navegando en superficie"

    def sumergirse(self):
        return f"⛵ Barco '{self.nombre}' no puede sumergirse (es de superficie)"

    def mostrar_habilidad(self):
        return f"⛵ {self.nombre} puede navegar"


# REGISTRAR Barco como subclase virtual de Nadador
Nadador.register(Barco)


# PRUEBAS EJERCICIO 4
print("\n🔸 PRUEBA 1: Crear instancias")
print("-" * 70)

pez = Pez("Salmón")
barco = Barco("Titanic", 269.0)

print(f"✅ Pez creado: {pez.especie} (herencia REAL de Nadador)")
print(f"✅ Barco creado: {barco.nombre} (registrado VIRTUALMENTE)")


print("\n🔸 PRUEBA 2: isinstance() con herencia real y virtual")
print("-" * 70)

print(f"¿Pez es Nadador?   {isinstance(pez, Nadador)}  ← herencia real")
print(f"¿Barco es Nadador? {isinstance(barco, Nadador)}  ← herencia virtual (.register())")


print("\n🔸 PRUEBA 3: issubclass() comparación")
print("-" * 70)

print(f"issubclass(Pez, Nadador):   {issubclass(Pez, Nadador)}")
print(f"issubclass(Barco, Nadador): {issubclass(Barco, Nadador)}")


print("\n🔸 PRUEBA 4: __mro__ - diferencia clave")
print("-" * 70)

print(f"Pez.__mro__:   {[c.__name__ for c in Pez.__mro__]}")
print(f"Barco.__mro__: {[c.__name__ for c in Barco.__mro__]}")
print("→ Nadador aparece en el MRO de Pez pero NO en el de Barco")


print("\n🔸 PRUEBA 5: Polimorfismo con lista mixta")
print("-" * 70)

nadadores = [
    Pez("Tiburón"),
    Barco("Santa María", 25.5),
    Pez("Delfín"),
    Barco("Black Pearl", 47.0),
]

print(f"\n🌊 Haciendo nadar {len(nadadores)} objetos:")
for obj in nadadores:
    print(f"  {obj.nadar()}")


print("\n🔸 PRUEBA 6: .register() NO hereda métodos")
print("-" * 70)

class SinMetodos:
    """Clase registrada pero sin implementar métodos"""
    pass

Nadador.register(SinMetodos)
sin_metodos = SinMetodos()

print(f"isinstance(sin_metodos, Nadador): {isinstance(sin_metodos, Nadador)}  ← True por .register()")
print("Pero si intentamos llamar nadar():")
try:
    sin_metodos.nadar()
except AttributeError as e:
    print(f"❌ Error: {e}")
print("→ .register() da relación lógica, NO hereda métodos")


print("\n" + "=" * 70)
print("✅ EJERCICIO 4 COMPLETADO")
print("=" * 70)
print()
print("💡 Conceptos clave:")
print("   ✅ .register() crea herencia VIRTUAL")
print("   ✅ isinstance() devuelve True con herencia virtual")
print("   ✅ issubclass() devuelve True con herencia virtual")
print("   ⚠️  .register() NO hereda métodos")
print("   ⚠️  La clase virtual NO aparece en __mro__")
print("   🎯 Uso: integrar clases externas que no puedes modificar")


# =============================================================================
# EJERCICIO 5: Duck Typing Formal vs Informal
# =============================================================================

print("\n\n" + "=" * 70)
print("📝 EJERCICIO 5: Duck Typing - Formal vs Informal")
print("=" * 70)


# -------------------------------------------------
# ENFOQUE INFORMAL (Duck Typing puro)
# -------------------------------------------------
print("\n🔸 PARTE A: Duck Typing INFORMAL (sin ABC)")
print("-" * 70)

class PerroInformal:
    """No hereda de nada — solo tiene el método hablar()"""
    def hablar(self):
        return "🐶 Guau!"

    def moverse(self):
        return "🐶 Corre"


class GatoInformal:
    """No hereda de nada — solo tiene el método hablar()"""
    def hablar(self):
        return "🐱 Miau!"

    def moverse(self):
        return "🐱 Camina sigiloso"


class PajaroInformal:
    """No implementa moverse() — solo hablar()"""
    def hablar(self):
        return "🐦 Pío!"


def hacer_hablar_informal(animal):
    """Duck typing puro: no valida, espera que tenga hablar()"""
    return animal.hablar()


perro_i = PerroInformal()
gato_i = GatoInformal()
pajaro_i = PajaroInformal()

print("Llamando hablar() en los 3 objetos (funciona):")
print(f"  {hacer_hablar_informal(perro_i)}")
print(f"  {hacer_hablar_informal(gato_i)}")
print(f"  {hacer_hablar_informal(pajaro_i)}")

print("\nLlamando moverse() (falla en PajaroInformal en RUNTIME):")
for animal in [perro_i, gato_i, pajaro_i]:
    try:
        print(f"  {animal.__class__.__name__}: {animal.moverse()}")
    except AttributeError as e:
        print(f"  ❌ {animal.__class__.__name__}: Error en runtime → {e}")


# -------------------------------------------------
# ENFOQUE FORMAL (ABC)
# -------------------------------------------------
print("\n🔸 PARTE B: Duck Typing FORMAL (con ABC)")
print("-" * 70)


class Animal(ABC):
    """Interfaz formal — obliga a implementar AMBOS métodos"""

    @abstractmethod
    def hablar(self):
        pass

    @abstractmethod
    def moverse(self):
        pass


class PerroFormal(Animal):
    def hablar(self):
        return "🐶 Guau!"

    def moverse(self):
        return "🐶 Corre a 30km/h"


class GatoFormal(Animal):
    def hablar(self):
        return "🐱 Miau!"

    def moverse(self):
        return "🐱 Camina sigiloso"


print("Intentar crear clase incompleta (debe fallar en DEFINICIÓN):")
try:
    class PajaroFormalIncompleto(Animal):
        def hablar(self):
            return "🐦 Pío!"
        # ← falta moverse()

    pajaro_mal = PajaroFormalIncompleto()  # Falla aquí
    print("❌ No debería llegar aquí")
except TypeError as e:
    print(f"✅ Error detectado al instanciar: {e}")

print("\nClases completas funcionan perfectamente:")
perro_f = PerroFormal()
gato_f = GatoFormal()

for animal in [perro_f, gato_f]:
    print(f"  {animal.__class__.__name__}: {animal.hablar()} | {animal.moverse()}")

print(f"\n¿PerroFormal es Animal? {isinstance(perro_f, Animal)}")
print(f"¿GatoFormal es Animal?  {isinstance(gato_f, Animal)}")


# -------------------------------------------------
# COMPARATIVA
# -------------------------------------------------
print("\n🔸 PARTE C: Comparativa Formal vs Informal")
print("-" * 70)

print("""
┌─────────────────────┬──────────────────────┬──────────────────────┐
│ Característica      │ Informal             │ Formal (ABC)         │
├─────────────────────┼──────────────────────┼──────────────────────┤
│ ABC                 │ ❌ No                │ ✅ Sí                │
│ @abstractmethod     │ ❌ No                │ ✅ Sí                │
│ Detección error     │ ⚠️  Runtime          │ ✅ Al instanciar     │
│ isinstance()        │ ❌ No funciona        │ ✅ Funciona          │
│ Flexibilidad        │ ✅ Alta              │ 🟡 Media             │
│ Seguridad           │ ❌ Baja              │ ✅ Alta              │
│ Verbosidad código   │ ✅ Poca              │ 🟡 Más código        │
└─────────────────────┴──────────────────────┴──────────────────────┘
""")

print("🎯 ¿Cuándo usar cada uno?")
print("   Informal → scripts pequeños, prototipos rápidos")
print("   Formal   → proyectos grandes, APIs públicas, trabajo en equipo")
print("   Mixto    → @abstractmethod para lo esencial + métodos concretos opcionales")


print("\n" + "=" * 70)
print("✅ EJERCICIO 5 COMPLETADO")
print("=" * 70)


# =============================================================================
# EJERCICIO 6: Sistema de Plugins
# =============================================================================

print("\n\n" + "=" * 70)
print("📝 EJERCICIO 6: Sistema de Plugins")
print("=" * 70)


# INTERFAZ BASE
class Plugin(ABC):
    """
    Contrato base para todos los plugins.
    Todo plugin DEBE implementar: nombre(), version() y ejecutar().
    """

    @abstractmethod
    def nombre(self) -> str:
        """Nombre identificador único del plugin"""
        pass

    @abstractmethod
    def version(self) -> str:
        """Versión del plugin en formato semver"""
        pass

    @abstractmethod
    def ejecutar(self, datos: dict) -> dict:
        """
        Lógica principal del plugin.
        Recibe un diccionario de datos, lo procesa y devuelve el resultado.
        """
        pass

    def info(self) -> str:
        """Método concreto: muestra información del plugin"""
        return f"🔌 [{self.nombre()}] v{self.version()}"


# PLUGINS CON HERENCIA REAL
class PluginLogger(Plugin):
    """Registra un log de los datos que pasan por el pipeline"""

    def nombre(self) -> str:
        return "Logger"

    def version(self) -> str:
        return "1.0.0"

    def ejecutar(self, datos: dict) -> dict:
        datos["_log"] = f"[LOG] Campos procesados: {list(datos.keys())}"
        return datos


class PluginValidador(Plugin):
    """Valida que los datos tengan los campos obligatorios"""

    CAMPOS_REQUERIDOS = ["nombre", "email"]

    def nombre(self) -> str:
        return "Validador"

    def version(self) -> str:
        return "2.0.0"

    def ejecutar(self, datos: dict) -> dict:
        faltantes = [c for c in self.CAMPOS_REQUERIDOS if c not in datos]
        if faltantes:
            datos["_validacion"] = f"❌ Campos faltantes: {faltantes}"
        else:
            datos["_validacion"] = "✅ Datos válidos"
        return datos


class PluginEncriptador(Plugin):
    """Enmascara datos sensibles (email)"""

    def nombre(self) -> str:
        return "Encriptador"

    def version(self) -> str:
        return "1.5.0"

    def ejecutar(self, datos: dict) -> dict:
        if "email" in datos:
            original = datos["email"]
            usuario, dominio = original.split("@") if "@" in original else (original, "")
            datos["email"] = f"{'*' * len(usuario)}@{dominio}" if dominio else "*" * len(original)
        return datos


# PLUGIN EXTERNO (sin herencia, registrado con .register())
class PluginAnalizadorExterno:
    """
    Clase externa (simula librería de terceros).
    NO hereda de Plugin, pero implementa la misma interfaz.
    Se integra con .register() sin modificar su código.
    """

    def nombre(self) -> str:
        return "AnalizadorExterno"

    def version(self) -> str:
        return "3.0.0"

    def ejecutar(self, datos: dict) -> dict:
        datos["_analisis"] = f"🔍 {len(datos)} campos detectados | tipos: {set(type(v).__name__ for v in datos.values())}"
        return datos

    def info(self) -> str:
        return f"🔌 [{self.nombre()}] v{self.version()} (externo)"


# Registrar plugin externo como subclase virtual
Plugin.register(PluginAnalizadorExterno)


# GESTOR DE PLUGINS
class GestorPlugins:
    """
    Gestiona el ciclo de vida de los plugins:
    registro, listado y ejecución en pipeline.
    """

    def __init__(self):
        self._plugins: list = []

    def registrar(self, plugin) -> None:
        """Registra un plugin validando que sea instancia de Plugin"""
        if not isinstance(plugin, Plugin):
            raise TypeError(f"❌ {plugin.__class__.__name__} no es un Plugin válido")
        self._plugins.append(plugin)
        print(f"  ✅ Registrado: {plugin.info()}")

    def listar(self) -> None:
        """Lista todos los plugins cargados"""
        print(f"\n🔌 Plugins cargados ({len(self._plugins)}):")
        for i, p in enumerate(self._plugins, 1):
            print(f"  {i}. {p.info()}")

    def ejecutar_pipeline(self, datos: dict) -> dict:
        """
        Ejecuta todos los plugins en cadena.
        La salida de uno es la entrada del siguiente.
        """
        resultado = datos.copy()
        print(f"\n⚙️  Ejecutando pipeline con {len(self._plugins)} plugins...")
        for plugin in self._plugins:
            resultado = plugin.ejecutar(resultado)
            print(f"  → {plugin.nombre()}: OK")
        return resultado


# PRUEBAS EJERCICIO 6
print("\n🔸 PRUEBA 1: Registrar plugins (herencia real + externo)")
print("-" * 70)

gestor = GestorPlugins()
gestor.registrar(PluginLogger())
gestor.registrar(PluginValidador())
gestor.registrar(PluginEncriptador())
gestor.registrar(PluginAnalizadorExterno())  # ← externo con .register()


print("\n🔸 PRUEBA 2: Listar todos los plugins")
print("-" * 70)

gestor.listar()


print("\n🔸 PRUEBA 3: Pipeline con datos completos")
print("-" * 70)

datos_ok = {
    "nombre": "Alvaro Fernandez",
    "email": "alvaro@escuelamusk.com",
    "edad": 28
}

print(f"\n📥 Datos entrada: {datos_ok}")
resultado = gestor.ejecutar_pipeline(datos_ok)
print(f"\n📤 Resultado final:")
for k, v in resultado.items():
    print(f"  {k}: {v}")


print("\n🔸 PRUEBA 4: Pipeline con datos incompletos")
print("-" * 70)

datos_mal = {
    "nombre": "Usuario Test",
    "edad": 22
}

print(f"\n📥 Datos entrada: {datos_mal}")
resultado2 = gestor.ejecutar_pipeline(datos_mal)
print(f"\n📤 Resultado final:")
for k, v in resultado2.items():
    print(f"  {k}: {v}")


print("\n🔸 PRUEBA 5: isinstance() con plugin externo")
print("-" * 70)

plugin_ext = PluginAnalizadorExterno()
print(f"¿PluginAnalizadorExterno es Plugin? {isinstance(plugin_ext, Plugin)}  ← .register() ✅")
print(f"¿PluginLogger es Plugin?            {isinstance(PluginLogger(), Plugin)}  ← herencia real ✅")


print("\n🔸 PRUEBA 6: Rechazar clase inválida")
print("-" * 70)

class NoEsPlugin:
    pass

try:
    gestor.registrar(NoEsPlugin())
except TypeError as e:
    print(f"✅ GestorPlugins rechazó correctamente: {e}")


print("\n" + "=" * 70)
print("✅ EJERCICIO 6 COMPLETADO - SISTEMA DE PLUGINS")
print("=" * 70)
print()
print("💡 Conceptos demostrados:")
print("   ✅ ABC como contrato obligatorio del plugin")
print("   ✅ @abstractmethod para interfaz obligatoria")
print("   ✅ Método concreto info() compartido")
print("   ✅ .register() para integrar plugin externo")
print("   ✅ isinstance() funciona con plugin virtual")
print("   ✅ Pipeline: cada plugin transforma los datos")
print("   ✅ GestorPlugins: valida, lista y ejecuta")
print("   ✅ Arquitectura extensible sin tocar código base")


# =============================================================================
# RESUMEN FINAL - TEMA 2 COMPLETADO
# =============================================================================

print("\n\n" + "=" * 70)
print("🎉 TEMA 2 ABC E INTERFACES - 6/6 EJERCICIOS COMPLETADOS")
print("=" * 70)
print()
print("📚 Todos los conceptos dominados:")
print("   ✅ EJ1 - Interfaz básica (ABC + @abstractmethod)")
print("   ✅ EJ2 - Interfaces múltiples (herencia múltiple)")
print("   ✅ EJ3 - Gestor con polimorfismo")
print("   ✅ EJ4 - Clases virtuales (.register())")
print("   ✅ EJ5 - Duck Typing Formal vs Informal")
print("   ✅ EJ6 - Sistema de Plugins (arquitectura real)")
print()
print("🚀 Próximo: Tema 3 - Datos Temporales")
print("=" * 70)
