# Tema 6. Patrones de Diseño

> M5 · Manipulación de Datos · Escuela Musk

**Estado:** 🔄 En curso — 25 marzo 2026

---

## 📌 RECURSOS DEL TEMA

| Recurso | URL | Estado |
|---------|-----|--------|
| Tema 6.1 Patrones de diseño | https://campus.escuelamusk.com/mod/videotime/view.php?id=207&forceview=1 | ✅ |
| Tema 6.2 Creational design patterns | https://campus.escuelamusk.com/mod/videotime/view.php?id=210&forceview=1 | ✅ |
| Tema 6.3 Structural design patterns | https://campus.escuelamusk.com/mod/videotime/view.php?id=209&forceview=1 | ✅ |
| Tema 6.4 Behavioral design patterns | https://campus.escuelamusk.com/mod/videotime/view.php?id=208&forceview=1 | ✅ |
| Tema 6. Block puzzle | https://campus.escuelamusk.com/mod/scorm/view.php?id=294&forceview=1 | ⏳ |
| Trivial Mix (final módulo) | https://campus.escuelamusk.com/mod/scorm/view.php?id=602&forceview=1 | ⏳ |

> ⚠️ Este tema no tiene PDF — apuntes tomados en clase.

---

## 📋 CHECKLIST

- [x] Tema 6.1 — Patrones de diseño (introducción)
- [x] Tema 6.2 — Creational design patterns
- [x] Tema 6.3 — Structural design patterns
- [x] Tema 6.4 — Behavioral design patterns
- [ ] Block puzzle T6
- [ ] Trivial Mix (cierre módulo)

---

## 📝 6.1 — ¿Qué son los Patrones de Diseño?

**Definición oficial:**
> Son **plantillas que describen cómo resolver un problema particular**. Son muy útiles para programadores con experiencia en POO.

**Por qué existen:**
- Miles de programadores han resuelto los mismos problemas antes
- Los patrones recogen las soluciones más elegantes y probadas
- Evitan reinventar la rueda en cada proyecto

**Requisito previo:** Dominar POO — clases, herencia, encapsulamiento, polimorfismo.

---

## 📝 6.2 — Creational Patterns

> Cómo se **crean** los objetos de forma inteligente y flexible.
> **Regla de oro:** Separar la creación del objeto de su uso.

### Factory Method — "La fábrica"
```python
def factory(tipo):
    if tipo == "perro": return Perro()
    if tipo == "gato":  return Gato()
```
> Creas objetos sin saber exactamente cuál hasta el momento de ejecutar.
> **En THDORA:** Crear tipos de hábitos (`HabitTabaco`, `HabitSueño`...)

### Prototype — "La fotocopiadora"
```python
heroe2 = heroe_base.clonar()  # copy.deepcopy()
heroe2.nombre = "Guerrero 2"
```
> Clonas un objeto existente en vez de crearlo desde cero (costoso).
> **En THDORA:** Clonar citas recurrentes.

### Builder — "El constructor por pasos"
```python
cita = (AppointmentBuilder()
    .tipo("revisión").dia("lunes").hora("09:00")
    .duracion(30).recordatorio(True).build())
```
> Construyes objetos complejos paso a paso.
> **En THDORA:** Crear un Appointment con muchas opciones opcionales.

| Patrón | Una frase | Clave Python |
|--------|-----------|-------------|
| **Factory** | "Dame un objeto de este tipo" | Método `crear()` |
| **Prototype** | "Dame una copia" | `copy.deepcopy()` |
| **Builder** | "Constrúyelo paso a paso" | Métodos encadenados + `.build()` |

---

## 📝 6.3 — Structural Patterns

> Cómo se **organizan y conectan** las clases y objetos.

### Adapter — "El enchufe universal"
```python
class TelegramAdapter(NotificadorTHDORA):
    def notificar(self, mensaje):           # idioma THDORA
        self.telegram.send(12345, mensaje)  # idioma Telegram
```
> Conecta dos sistemas incompatibles sin tocar ninguno.
> **En THDORA:** APIs de Telegram, Google Calendar, Notion.

### Bridge — "El puente"
```python
class Notificacion(ABC):
    def __init__(self, canal):  # canal = cualquier Adapter
        self.canal = canal
    def enviar(self, msg):
        self.canal.enviar(msg)

NotificacionUrgente(TelegramAdapter()).enviar("Urgente")
NotificacionNormal(EmailAdapter()).enviar("Resumen")
```
> Unifica múltiples Adapters bajo una abstracción. Cada Adapter habla su idioma, Bridge los organiza.
> **Regla:** Adapter arregla incompatibilidades. Bridge previene explosión de clases.

### Composite — "El árbol"
```python
class Carpeta(Componente):
    def mostrar(self):
        for hijo in self.hijos:
            hijo.mostrar()  # igual para archivos Y carpetas
```
> Estructura jerárquica donde nodos y hojas se tratan igual.
> **En THDORA:** THDORA → Módulos → Submódulos → Funciones.

| Patrón | Problema | Analogía |
|--------|----------|----------|
| **Adapter** | Dos sistemas incompatibles | Adaptador de enchufe |
| **Bridge** | Abstracción + múltiples implementaciones | Puente sobre APIs |
| **Composite** | Estructura jerárquica árbol | Sistema de archivos |

---

## 📝 6.4 — Behavioral Patterns

> Cómo se **comunican y comportan** los objetos entre sí.

### Observer — "El periódico"
```python
habito.suscribir(bot_telegram)
habito.suscribir(dashboard)
habito.registrar_cigarro()  # avisa a todos automáticamente
```
> Cuando algo cambia, avisa automáticamente a todos los suscritos.
> **En THDORA:** Cigarro registrado → avisa a bot, dashboard, contador.

### Strategy — "El algoritmo intercambiable"
```python
calc = CalculadorHabito(ModoEstricto())   # 0 cigarros = éxito
calc = CalculadorHabito(ModoReduccion())  # cuenta tendencia bajista
calc = CalculadorHabito(ModoLibre())      # solo registra
```
> Mismo objeto, diferentes algoritmos intercambiables en tiempo real.
> **Analogía:** Google Maps — mismo destino, diferente ruta (coche/pie/bici).

### Command — "La orden encapsulada"
```python
comando = RegistrarHabito()
comando.ejecutar()
comando.deshacer()  # CTRL+Z
```
> Encapsula una acción para ejecutarla, deshacerla o programarla.

### Chain of Responsibility — "La cadena de mando"
```python
validar.set_siguiente(conflicto).set_siguiente(guardar).set_siguiente(notificar)
validar.manejar(cita)  # recorre la cadena sola
```
> Cada Handler tiene una sola misión — resuelve o pasa al siguiente.
> **En THDORA:** Validar → ComprobarConflicto → Guardar → Notificar.

### Template Method — "El esqueleto fijo"
```python
class Habito(ABC):
    def ejecutar(self):   # orden fijo
        self.validar()
        self.registrar()  # cada hábito implementa esto
        self.notificar()
```

### State — "El estado cambiante"
```python
habito.estado = EnRacha()   # celebra si cumples
habito.estado = Roto()      # alerta si fallas
habito.estado = EnPausa()   # no evalúa
```

### Iterator — "El recorredor"
```python
for habito in coleccion_habitos:  # lista, BD, JSON... da igual
    habito.evaluar()
```

---

## 📊 MAPA COMPLETO

```
PATRONES DE DISEÑO
├── Creational  → CÓMO se crean los objetos
│   ├── Factory Method  → "Dame un objeto de este tipo"
│   ├── Prototype       → "Dame una copia"
│   └── Builder         → "Constrúyelo paso a paso"
├── Structural  → CÓMO se organizan y conectan
│   ├── Adapter         → "Traduzco esta API a mi idioma"
│   ├── Bridge          → "Unifico Adapters bajo una abstracción"
│   └── Composite       → "Estructura jerárquica en árbol"
└── Behavioral  → CÓMO se comunican y comportan
    ├── Observer              → Suscriptores avisados automáticamente
    ├── Strategy              → Algoritmo intercambiable
    ├── Command               → Acción con undo
    ├── Chain of Responsibility → Cadena de mando
    ├── Template Method       → Esqueleto fijo
    ├── State                 → Comportamiento según estado
    └── Iterator              → Recorrer sin saber cómo está guardado
```

---

## 🔗 THDORA — Dónde usa cada patrón

| Parte de THDORA | Patrón |
|----------------|--------|
| Crear tipos de hábitos | **Factory** |
| Clonar citas recurrentes | **Prototype** |
| Crear Appointments complejos | **Builder** |
| Estructura de módulos | **Composite** |
| Canales de notificación | **Bridge + Adapter** |
| Cigarro registrado → avisar | **Observer** |
| Modo estricto / flexible / libre | **Strategy** |
| Deshacer registro | **Command** |
| Flujo registrar cita | **Chain of Responsibility** |
| Estado del hábito (racha/roto/pausa) | **State** |

---

## ✅ QUIZ / BLOQUE PUZZLE — Resultados

### Block Puzzle T6
- **Nota:** ⏳ pendiente

### Trivial Mix (cierre M5)
- **Nota:** ⏳ pendiente

---
_Creado: 16 marzo 2026 | Actualizado: 25 marzo 2026 18:12 CET — apuntes completos 6.1-6.4_
