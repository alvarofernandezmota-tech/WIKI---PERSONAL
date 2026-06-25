---
tags: [env, variables, secretos, madre, configuracion]
fecha: 2026-06-25
estado: creado
---

# Variables de entorno Madre — .env

> ⚠️ El archivo .env está en ~/.env en Madre y en .gitignore.
> NUNCA commitear valores reales.
> Este archivo documenta la ESTRUCTURA, no los valores.

## Estado

| Variable | Estado | Notas |
|---|---|---|
| N8N_ENCRYPTION_KEY | ✅ generada | 25 jun — openssl rand -hex 32 |
| LITELLM_MASTER_KEY | ✅ generada | 25 jun — openssl rand -hex 32 |
| CODE_SERVER_PASSWORD | ⚠️ placeholder | cambiar `cambiar_esto` por valor real |
| CODE_SERVER_SUDO | ⚠️ placeholder | cambiar `cambiar_esto` por valor real |
| TELEGRAM_BOT_TOKEN | ❌ vacío | rellenar con token del bot THDORA |
| TELEGRAM_USER_ID | ❌ vacío | rellenar con tu ID numérico de Telegram |

## Cómo obtener TELEGRAM_USER_ID

```
1. Abre Telegram
2. Busca el bot @userinfobot
3. Escribe /start
4. Te responde con tu ID numérico
```

## Estructura del archivo ~/.env en Madre

```env
N8N_ENCRYPTION_KEY=<32-bytes-hex>
CODE_SERVER_PASSWORD=<contraseña-segura>
CODE_SERVER_SUDO=<contraseña-segura>
LITELLM_MASTER_KEY=<32-bytes-hex>
TELEGRAM_BOT_TOKEN=<token-del-bot>
TELEGRAM_USER_ID=<tu-id-numerico>
```

## Regenerar una key

```bash
openssl rand -hex 32
```

## Verificar que el .env existe en Madre

```bash
ssh madre "cat ~/.env"
```

## Cómo lo usan los docker-compose

Los YMLs de las fases usan `${VARIABLE:-default}` — Docker Compose
carga automáticamente el .env del directorio de trabajo o del home.

Para asegurarse de que lo carga:
```bash
ssh madre "cd ~/yggdrasil-dew && set -a && source ~/.env && set +a && \
  docker compose -f setup/servidor/batcueva-fase3.yml up -d"
```

---
_Actualizado: 25 jun 2026 13:19 CEST_
