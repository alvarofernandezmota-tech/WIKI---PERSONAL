---
tipo: indice
fecha: 2026-06-25
tags: [scripts, automatizacion, indice]
---

# 📜 Scripts

Scripts de automatización y mantenimiento del ecosistema.

## Ficheros

| Script | Propósito | Cuándo ejecutar |
|---|---|---|
| [inbox-cleanup-jun2024.sh](./inbox-cleanup-jun2024.sh) | Migra ~85 ficheros de inbox/ al PKM estructurado | Con madre operativa, en terminal |

## Uso rápido

```bash
# Desde la raíz del repo
chmod +x scripts/inbox-cleanup-jun2024.sh
bash scripts/inbox-cleanup-jun2024.sh
```

> ⚠️ El script crea su propia rama (`chore/inbox-cleanup-jun2024`) y hace push.
> Después abre el PR en GitHub para revisar antes de mergear a main.
