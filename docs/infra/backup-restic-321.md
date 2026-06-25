---
tags: [backup, restic, 3-2-1, disaster-recovery, infra]
fecha: 2026-06-25
---

# Backup Restic 3-2-1 — Batcueva

## Arquitectura

Regla **3-2-1**: 3 copias · 2 soportes distintos · 1 offsite.

| Destino | Tipo | Dónde | Frecuencia |
|---|---|---|---|
| **A — Local** | HDD interno | `/mnt/backup/restic` en Madre | Diario 03:00 |
| **B — SFTP** | Red local | varopc `/backup/restic-madre` | Diario 03:00 |
| **C — B2** | Cloud offsite | Backblaze B2 `batcueva-backup` | Diario 03:00 |

Check de integridad: **domingos 04:00** (verifica 5% aleatorio de datos).

---

## Qué se hace backup

```
/home/varopc/yggdrasil-dew    ← segundo cerebro completo
/home/varopc/.config           ← configuraciones apps
/home/varopc/.ssh              ← claves SSH
```

Excluidos: `.git`, `*.apk`, `*.iso`, `node_modules`, `__pycache__`.

---

## Instalación (una vez)

```bash
# En Madre como root:
sudo bash scripts/backup/install-restic.sh
```

Esto:
1. Instala `restic` y lo actualiza a última versión
2. Crea `/mnt/backup/restic`, `/etc/restic/`, `/var/log/restic/`
3. Genera password cifrado en `/etc/restic/password`
4. Instala crons automáticos

---

## Variables en `.env`

```bash
RESTC_REPO_LOCAL=/mnt/backup/restic
RESTC_REPO_SFTP=sftp:varopc@192.168.1.100:/backup/restic-madre
RESTC_REPO_B2=b2:batcueva-backup:/restic
B2_ACCOUNT_ID=xxxxxxxxx
B2_ACCOUNT_KEY=xxxxxxxxx
```

> ⚠️ Nunca subir el `.env` al repo. Está en `.gitignore`.

---

## Uso manual

```bash
# Backup completo 3-2-1
./scripts/backup/run-backup.sh all

# Solo un destino
./scripts/backup/run-backup.sh local
./scripts/backup/run-backup.sh sftp
./scripts/backup/run-backup.sh b2

# Ver snapshots
restic -r /mnt/backup/restic --password-file /etc/restic/password snapshots

# Restaurar fichero concreto
restic -r /mnt/backup/restic --password-file /etc/restic/password \
  restore latest --target /tmp/restore --include /home/varopc/yggdrasil-dew/MASTER-PENDIENTES.md

# Verificar integridad
./scripts/backup/check-backup.sh all
```

---

## Configurar Backblaze B2

1. Crear cuenta en [backblaze.com](https://www.backblaze.com)
2. Crear bucket: `batcueva-backup` (privado)
3. Crear App Key con permisos solo para ese bucket
4. Añadir `B2_ACCOUNT_ID` y `B2_ACCOUNT_KEY` al `.env`
5. Ejecutar: `./run-backup.sh b2`

Coste aproximado: **~0€/mes** para menos de 10GB (tier gratuito B2).

---

## Configurar SFTP en varopc

```bash
# En varopc:
mkdir -p /backup/restic-madre
chmod 700 /backup/restic-madre
```

Asegúrate de que `~/.ssh/config` en Madre tenga `Host varopc` configurado sin contraseña.

---

## Próximos pasos

- [ ] Integrar alerta THDORA cuando falle un backup
- [ ] Añadir voluménes Docker a las fuentes (`/var/lib/docker/volumes`)
- [ ] Considerar backup de Gitea y n8n exports

---
_Creado: 25 jun 2026 — Perplexity vía MCP_
