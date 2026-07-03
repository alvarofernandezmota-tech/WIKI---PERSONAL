# SCRIPTS.md — Índice Maestro del Ecosistema Yggdrasil

> **Auditoría:** 2026-07-03 | **Estado:** Reorganización en curso
> 
> Índice completo de todos los scripts del ecosistema. Actualizar en cada sesión que se añada o elimine un script.

---

## 📁 Estructura de directorios

```
scripts/
├── SCRIPTS.md               ← este archivo
├── README.md                ← entrada rápida
├── 01-10-*.sh               ← scripts de fases (ver sección Fases)
├── backup/                  ← backups y restic
├── infra/                   ← infraestructura y Docker
├── maintenance/             ← sesión diaria y mantenimiento
├── osint/                   ← stack OSINT
├── seguridad/               ← hardening y UFW
├── setup/                   ← instalación inicial
├── thdora/                  ← scripts de producción thdora
└── thdora-dev/              ← scripts de desarrollo/migración thdora

# En raíz del repo (a mover → scripts/):
# bootstrap.sh, macro-noche.sh
```

---

## 🔢 Scripts de Fases (numerados)

| Nº | Archivo | Fase | Descripción | Estado |
|----|---------|------|-------------|--------|
| 01 | `01-fix-driver-rtl8188ftu.sh` | Hardware | Fix driver WiFi RTL8188FTU | ✅ Activo |
| 02 | `02-git-pull-rebase.sh` | Dev | Pull + rebase todos los repos | ✅ Activo |
| 03 | `03-fase1-seguridad.sh` | Seguridad | Hardening inicial del sistema | ✅ Activo |
| 04 | `04-fase2-start-batcueva.sh` | Infra | Arranque Batcueva (Docker stack) | ✅ Activo |
| 05 | `05-fase7-ollama-pull.sh` | IA | Pull modelos Ollama | ✅ Activo |
| 06 | `06-verificacion-post-reboot.sh` | Sistema | Verificación tras reinicio | ✅ Activo |
| 07 | `07-fase3-restic-backup.sh` | Backup | Backup incremental con restic | ✅ Activo |
| 08 | `08-fase6-thdora-handlers.sh` | Thdora | Arranque handlers Telegram bot | ✅ Activo |
| 09 | `09-fase8-seguridad-acer.sh` | Seguridad | Hardening específico Acer | ✅ Activo |
| 10 | `10-fase9-osint-stack.sh` | OSINT | Arranque stack OSINT | ✅ Activo |

> ⚠️ **Deuda:** La numeración no es secuencial con las fases reales del ROADMAP. Pendiente realinear en Sprint siguiente.

---

## 🔧 Scripts de Mantenimiento (`maintenance/`)

| Archivo | Descripción | Cuándo ejecutar |
|---------|-------------|------------------|
| `new-session.sh` | Script de inicio de sesión diaria | Al iniciar el día |

---

## 🏠 Scripts de Setup (`setup/`)

> Ver contenido real en `scripts/setup/` — pendiente de catalogar en próxima sesión.

---

## 🦇 Scripts Thdora — Producción (`thdora/`)

> Ver contenido real en `scripts/thdora/` — pendiente de catalogar.

---

## 🧪 Scripts Thdora — Desarrollo (`thdora-dev/`)

| Archivo | Descripción | Estado |
|---------|-------------|--------|
| `inbox_migrate.py` | Migración masiva de inbox a estructura Obsidian | ✅ Funcional |
| `README.md` | Documentación del subdirectorio | ✅ |

---

## 📥 Scripts de Inbox

| Archivo | Descripción | Estado |
|---------|-------------|--------|
| `inbox-cleanup-jun2026.sh` | Limpieza inbox Junio 2026 | ✅ Activo |
| `inbox-cleanup-jun2024.sh` | Limpieza inbox Junio 2024 | 🧟 **ZOMBIE** — sustituido por jun2026 |
| `inbox-migrate.sh` | Migración de inbox | ⚠️ Revisar si duplica thdora-dev/inbox_migrate.py |
| `migrar-inbox.sh` | Migración alternativa de inbox | ⚠️ Revisar duplicado |
| `procesar-inbox-masivo.sh` | Procesado masivo de inbox | ✅ Activo |

---

## 🔒 Scripts de Seguridad (`seguridad/`)

| Archivo | Descripción |
|---------|-------------|
| `hardening-ufw.sh` | Configuración UFW | 

---

## 🌐 Scripts OSINT (`osint/`)

> Ver contenido real en `scripts/osint/` — pendiente de catalogar.

---

## 🏗️ Scripts Infra (`infra/`)

> Ver contenido real en `scripts/infra/` — pendiente de catalogar.

---

## 📦 Scripts Backup (`backup/`)

> Ver contenido real en `scripts/backup/` — pendiente de catalogar.

---

## 🔴 Scripts Sueltos (a reorganizar)

| Archivo | Ubicación actual | Ubicación correcta | Prioridad |
|---------|-----------------|--------------------|-----------|
| `bootstrap.sh` | `/` raíz repo | `scripts/setup/` | 🔴 Alta |
| `macro-noche.sh` | `/` raíz repo | `scripts/maintenance/` | 🔴 Alta |
| `bc` | `scripts/bc` | ELIMINAR o renombrar con descripción | 🔴 Alta |
| `gemini-brief.md` | `scripts/gemini-brief.md` | `docs/` | 🟡 Media |
| `thdora-handlers.py` | `scripts/thdora-handlers.py` | `scripts/thdora/` | 🔴 Alta |
| `inicio-sesion.sh` | `scripts/inicio-sesion.sh` | 🧟 Revisar si zombie (161 bytes) | 🟡 Media |
| `watchdog_adb.sh` | `scripts/watchdog_adb.sh` | `scripts/infra/` o `scripts/hardware/` | 🟡 Media |
| `uptime-kuma-webhook.py` | `scripts/uptime-kuma-webhook.py` | `scripts/infra/` | 🟡 Media |
| `batcueva-control.sh` | `scripts/batcueva-control.sh` | `scripts/infra/` | 🔴 Alta |
| `fix-permisos.sh` | `scripts/fix-permisos.sh` | `scripts/setup/` | 🟡 Media |

---

## 🤖 Scripts PENDIENTES — El Bot los necesita

Estos scripts **no existen aún** pero son necesarios para que el bot de Telegram funcione correctamente:

| Script a crear | Descripción | Prioridad |
|----------------|-------------|----------|
| `scripts/thdora/bot-session-report.sh` | Genera resumen de sesión y lo envía por Telegram | 🔴 Alta |
| `scripts/maintenance/close-session.sh` | Cierre de sesión: commit, push, resumen | 🔴 Alta |
| `scripts/maintenance/night-cron.sh` | Cron nocturno: backup + git pull + health check | 🔴 Alta |
| `scripts/thdora/inbox-auto-process.sh` | Procesado automático del inbox vía bot | 🟡 Media |
| `scripts/infra/docker-health-check.sh` | Health check de todos los contenedores | 🟡 Media |
| `scripts/thdora/ema-audit.sh` | Lanzar auditoría IA de Ema desde Telegram | 🟢 Baja |

---

## 🧟 Zombies Confirmados

| Archivo | Razón | Acción |
|---------|-------|--------|
| `scripts/inbox-cleanup-jun2024.sh` | Sustituido por jun2026 | Eliminar |
| `scripts/bc` | Sin nombre, sin extensión, sin propósito claro | Identificar o eliminar |
| `scripts/inicio-sesion.sh` | 161 bytes — probablemente sustituido por `new-session.sh` | Confirmar y eliminar |

---

## 📋 Reglas del Ecosistema para Scripts

1. **Un script = una responsabilidad** — si hace más de una cosa, dividir
2. **Siempre en el subdirectorio correcto** — nunca scripts sueltos en raíz
3. **Nombre descriptivo con guiones** — `accion-objeto-contexto.sh`
4. **Header obligatorio** en cada script:
   ```bash
   #!/usr/bin/env bash
   # Descripción: qué hace
   # Ecosistema: yggdrasil / thdora / ambos
   # Ejecutar: cuándo y cómo
   # Dependencias: qué necesita
   ```
5. **Scripts que crea el bot** van en `scripts/thdora/`
6. **No ocupar terminales** — scripts pesados siempre con `&` o `tmux`

---

*Última actualización: 2026-07-03 — Auditoría inicial completa*
*Próxima acción: crear scripts pendientes del bot (ver sección arriba)*
