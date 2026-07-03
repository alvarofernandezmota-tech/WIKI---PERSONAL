---
tags: [proyecto/thdora, infra/docker, estado/draft]
fecha: 2026-06-30
hora: 21:42
---

# 📥 INBOX — Auditoría THDORA sesión 30-jun-2026

> Nota temporal de sesión. Migrar a `proyectos/thdora/` cuando se procese.
> Ver fichas existentes: [[proyectos/thdora.md]] · [[proyectos/thdora-docs.md]] · [[proyectos/thdora-casos-uso.md]]

---

## 🗂️ Estructura real del proyecto (~/Projects/thdora/)

```
thdora/
├── src/              ← código Python real (FastAPI + bot)
├── alembic/          ← migraciones DB
├── data/             ← datos persistentes
├── docker/           ← Dockerfile + compose
├── docs/             ← documentación interna del proyecto
├── logs/             ← logs de la aplicación
├── monitoring/       ← métricas
├── proyectos/        ← subdirectorio de proyectos internos
├── scripts/          ← scripts auxiliares
├── tests/            ← tests automatizados
├── ARCHITECTURE.md   ← arquitectura del sistema (9KB)
├── CONTEXT.md        ← contexto IA (6.4KB)
├── CHANGELOG.md      ← historial (5.2KB)
├── CONTRIBUTING.md   ← guía de contribución
├── ROADMAP.md        ← hoja de ruta
├── PLAN_MANANA.md    ← plan inmediato pendiente revisar
├── llms.txt          ← contexto para LLMs (3.7KB)
├── Makefile          ← comandos de desarrollo
├── pyproject.toml    ← configuración proyecto Python
├── requirements.txt  ← dependencias
├── Dockerfile        ← imagen Docker
└── docker-compose.yml← compose local
```

---

## 🌐 API Live — endpoints mapeados (v0.12.1)

| Grupo | Endpoints |
|---|---|
| **Appointments** | `GET /appointments/{date}` · `/week/{date}` · `/range/{from}/{to}` · `/upcoming/{from}` · `/conflict/{date}/{time}` · `DELETE /{date}/{index}` |
| **Habits** | `GET /habits/{date}` · `/week/{date}` · `/range/{from}/{to}` · `/stats/{habit}` · `PATCH /{date}/{habit}` |
| **Summary** | `GET /summary/{date}` · `/summary/week/{date}` |
| **Config** | `GET/POST /habit-config/` · `/habit-config/{name}` · `/user_config/{user_id}` · `POST /admin/add_user` |
| **Health** | `/health/live` · `/health/ready` · `/` |

Total: **20 endpoints activos** en producción.

---

## 🧹 Limpieza realizada hoy

Se eliminaron archivos basura en `~/Projects/thdora/` (residuos de sesión anterior):
- `8591160057:AAHTN9LlaNwwhgqLq5V2CwqlhlGXzquw3E8` ← ⚠️ token Telegram expuesto en filesystem (vacío, 0 bytes, pero el nombre era el token real)
- `=`, `[bot`, `[bot]`, `[thdora`, `[thdora]`, `CACHED`, `exporting`, `naming`, `resolve`, `unpacking`

> ⚠️ **ACCIÓN PENDIENTE:** Verificar que el token `8591160057:AAHTN9LlaNwwhgqLq5V2CwqlhlGXzquw3E8` **no está comprometido**. Aunque el archivo tenía 0 bytes (era el nombre del archivo, no contenido), el token estaba visible en el filesystem. Considerar **revocar y regenerar el token** en @BotFather por precaución.

---

## 🤖 Handlers Telegram — estado actual

El bot `thdora-bot` está UP (contenedor healthy) pero los handlers de Telegram que consumen la API están **pendientes de implementar o verificar**.

### Handlers prioritarios a implementar:
1. `/hoy` → `GET /summary/{date}` — resumen del día actual
2. `/semana` → `GET /summary/week/{date}` — resumen semanal
3. `/habitos` → `GET /habits/{date}` — estado hábitos hoy
4. `/agenda` → `GET /appointments/{date}` — citas del día
5. `/proximas` → `GET /appointments/upcoming/{date}` — próximas citas

### Webhook Uptime Kuma (en yggdrasil-dew/thdora/routers/webhooks.py):
- Endpoint `POST /webhook/uptime` implementado en 27-jun
- **Pendiente:** verificar si está registrado en el `main.py` de thdora
- **Pendiente:** configurar Uptime Kuma para que apunte a este webhook

---

## 📋 Pendientes auditoría THDORA

- [ ] Leer `src/` para mapa completo de handlers actuales del bot
- [ ] Leer `PLAN_MANANA.md` — tiene el plan inmediato pendiente
- [ ] Leer `ARCHITECTURE.md` — para entender estructura completa
- [ ] Verificar si `webhooks.py` está incluido en `main.py`
- [ ] Implementar handlers prioritarios (ver lista arriba)
- [ ] Revocar/regenerar token Telegram en @BotFather (precaución)
- [ ] Configurar Uptime Kuma → webhook THDORA
- [ ] Actualizar [[proyectos/thdora.md]] con estado real 30-jun

---

## 🔗 Referencias
- [[proyectos/thdora.md]] — ficha principal del proyecto
- [[proyectos/thdora-docs.md]] — documentación técnica
- [[proyectos/thdora-casos-uso.md]] — casos de uso
- [[proyectos/thdora-vision-producto.md]] — visión de producto
- [[proyectos/thdora-v0.17.0-y-mas-alla.md]] — roadmap futuro

---
_Procesar en próxima sesión → migrar hallazgos a `proyectos/thdora/` y actualizar ficha principal_
_Token pendiente verificar: ver sección Limpieza_
