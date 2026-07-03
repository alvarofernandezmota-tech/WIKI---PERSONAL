# Sesión: cierre-sesion.sh — Gaps y v2 completo
**Fecha:** 2026-07-03 22:22 CEST
**Tipo:** deuda-técnica + mejora-script

---

## Estado actual del script

`scripts/cierre-sesion.sh` **existe y funciona** pero tiene estos gaps:

| Gap | Descripción |
|-----|-------------|
| ❌ No dispara GitHub Action | No hace `gh workflow run` para auditoría post-cierre |
| ❌ Ruta mantenimiento rota | Llama a `scripts/maintenance/inbox-audit-cleanup.sh` que puede no existir |
| ❌ No verifica MCP server | No comprueba si `node server.js` está corriendo |
| ❌ Dos scripts de inicio | `apertura-sesion.sh` e `inicio-sesion.sh` duplicados — deuda técnica |
| ❌ No escribe en inbox | El cierre genera diary pero no escribe en inbox/ según normas |

---

## Comando para usar AHORA (sin instalar nada)

```bash
cd /srv/yggdrasil-dew && bash scripts/cierre-sesion.sh
```

Si da error por la ruta de mantenimiento, usar:
```bash
cd /srv/yggdrasil-dew
git add -A
git commit -m "chore(session): cierre manual $(date +%Y-%m-%d) $(date +%H:%M)"
git push
```

---

## Mejoras para v2 (pendiente implementar en Madre)

- [ ] Añadir `gh workflow run ecosystem-guardian.yml` al final del cierre
- [ ] Fusionar `apertura-sesion.sh` + `inicio-sesion.sh` en uno solo
- [ ] Añadir check de MCP server al cierre
- [ ] Escribir nota de cierre también en `inbox/` además de `diary/`

---

*Creado por Perplexity + MCP — pendiente mover a docs/deuda-tecnica/*
