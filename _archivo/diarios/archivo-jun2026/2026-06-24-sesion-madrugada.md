---
tags: [sesion, batcueva, ecosistema, arquitectura, thdora, personal, infraestructura]
fecha: 2026-06-24
estado: pendiente-ejecutar
ruta: yggdrasil-dew/inbox/2026-06-24-sesion-madrugada.md
relacionado:
  - "[[yggdrasil-dew/ESTADO-SISTEMA]]"
  - "[[yggdrasil-dew/ROADMAP]]"
  - "[[yggdrasil-dew/ECOSISTEMA]]"
  - "[[personal/inbox/2026-06-24-ecosistema-vision]]"
  - "[[personal/inbox/2026-06-24-batcueva-pre-descarga]]"
  - "[[personal/inbox/2026-06-24-auditoria-repo-personal]]"
  - "[[personal/inbox/2026-06-24-arquitectura-thdora-bots]]"
---

# Sesión madrugada — 2026-06-24

> Sesión técnica intensa ~01:00-04:30 CEST. Todo documentado y enlazado.

---

## Lo que se ha hecho

### Pre-descarga batcueva — COMPLETADA
- Resuelto `smicallef/spiderfoot` → imagen inexistente, eliminada del script
- **Todas las fases descargadas** en madre:
  - Fase 1: `ollama/ollama`, `open-webui`, `qdrant` ✅
  - Fase 2: `portainer`, `uptime-kuma`, `heimdall` ✅
  - Fase 3: `n8n`, `code-server`, `homarr`, `gitea` ✅
  - Fase 4: `litellm`, `paperless-ngx`, `vaultwarden`, `watchtower`, `nginx-proxy-manager`, `redis`, `postgres` ✅
- Script: `setup/servidor/scripts/pre-descarga-todo.sh`

### Repos clonados en madre
```
~/Obsidian/cerebro/personal/    ← repo personal
~/Obsidian/cerebro/tecnico/     ← repo yggdrasil-dew
```

### Decisiones de arquitectura tomadas
- Mapa de repos definitivo definido — ver `[[personal/inbox/2026-06-24-ecosistema-vision]]`
- `cerebro` = hub Obsidian que navega `personal` + `yggdrasil-dew`, no un repo de contenido
- Cada fase Docker que se monte pasará a ser **repo independiente** con su propia estructura e inbox
- Todas las repos seguirán la misma estructura y convenciones que ésta

---

## Mapa de repos del ecosistema

| Repo | Naturaleza | Estado |
|------|-----------|--------|
| `personal` | Vida personal — diario, metas, reflexiones | ✅ Activo |
| `yggdrasil-dew` | Sistema técnico — orquestador del ecosistema | ✅ Activo |
| `thdora` | Factoría de bots y agentes — proyecto independiente | ✅ Activo |
| `batcueva-bot` (futuro) | Bot específico del ecosistema doméstico | ⏳ Pendiente nombre |
| `cerebro` (futuro) | Hub navegación Obsidian | ⏳ Pendiente crear |
| repos por fase (futuro) | Cada fase Docker tendrá su repo | ⏳ Cuando estén montadas |

---

## Pendientes técnicos

- [ ] Levantar Fase 1 — `docker compose up` (ollama + open-webui + qdrant)
- [ ] Drivers NVIDIA en madre para GPU con ollama
- [ ] Paquetes Arch/AUR setup madre
- [ ] Descargar modelos ollama una vez contenedor activo
- [ ] Descargar `litellm` con WiFi estable (ya se descargó esta noche ✅)
- [ ] Auditoría y limpieza repo `personal` — ver `[[personal/inbox/2026-06-24-auditoria-repo-personal]]`
- [ ] Crear `HOME.md` en `personal` igual que el de aquí
- [ ] Crear repos independientes por fase cuando estén montadas

---

## Filosofía del ecosistema

Cada capa que se monta es un multiplicador:
- **Infraestructura** (madre + Docker) — base sólida, privada y local
- **IA local** (ollama + qdrant) — inteligencia sin depender de APIs externas
- **Automatización** (n8n + agentes) — las tareas repetitivas desaparecen
- **Conocimiento** (cerebro + obsidian) — todo documentado, buscable, conectado
- **Seguridad** (vaultwarden + nginx + watchtower) — el ecosistema se protege solo

El conocimiento no necesita estar centralizado físicamente — necesita estar bien documentado y enlazado. Los repos son la fuente de verdad, cerebro es el mapa.

Ver también: `[[yggdrasil-dew/filosofia]]`
