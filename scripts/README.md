# ⚙️ Scripts — Batcueva / Madre

> Scripts de setup y mantenimiento. Ejecutar en Madre en el orden indicado.

## Orden de ejecución — Fases 1 y 2

```
01 → 02 → 03 → REBOOT → 06 → 04 → 05
```

| Script | Fase | Qué hace | Req |
|---|---|---|---|
| `01-fix-driver-rtl8188ftu.sh` | Pre | Fix driver AP inestable RTL8188FTV | — |
| `02-git-pull-rebase.sh` | 0 | Sync repo yggdrasil-dew en Madre | — |
| `03-fase1-seguridad.sh` | 1 | SSH hardening + UFW + Tailscale enable + no-sleep → **REBOOT** | claves SSH |
| `06-verificacion-post-reboot.sh` | 1 | Verificación completa post-reboot | Fase 1 |
| `04-fase2-start-batcueva.sh` | 2 | Crea `start-batcueva.sh` y lo sube al repo | Fase 1 |
| `05-fase7-ollama-pull.sh` | 7 | Pull llama3.1:8b + bge-m3 + nomic-embed-text | Ollama up |

## ⚠️ Importante antes de ejecutar `03`

Verifica que tienes clave SSH en `~/.ssh/authorized_keys`:
```bash
cat ~/.ssh/authorized_keys
```
Si está vacío:
```bash
# Desde el Acer:
ssh-copy-id -i ~/.ssh/id_rsa.pub varopc@100.91.112.32
```

## Ejecución rápida desde Madre

```bash
cd ~/yggdrasil-dew/scripts
bash 01-fix-driver-rtl8188ftu.sh
bash 02-git-pull-rebase.sh
bash 03-fase1-seguridad.sh
# → reboot
bash 06-verificacion-post-reboot.sh
bash 04-fase2-start-batcueva.sh
bash 05-fase7-ollama-pull.sh
```

---
_Ver: [[PLAN-SEGURIDAD-Y-DESPLIEGUE]] · [[ROADMAP]] · [[MASTER-PENDIENTES]]_
