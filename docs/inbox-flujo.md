# Flujo inbox — de terminal a destino final

## Zona de aterrizaje

Todos los archivos nuevos llegan a `inbox/drop/`. Desde ahí el ecosistema los lleva a su destino.

```
inbox/drop/          ← TÚ dejas aquí los archivos
inbox/sesiones/      ← logs y cierres de sesión
inbox/docs/          ← documentación genérica
inbox/code/          ← scripts .py y código
inbox/logs/          ← logs .log
inbox/misc/          ← cualquier otra cosa
diarios/             ← documentos con fecha (YYYY-MM-DD en nombre)
```

## Comandos de uso diario

### 1. Meter un archivo y commitear
```bash
cp /tu/archivo.md ~/yggdrasil-dew/inbox/drop/
bash scripts/inbox-commit.sh "descripción breve"
```

### 2. Ver a dónde iría sin mover nada
```bash
bash scripts/inbox-clasificador.sh --dry-run
```

### 3. Clasificar manualmente sin esperar Actions
```bash
bash scripts/inbox-clasificador.sh
git add -A && git commit -m "inbox: clasificación manual" && git push
```

### 4. Ejecutar auditoría completa
```bash
bash scripts/orquestador-unico.sh all
```

## Reglas de clasificación automática

| Patrón de nombre / extensión        | Destino               |
|-------------------------------------|-----------------------|
| `*sesion*`, `*cierre*`, `log-*` .md | `inbox/sesiones/`     |
| `*diario*` o fecha `YYYY-MM-DD` .md | `diarios/`            |
| cualquier otro `.md`                | `inbox/docs/`         |
| `.py`                               | `inbox/code/`         |
| `.log`                              | `inbox/logs/`         |
| `.sh`                               | ⚠️ aviso manual, no se mueve automáticamente |
| resto                               | `inbox/misc/`         |

## Flujo completo de una sesión

```bash
# Inicio
git pull origin main
source scripts/session-logger.sh

# Trabajo normal...

# Cierre
bash scripts/session-logger.sh --close
bash scripts/session-terminal-doc.sh "descripción de la sesión"
git add inbox/sesiones/
git commit -m "docs(sesion): cierre $(date +%Y-%m-%d)"
git push origin main
# → GitHub Actions clasifica y mueve a diarios/ automáticamente
```

---
*Documentado el $(date +%Y-%m-%d) — ecosistema yggdrasil-dew*
