# scripts/thdora-dev/

Scripts ejecutados por **Thdora Dev** — automatización de repos y gestión de conocimiento.

## Scripts disponibles

| Script | Función | Cron |
|---|---|---|
| `inbox_migrate.py` | Migra `inbox/` → `docs/` clasificando por tipo | `0 6 * * *` |

## Uso manual

```bash
# Ver qué haría sin ejecutar nada
python3 scripts/thdora-dev/inbox_migrate.py --dry-run

# Migrar sin hacer commit
python3 scripts/thdora-dev/inbox_migrate.py

# Migrar + git commit + push automático
python3 scripts/thdora-dev/inbox_migrate.py --commit
```

## Configurar cron en Madre

```bash
crontab -e
# Añadir:
0 6 * * * cd /ruta/yggdrasil-dew && python3 scripts/thdora-dev/inbox_migrate.py --commit >> /var/log/thdora-dev-inbox.log 2>&1
```

## Ver docs de Thdora

→ [`docs/herramientas/thdora.md`](../../docs/herramientas/thdora.md)
