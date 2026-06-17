# 🤖 THDORA — Visión Producto y Escalamiento

> Documento creado: 17 junio 2026 · 03:07 CEST
> Estado: borrador estratégico · pendiente decisión

---

## 📍 Dónde estamos hoy

thdora es un **bot personalizado** para un solo negocio (el tuyo).
Funciona. Tiene NLP, citas, hábitos, Groq, `/diario`, Docker en Madre.
Pero está hardcodeado — no es cloneable sin tocar código.

---

## 🧬 La selección natural del producto

### Fase 1 — Bot reactivo (HOY ✅)
```
Usuario habla → bot responde
```
- Un negocio, un bot
- Configuración manual en .env
- Funciona para validar el concepto

### Fase 2 — Bot cloneable (Sprint 5-6)
```
Cualquier negocio puede tener su propio bot
sin que el desarrollador toque código
```
- Multi-tenant real (1 instancia, N negocios)
- Onboarding self-service: nombre, sector, idioma, horarios
- Panel de configuración web por negocio
- Cada negocio tiene sus usuarios, sus citas, sus hábitos aislados

### Fase 3 — Bot agéntico (Sprint 7-8)
```
El bot actúa solo, sin que el usuario le hable primero
```
Ejemplos de comportamiento agéntico:
- "Llevas 3 días sin registrar hábitos, ¿todo bien?"
- "Tu cita de mañana fue cancelada, ¿reagendo?"
- "Esta semana tienes hueco el jueves a las 11, ¿lo bloqueo?"
- "Noto que siempre cancelas los lunes, ¿quieres que no ponga citas ese día?"
- Resumen semanal automático sin que nadie lo pida
- Alertas proactivas de conflictos en agenda

### Fase 4 — Agente con memoria real (Sprint 9+)
```
El bot aprende patrones del negocio y del usuario
y toma decisiones autónomas dentro de límites definidos
```
- Memoria persistente por usuario (más allá de user_data)
- Patrones detectados: horarios preferidos, cancelaciones habituales
- Sugerencias basadas en historial real
- Integración con calendarios externos (Google Calendar, Outlook)

---

## 🏗️ Arquitectura de escalamiento

### Hoy (monousuario)
```
Telegram Bot
    └── FastAPI + SQLite
    └── Groq (NLP)
    └── GitHub (diario)
    └── Docker en Madre
```

### Multi-tenant (Fase 2)
```
N Telegram Bots (uno por negocio)
    └── FastAPI central + PostgreSQL
         └── Tabla: negocios (id, nombre, config, bot_token)
         └── Tabla: usuarios (id, negocio_id, telegram_id)
         └── Tabla: citas (id, negocio_id, usuario_id, ...)
    └── Groq con system prompt dinámico por negocio
    └── Panel admin web por negocio
    └── Docker con N contenedores bot o 1 bot multi-token
```

### Agéntico (Fase 3)
```
scheduler.py expandido:
    └── job por negocio: revisar hábitos pendientes
    └── job por negocio: detectar huecos en agenda
    └── job global: resúmenes semanales
    └── job: alertas proactivas basadas en patrones

memoria.py (nuevo):
    └── PatronUsuario: horarios preferidos, tasa cancelación
    └── PatronNegocio: horas pico, servicios más solicitados
```

---

## 📋 Roadmap de sprints

| Sprint | Nombre | Qué añade | Prerequisito |
|--------|--------|-----------|-------------|
| 3 | NLP real + voz | historial conversación, Whisper, resumen semanal | Sprint 2 ✅ |
| 4 | Infraestructura | CD automático, monitor.py, panel operador, LLM factory | Sprint 3 |
| 5 | Multi-tenant | PostgreSQL, N bots, aislamiento por negocio | Sprint 4 |
| 6 | Self-service | onboarding web, configuración sin código | Sprint 5 |
| 7 | Agéntico básico | scheduler proactivo, alertas inteligentes | Sprint 6 |
| 8 | Memoria | patrones usuario/negocio, sugerencias | Sprint 7 |
| 9+ | Agente real | decisiones autónomas, integraciones externas | Sprint 8 |

---

## ⚡ Lo que hace posible el salto agéntico

thdora ya tiene los ingredientes:

| Ingrediente | Estado | Para qué sirve |
|-------------|--------|----------------|
| `scheduler.py` | ✅ existe | base de todos los jobs proactivos |
| Groq function calling | ✅ existe | tomar decisiones estructuradas |
| SQLite con historial | ✅ existe | detectar patrones |
| `user_data` PTB | ✅ existe | memoria de sesión |
| `OWNER_CHAT_ID` | ✅ existe | canal de control |
| `transcribe()` Whisper | ✅ existe | input de voz |

Lo que falta es **orquestación** — conectar estas piezas con lógica proactiva.

---

## 🔴 Decisión pendiente

> **¿Cuándo empezamos multi-tenant?**
>
> Opción A — después de Sprint 4 (infraestructura sólida primero)
> Opción B — en paralelo con Sprint 3 en rama separada
> Opción C — ahora, directamente
>
> Recomendación: **Opción A** — el bot tiene que ser estable en producción
> antes de multiplicarlo. Un multi-tenant con bugs es N veces los bugs.

---

## 💡 Nombre comercial

Si esto escala a producto, THDORA como marca tiene recorrido:
- **T**elegram + **H**abits + **D**octor + **ORA** (asistente en latín)
- Posicionamiento: "el asistente de gestión para negocios pequeños"
- Target: clínicas, peluquerías, fisios, consultas, estudios

---

*Documento vivo — actualizar con cada sprint*
