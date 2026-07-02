---
tags: [herramientas, chromium, perplexity, conectores]
fecha-actualizacion: 2026-07-02
estado: en-proceso
---

# 🌐 Chromium + Perplexity — Conectores no persisten

## Estado
🔴 **EN PROCESO** — 02-jul-2026

## Problema
En Perplexity web con Chromium 148 (Arch Linux), los conectores (GitHub, Google Drive, Web) **no se guardan entre mensajes** — hay que reconectarlos en cada nueva consulta.

## Datos recogidos

| Variable | Valor |
|---|---|
| Chromium | 148.0.7778.178 Arch Linux |
| Modo incógnito | Sigue fallando |
| Móvil | ✅ Funciona correctamente |
| `--disable-extensions` | No resuelve |

## Hipótesis activa
🎯 Chromium 148 tiene cambios de manejo de cookies/SameSite/storage que rompen el handshake OAuth de los conectores de Perplexity. El hecho de que móvil funcione descarta problema de cuenta o plan.

## Pendiente de verificar
- [ ] Probar en **Firefox** — aislar si es Chromium-específico
- [ ] Probar **Brave** como alternativa
- [ ] Instalar **Comet** (navegador Perplexity, basado en Chromium) — Linux disponible
- [ ] Crear perfil limpio en Chromium (`chrome://settings/manageProfile`)
- [ ] Revisar si VPN activa rompe OAuth de conectores
- [ ] `chrome://flags` → Reset all

## Alternativas si Firefox no resuelve
- **Comet**: navegador oficial Perplexity, gestiona sesión propia
- **AUR**: buscar `perplexity` o `perplexity-ai`
- **Flatpak**: buscar en Flathub

## Workaround actual
Usar Perplexity desde **móvil** para consultas que requieran conectores activos mientras se investiga el fix en desktop.

---
_Documentado: 02-jul-2026 — Perplexity vía MCP_
