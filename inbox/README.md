---
tags: [inbox, reglas, workflow, obsidian]
fecha-creacion: 2026-06-24
actualizado: 2026-06-24
estado: permanente
---

# 📥 Inbox — Zona de aterrizaje temporal

> **El inbox NO es un archivo. Es una puerta de entrada.**
> Todo lo que entra aquí tiene 24h para encontrar su carpeta definitiva.

---

## ⚠️ Reglas de uso — NO negociables

| Regla | Límite |
|---|---|
| Máximo de archivos simultáneos | **10** |
| Vida máxima de un archivo | **24 horas** |
| Archivos permanentes permitidos | **3** (README, MASTER-PENDIENTES, PLANTILLA-DIARIO) |
| Scripts en inbox | **❌ Nunca** → van a `codigo/scripts/` |
| Documentación definitiva en inbox | **❌ Nunca** → va a `docs/` |
| Sesiones completas en inbox | **❌ Nunca** → van a `diarios/` |

---

## ✅ Qué SÍ puede estar en inbox

- Una idea que acaba de llegar y no sabes aún dónde va
- Un enlace o referencia rápida para procesar hoy
- Un borrador en construcción activa (máx 24h)
- Un archivo de arranque de sesión (se migra al diario al cerrar)

## ❌ Qué NUNCA debe estar en inbox

- Scripts o código → `codigo/scripts/`
- Debates multi-IA resueltos → `docs/ias/debates/`
- Documentación de setup → `docs/setup/servidor/`
- Investigación de modelos/herramientas → `investigacion/`
- Fichas de proyectos → `proyectos/`
- Resúmenes de sesión → `diarios/YYYY-MM-DD.md`
- ADRs (decisiones de arquitectura) → `docs/arquitectura/`
- Prompts definitivos → `docs/ias/prompts/`

---

## 🔁 Flujo correcto

```
Llega información / idea / código
          ↓
   ¿Sabes dónde va?
   /            \
  SÍ            NO
   ↓              ↓
Va directo     Inbox (máx 24h)
a su carpeta        ↓
               Al cerrar sesión:
               → migra a su carpeta
               → o consolida en diarios/
```

---

## 📁 Destinos definitivos

```
yggdrasil-dew/
│
├── inbox/                    ← AQUÍ, temporal, máx 10 archivos
│
├── diarios/                  ← Un archivo por día con TODO lo de ese día
│   └── YYYY-MM-DD.md
│
├── docs/                     ← Documentación permanente
│   ├── arquitectura/         ← ADRs, decisiones de diseño
│   ├── ias/
│   │   ├── ollama/           ← Guías, modelfiles, benchmarks
│   │   ├── debates/          ← Debates multi-IA resueltos
│   │   └── prompts/          ← Prompts definitivos y plantillas
│   └── setup/
│       ├── servidor/         ← Docker, stacks, compose files
│       ├── seguridad/        ← SSH, sysctl, hardening
│       └── arch/             ← Arch Linux, Hyprland, dotfiles
│
├── codigo/                   ← Código ejecutable
│   ├── scripts/              ← bash, python, utils
│   ├── docker/               ← compose files, Dockerfiles
│   └── agentes/              ← Modelfiles, prompts ejecutables
│
├── investigacion/            ← Research en proceso
│   ├── modelos/              ← Comparativas, benchmarks de LLMs
│   ├── herramientas/         ← Evaluación de tools nuevas
│   └── osint/                ← Técnicas, herramientas OSINT
│
└── proyectos/                ← Proyectos activos
    ├── thdora/
    ├── local-brain/
    ├── chatbot-control/
    └── batcueva/
```

---

## 📋 Archivos permanentes del inbox

| Archivo | Propósito |
|---|---|
| `README.md` | Este archivo — reglas del inbox |
| `MASTER-PENDIENTES.md` | Único tracker de tareas activas |
| `PLANTILLA-DIARIO.md` | Template para arrancar sesiones |

---

## 🚨 Señal de alarma

Si el inbox supera **10 archivos** → parar todo y vaciar antes de continuar.
Si un archivo lleva **más de 24h** → migrarlo o borrarlo, sin excepciones.

> **Historia:** En jun 2026 el inbox llegó a 93 archivos en 3 días.
> Ese caos costó horas de auditoría. Esta regla existe por eso.

---

*Actualizado: 2026-06-24 por Perplexity vía MCP*
*Ver también: [[MASTER-PENDIENTES]] · [[diarios/2026-06-24]]*
