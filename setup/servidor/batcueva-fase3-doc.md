---
tags: [setup, fase3, n8n, gitea, code-server, headscale, automatizacion]
fecha: 2026-06-24
estado: listo-para-ejecutar
---

# Batcueva Fase 3 — Automatización + Dev remoto + VPN propia

> Requiere Fases 1 y 2 activas y estables.

---

## Servicios

| Servicio | Puerto | Para qué |
|---|---|---|
| n8n | :5678 | Automatización workflows — Telegram, Git, Ollama, alertas |
| Gitea | :3003 | GitHub self-hosted — repos privados sin depender de GitHub |
| Code Server | :8443 | VSCode en el browser — editar código desde cualquier sitio |
| Headscale | :8085 | VPN propia (reemplaza Tailscale cloud) |

---

## Ejecutar

```bash
# 1. Descargar imágenes
bash setup/servidor/scripts/descarga-fase3.sh

# 2. Levantar y configurar
bash setup/servidor/scripts/configurar-fase3.sh

# 3. Verificar
docker compose -f setup/servidor/batcueva-fase3.yml ps
```

---

## n8n — Workflows del ecosistema

### Workflow 1: Diario automático
```
Cada noche a las 23:00:
→ n8n pregunta a Ollama "resume el día"
→ Escribe diario en yggdrasil-dew/diarios/
→ Git commit automático
→ Notifica a Telegram
```

### Workflow 2: Monitor de servicios
```
Cada 5 min:
→ Ping a todos los servicios del stack
→ Si alguno cae → Telegram alert
→ Intento de reinicio automático
```

### Workflow 3: Inbox processor
```
Cuando llega mensaje a Telegram:
→ Clasifica con Ollama
→ Crea fichero en inbox/ de yggdrasil-dew
→ Git push
```

---

## Gitea — Mirror de yggdrasil-dew

```bash
# Tras levantar Gitea (http://IP:3003):
# 1. Registrar usuario admin
# 2. Crear org: alvarofernandezmota-tech
# 3. Mirror desde GitHub:
git clone --mirror https://github.com/alvarofernandezmota-tech/yggdrasil-dew.git
cd yggdrasil-dew.git
git remote set-url --push origin http://localhost:3003/alvarofernandezmota-tech/yggdrasil-dew.git
git push --mirror
```

---

## Code Server — Variables de entorno

Editar `.env` antes de levantar:
```bash
CODE_SERVER_PASSWORD=tu_password_segura
CODE_SERVER_SUDO=tu_sudo_password
```

Acceder: http://IP:8443 → workspace `/cerebro` = yggdrasil-dew montado.

---

## Headscale — Migrar desde Tailscale

```bash
# Tras levantar headscale:
docker exec headscale headscale namespaces create alvaro

# Obtener authkey:
docker exec headscale headscale preauthkeys create \
  --namespace alvaro --reusable --expiration 999d

# En cada nodo (varopc, Madre, Acer):
sudo tailscale down
sudo tailscale up --login-server=http://IP_MADRE:8085 --authkey=KEY
```

---

## Verificación final

```bash
docker compose -f setup/servidor/batcueva-fase3.yml ps
curl -s http://localhost:5678  # n8n
curl -s http://localhost:3003  # Gitea
sudo ufw status | grep -E '5678|3003|8443|8085'
```

---
_Ver: [[batcueva-fase2-doc]] · [[batcueva-fase4]] · [[n8n-litellm-integracion]]_
