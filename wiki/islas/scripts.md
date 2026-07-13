---
tipo: isla
repo: yggdrasil-scripts
creado: 2026-07-13
actualizado: 2026-07-13
tags: [scripts, automatizacion, ci, shellcheck, operaciones]
status: activo
---

# Isla: Scripts

> Capa de automatización operativa del ecosistema Yggdrasil. Scripts probados, versionados y con CI.

---

## Qué es

Repo [`yggdrasil-scripts`](https://github.com/alvarofernandezmota-tech/yggdrasil-scripts) — scripts de automatización:
- **health/** → scripts de diagnóstico y verificación del sistema
- **maintenance/** → rotación de logs, limpieza, backups
- **CI** → ShellCheck automático en cada push (GitHub Actions)

---

## Scripts activos

| Script | Ubicación | Qué hace |
|--------|-----------|----------|
| `check-docker.sh` | `health/` | Verifica servicios Docker en Madre |
| `check-env.sh` | `health/` | Valida formato y contenido del `.env` |
| `rotate-logs.sh` | `maintenance/` | Rotación de logs de contenedores |

---

## Reglas de uso

1. **Todo script pasa ShellCheck** antes de merge
2. **No hay secretos** en scripts — todo via `.env` o argumentos
3. **Un script = una responsabilidad** — no scripts multiusos
4. **README en cada carpeta** — documentar propósito y uso

---

## Conexiones en el ecosistema

- **Madre** → destino de ejecución de todos los scripts
- **yggdrasil-dew** → ADR-009 documenta la decisión de crear este repo
- **madre-config** → los scripts complementan la IaC
- **n8n** → puede invocar scripts como tareas de mantenimiento

---

## Cómo añadir un script

```bash
# 1. Crear en la carpeta correcta
vim yggdrasil-scripts/health/check-nueva-cosa.sh

# 2. Hacerlo ejecutable
chmod +x check-nueva-cosa.sh

# 3. ShellCheck local
shellcheck check-nueva-cosa.sh

# 4. Commit y push → CI valida automáticamente
git add . && git commit -m 'feat(health): check nueva cosa'
```

---

_Creado: 2026-07-13 · Perplexity-MCP · Activo_
