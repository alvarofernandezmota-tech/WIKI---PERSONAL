---
tags: [clasificador, pipeline, reglas, thdora-guardian]
fecha-creacion: 2026-07-03
estado: activo
---

# 🧠 CLASIFICADOR DE ARTEFACTOS

> Reglas que usa el clasificador automático para decidir qué es cada cosa.
> Ejecutado por `clasificador.yml` en cada push con archivos nuevos.

---

## Reglas de clasificación

| Patrón | Tipo | Acción automática |
|--------|------|--------------------|
| `*.sh` fuera de `scripts/` | 💀 ZOMBIE | Alerta Telegram |
| `.github/workflows/*.yml` | ⚡ GitHub Action | Documentar en SCRIPTS.md |
| `scripts/maintenance/*.sh` | 🔧 Script mantenimiento | Registrar en SCRIPTS.md |
| `scripts/thdora/*.sh` | 🤖 Script bot | Documentar handler thdora |
| `scripts/infra/*.sh` | 🏗️ Script infra | Verificar si necesita Docker |
| `scripts/*.sh` (sin subdir) | 📜 Script suelto | Mover a subdirectorio |
| `docs/**/*.md` sin frontmatter | ⚠️ Doc incompleta | Añadir tags/fecha |
| `docs/**/*.md` con frontmatter | 📖 Doc OK | Verificar enlace HOME.md |
| `src/**/*.py` sin README | ⚠️ Módulo sin doc | Crear README en el módulo |
| `*docker-compose*` / `Dockerfile` | 🐳 Docker | Evaluar si merece repo propio |
| Archivo suelto en raíz | 💀 ZOMBIE-RAIZ | Clasificar o borrar |

---

## ¿Cuándo un módulo merece repo propio?

El clasificador detecta el caso pero la **decisión la toma el humano**.
Criterios para repo separado:

- ✅ Tiene más de 10 archivos propios
- ✅ Tiene su propio `Dockerfile`
- ✅ Es independiente del repo principal (otro equipo podría usarlo)
- ✅ Tiene tests propios
- ❌ NO si comparte código con thdora o yggdrasil-dew directamente
- ❌ NO si es menos de 3 semanas de vida

**Ema:** integrada en thdora como módulo. No repo aparte. — Decidido 2026-07-03.

---

## Output del clasificador

Cada ejecución genera:
```
inbox/clasificado-YYYY-MM-DD-RUN.md
```

Este archivo es leído por Thdora Guardián via handler `/inbox`.
Si hay zombies, Thdora envía alerta inmediata por Telegram.

---

## Flujo completo con filtro

```
PUSH al repo
    ↓
¿Hay archivos NUEVOS? — No → no hace nada
    ↓ Sí
¿Es zombie (script en sitio incorrecto)? — Sí → ALERTA TELEGRAM 🚨
    ↓ No
¿Es doc sin frontmatter? — Sí → aviso suave Telegram ⚠️
    ↓ No
¿Es módulo nuevo sin README? — Sí → aviso Telegram ⚠️
    ↓ No
✅ Clasificado correctamente → log en inbox + resumen Telegram
```

---

## Relación con las fases

| Pieza | Fase | Estado |
|-------|------|--------|
| `clasificador.yml` | 5 | ✅ Activo |
| `audit-on-push.yml` | 5 | ✅ Activo |
| `sync-estado.yml` | 5 | ✅ Activo (cron) |
| Handler `/inbox` thdora | 6 | ⏳ Pendiente Docker |
| Notificación Telegram zombie | 6 | ⏳ Pendiente handlers |
| Ema lector inbox con IA | 7 | 🔮 Diseñado |

---

_Creado: 2026-07-03 06:50 CEST — Perplexity MCP_
