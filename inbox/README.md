# inbox/ — Cómo funciona

> El inbox es la zona de aterrizaje. Todo entra aquí primero.
> Nada se pierde. Todo se procesa después — manualmente o via agente.

---

## Regla de oro

**Si tienes dudas de dónde va algo → inbox.**
Mejor documentado en inbox que perdido.

---

## Estructura de ficheros

```
inbox/
├── README.md                          ← este fichero
├── MASTER-PENDIENTES.md               ← MOVIDO A RAÍZ (ver /MASTER-PENDIENTES.md)
│
├── Sesiones de trabajo
│   ├── YYYY-MM-DD-sesion-*.md         ← resumen de sesión con agente IA
│   └── YYYY-MM-DD-sesion-completa.md  ← dump completo de conversación
│
├── Auditorías
│   └── YYYY-MM-DD-auditoria-*.md      ← auditoría de una carpeta o área
│
├── Decisiones (ADR)
│   └── YYYY-MM-DD-adr-*.md            ← Architecture Decision Records
│   └── YYYY-MM-DD-decision-*.md       ← decisiones puntuales
│
├── Investigaciones
│   └── YYYY-MM-DD-*-investigacion.md  ← deep research sobre un tema
│   └── YYYY-MM-DD-ollama-*.md         ← investigaciones sobre modelos/RAG
│
├── Proyectos (fichas)
│   └── YYYY-MM-DD-proyecto-*.md       ← ficha inicial de un proyecto
│
├── Scripts y configs pendientes
│   └── YYYY-MM-DD-script-*.md         ← scripts a implementar
│   └── YYYY-MM-DD-*-plan.md           ← planes de implementación
│
└── Varios
    └── YYYY-MM-DD-*.md                ← todo lo que no encaja arriba
```

---

## Ciclo de vida de un fichero inbox

```
Nueva idea / sesión
       ↓
  inbox/YYYY-MM-DD-nombre.md
       ↓
  [revisión manual o agente]
       ↓
  ┌────────────────────────────────────┐
  │ ¿Es un script ejecutable?          │ → setup/servidor/scripts/
  │ ¿Es documentación de un servicio?  │ → docs/
  │ ¿Es un ADR/decisión?               │ → docs/adr/
  │ ¿Es un diario de sesión procesado? │ → diarios/
  │ ¿Es un proyecto?                   │ → proyectos/
  │ ¿Es config de infraestructura?     │ → setup/
  └────────────────────────────────────┘
       ↓
  Fichero eliminado de inbox/ (ya procesado)
```

---

## Ficheros especiales (no tocar)

| Fichero | Descripción |
|---|---|
| `MASTER-PENDIENTES.md` | Movido a raíz — editar en `/MASTER-PENDIENTES.md` |
| `2026-06-23-VACIADO-MAESTRO-GEMINI.md` | Dump maestro Gemini — fuente histórica |
| `2026-06-23-yggdrasil-v4-diario-maestro.md` | Diario maestro v4 — referencia |

---

## Automatización futura

Cuando THDORA esté operativo en Fase 5, este proceso será automático:
- THDORA lee inbox/ cada noche
- Clasifica y mueve ficheros a sus destinos
- Actualiza MASTER-PENDIENTES.md
- Hace commit + push

Hasta entonces: **revisión manual cada domingo**.

---
_Ver: [MASTER-PENDIENTES.md](../MASTER-PENDIENTES.md) · [ROADMAP.md](../ROADMAP.md) · [ESTADO-SISTEMA.md](../ESTADO-SISTEMA.md)_
