---
tipo: doc
author: Perplexity-MCP <alvarofernandezmota@gmail.com>
creado: 2026-07-03 01:10 CEST
actualizado: 2026-07-03 01:10 CEST
ruta: docs/operativa/iphone-terminal-comparativa.md
tags: [iphone, terminal, ssh, ios, operativa]
status: vigente
---

# Terminales iOS — Comparativa 2026

> Investigación propia para elegir la mejor terminal SSH en iPhone
> para operar Madre/Thdora desde cualquier lugar vía Tailscale.

---

## Criterios de evaluación

1. **SSH funcional** — conexión a Madre por Tailscale
2. **Sesiones persistentes** — no morir si el iPhone bloquea pantalla
3. **Soberanía** — sin cloud sync a servidores externos
4. **Scripts** — poder lanzar `.sh` remotos
5. **Gratis o precio justo** — sin suscripción obligatoria
6. **Teclado** — teclas especiales (ESC, Tab, Ctrl+C) accesibles

---

## Comparativa

| App | SSH | Shell local | tmux | Precio | Stars | Soberanía |
|---|---|---|---|---|---|---|
| **Secure ShellFish** | ✅ nativo | ❌ | ✅ | Gratis + Pro €4.99 | ⭐4.8 | ✅ |
| **a-Shell** | ❌ directo | ✅ completa | ❌ | Gratis | ⭐4.6 | ✅ |
| **iSH Shell** | ❌ directo | ✅ Linux emu | ❌ | Gratis | ⭐4.7 | ✅ |
| **Termius** | ✅ nativo | ❌ | ✅ | Freemium cloud | ⭐4.5 | ⚠️ cloud |
| **xTerminal** | ✅ nativo | ❌ | ❌ | Freemium | ⭐4.7 | ⚠️ parcial |
| **Termix** | ✅ nativo | ❌ | ❌ | Gratis (beta) | ⭐4.2 | ✅ |

---

## Análisis por app

### 🥇 Secure ShellFish (SSH Files) — GANADORA

**Por qué gana:**
- Mejor valorada del mercado (4.8/5)
- Integración nativa con Files.app — puedes arrastrar scripts directamente
- Soporte tmux nativo — sesiones que sobreviven al bloqueo de pantalla
- Handoff: empiezas sesión en iPhone y la continuas en Mac/iPad
- Sin cloud sync — todo local, compatible con Tailscale
- Gratis para uso SSH básico (ilimitado con Pro €4.99/único)

**Limitaciones:**
- Sin shell local (pero no la necesitamos, tenemos Madre)
- Pro necesario para upload directo desde Files.app

**Caso de uso con nuestro ecosistema:**
```
iPhone → Tailscale → Secure ShellFish SSH → Madre
                                                └→ tmux (sesión persistente)
                                                    └→ scripts/maintenance/*.sh
```

---

### 🥈 a-Shell — SEGUNDA (complementaria)

**Por qué es segunda:**
- Terminal local COMPLETA en iPhone: Python, Git, vim, grep, sed...
- Compila C/C++ a WebAssembly y lo ejecuta
- Integración con iOS Shortcuts — automatizar tareas desde iPhone
- Completamente gratis y open source

**Limitaciones:**
- No tiene SSH nativo — necesitas `ssh` command que funciona vía ngrok/keys
- Menos pulida para SSH puro que ShellFish

**Caso de uso:**
- Editar ficheros `.md` locales
- Correr scripts Python localmente
- Git push desde iPhone (con claves configuradas)

---

### ❌ Termius — DESCARTADA

**Por qué se descarta:**
- Sync en sus servidores cloud — contra filosofía de soberanía del ecosistema
- El tier gratis es muy limitado (1 host, sin snippets, sin SFTP)
- Suscripción mensual para las features que realmente importan
- Mismo problema que Perplexity Teams vs local: datos fuera de tu control

---

### ⚠️ iSH Shell — DESCARTADA para SSH

- Emulación x86 sobre ARM — muy lenta
- Buena para aprender Linux en iPhone, no para operar homelab
- Sin SSH nativo funcional hacia servers externos con facilidad

---

## Decisión final

**Instalar ambas:**

| App | Rol |
|---|---|
| Secure ShellFish | SSH principal a Madre/Thdora vía Tailscale |
| a-Shell | Shell local, Git, scripts Python en iPhone |

---

## Setup paso a paso

Ver: `docs/operativa/iphone-terminal.md`
