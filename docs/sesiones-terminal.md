# Sistema de sesiones y trazabilidad — yggdrasil-dew

## Propósito

Este documento describe el flujo completo de trabajo de una sesión en el repo `yggdrasil-dew`, desde lo que ocurre en la terminal hasta su reflejo en `inbox/` y el destino final en `diarios/` controlado por GitHub Actions.

El objetivo es tener trazabilidad fuerte: cada sesión deja huella estructurada (logs, cierres, auditorías) y cualquier error de estructura es detectado automáticamente.

## Componentes principales

| Script | Función |
|---|---|
| `scripts/session-logger.sh` | Registra la sesión de terminal en `inbox/sesiones/` |
| `scripts/session-terminal-doc.sh` | Genera el documento de cierre con estado del repo |
| `scripts/orquestador-unico.sh` | Punto de entrada único para audit / inbox / health |
| `scripts/file-arrival-guardian.sh` | Verifica estructura de carpetas y genera informe |

---

## `session-logger.sh`

### Objetivo
Capturar la sesión de terminal y guardarla en `inbox/sesiones/` como log estructurado con cabecera (fecha, hora, usuario, host, branch).

### Uso
```bash
# Al empezar a trabajar
source scripts/session-logger.sh

# Al cerrar la sesión
bash scripts/session-logger.sh --close
```

### Salida
- `inbox/sesiones/log-YYYYMMDDTHHMMSS.md`

---

## `session-terminal-doc.sh`

### Objetivo
Generar automáticamente un documento de cierre de sesión con:
- Descripción de la sesión
- Estado del repo (branch, git status)
- Últimos commits y archivos cambiados
- Resultado de `file-arrival-guardian` en modo `--dry-run`
- Lista de próximos pasos

### Uso
```bash
bash scripts/session-terminal-doc.sh "descripción de la sesión"

git add inbox/sesiones/cierre-*.md
git commit -m "docs(sesion): cierre YYYY-MM-DD HH:MM — descripción"
git push origin main
```

### Salida
- `inbox/sesiones/cierre-YYYYMMDDTHHMMSS.md`

---

## `orquestador-unico.sh`

### Objetivo
Ser el orquestador único del ecosistema, sustituyendo scripts duplicados. Ejecuta fases en orden correcto.

### Fases disponibles
| Fase | Qué ejecuta |
|---|---|
| `all` | audit + inbox + health |
| `audit` | file-arrival-guardian, struct-auditor, ghost-file-detector, cross-ref-checker |
| `inbox` | gestor-estados-inbox |
| `health` | repo-research |

### Uso
```bash
bash scripts/orquestador-unico.sh all
bash scripts/orquestador-unico.sh audit
bash scripts/orquestador-unico.sh inbox
bash scripts/orquestador-unico.sh health
```

### Salida
- `inbox/_meta/orquestador-YYYYMMDDTHHMMSS.md`

---

## `file-arrival-guardian.sh`

### Qué verifica
1. Archivos en carpetas prohibidas (legacy/duplicadas)
2. Archivos inesperados en raíz del repo
3. Archivos sin extensión `.sh` en `scripts/`
4. Archivos en `inbox/` sin clasificar >24h

### Uso
```bash
# Dry-run (no abre issues)
bash scripts/file-arrival-guardian.sh --dry-run

# Modo real (abre issue si hay errores)
bash scripts/file-arrival-guardian.sh
```

### Salida
- `inbox/_meta/arrival-report-YYYYMMDDTHHMMSS.md`

---

## Flujo completo de una sesión

```
1. git pull origin main
2. source scripts/session-logger.sh
3. [ TRABAJO: edits, scripts, commits... ]
4. bash scripts/orquestador-unico.sh audit
5. bash scripts/session-terminal-doc.sh "descripción"
6. git add inbox/sesiones/cierre-*.md
7. git commit + git push
8. GitHub Actions: session-close.yml mueve cierre → diarios/
                  file-arrival-guardian.yml valida estructura
```

---

## Reglas de estructura de carpetas

| Carpeta | Uso |
|---|---|
| `diarios/` | Destino final de documentos de sesión, con nombres fechados |
| `inbox/` | Espacio vivo de entrada; logs y cierres esperan clasificación |
| `inbox/_meta/` | Reportes de auditoría generados por scripts de control |
| `inbox/sesiones/` | Logs y cierres de sesión antes de moverlos a `diarios/` |
| `scripts/` | Solo `.sh` y servicios explícitos; binarios sueltos = error |
| `docs/` | Documentación del sistema y flujos |

---

## Hoja rápida de comandos

```bash
# INICIO
git pull origin main
source scripts/session-logger.sh

# TRABAJO
bash scripts/orquestador-unico.sh audit

# CIERRE
bash scripts/session-terminal-doc.sh "descripcion"
git add inbox/sesiones/cierre-*.md
git commit -m "docs(sesion): cierre YYYY-MM-DD — descripcion"
git push origin main
```

---

## Historial

| Fecha | Evento |
|---|---|
| 2026-07-04 | Creación del sistema: session-logger, session-terminal-doc, orquestador-unico |
| 2026-07-04 | Limpieza estructural repo: 6 errores guardian resueltos |
| 2026-07-04 | Este documento creado y commiteado en `docs/` |
