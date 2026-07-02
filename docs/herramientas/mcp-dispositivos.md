---
tags: [herramientas, mcp, perplexity, dispositivos]
fecha-actualizacion: 2026-07-02
---

# 📱 MCP — Acceso desde dispositivos

## Cómo funciona el MCP por dispositivo

El MCP de GitHub está configurado en **Perplexity como plataforma**, ligado a tu cuenta de usuario. No está ligado al dispositivo ni al navegador.

| Dispositivo | MCP disponible | Condición |
|---|---|---|
| iPhone (Perplexity app/web) | ✅ Sí | Sesión iniciada con tu cuenta |
| Acer — Perplexity web | ✅ Sí | Sesión iniciada con tu cuenta |
| Acer — terminal | ❌ No | Necesita `gh` CLI + token configurado |
| Cualquier navegador | ✅ Sí | Solo sesión Perplexity activa |

## Qué se puede hacer desde móvil (sin terminal)

✅ Todo lo que sea documentación, commits, issues, PRs, leer ficheros — **se hace aquí desde Perplexity**.

❌ Lo que requiere terminal físico en Madre (ejecutar cuando estés en Acer con SSH):
- SSH hardening (ssh-keygen + ssh-copy-id)
- Levantar stack batcueva (`start-batcueva.sh`)
- Wazuh prereq (`sysctl`)
- Labels GitHub (si se usa `gh` CLI — también se pueden crear en la UI web)
- Instalar paquetes (`pacman`)

## Configurar MCP en Acer (cuando toque)

Cuando estés en Acer, para tener `gh` CLI con acceso al repo:
```bash
# Instalar gh CLI
sudo pacman -S github-cli

# Autenticar
gh auth login
# → elegir GitHub.com → HTTPS → autenticar con browser

# Verificar
gh repo view alvarofernandezmota-tech/yggdrasil-dew
```

Pero para el MCP de Perplexity no hace falta nada en Acer — basta con abrir Perplexity en el navegador del Acer con tu sesión.

---
_Documentado: 02-jul-2026 — sesión desde iPhone 11 — Perplexity vía MCP_
