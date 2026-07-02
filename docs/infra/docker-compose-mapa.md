---
tags: [infra, docker, compose, madre, varopc]
fecha-creacion: 2026-07-01
ultima-actualizacion: 2026-07-02
---

# 🐳 Mapa Docker Compose — varopc (madre)

> Auditoría de todos los ficheros docker-compose.yml encontrados en el filesystem de madre.
> Fecha auditoría: 01-jul-2026 01:10 CEST

## Ficheros encontrados (11 total)

| Ruta | Estado | Notas |
|---|---|---|
| `~/docker-compose.yml` | ✅ **ACTIVO** | Compose principal — 4 servicios IA |
| `~/Projects/thdora/docker/docker-compose.yml` | 🔧 proyecto | THDORA principal |
| `~/Projects/thdora/docker-compose.yml` | ⚠️ alt | THDORA alternativo |
| `~/spiderfoot/docker-compose.yml` | ✅ activo | SpiderFoot OSINT |
| `~/docker/batcueva-nueva/docker-compose.yml` | 🗑️ obsoleto | Borrador viejo 686B |
| `~/Obsidian/cerebro/tecnico/setup/servidor/docker-compose.yml` | 📦 archivo | Obsidian setup |
| `~/yggdrasil-dew/setup/servidor/docker-compose.yml` | 📦 archivo | Setup inicial |
| `~/yggdrasil-dew/docker/docker-compose.batcueva.yml` | 🔧 planificado | Batcueva planificado |
| `~/yggdrasil-dew/osint-stack/docker-compose.kali.yml` | 🔧 corregido | Kali Desktop |

## Problema detectado: divergencia real vs repo

> **Regla 14** ([[CONVENCIONES]]): El compose en repo refleja el estado real de producción.
> Si hay divergencia → actualizar repo, no el servidor.

El `~/docker-compose.yml` activo tenía 4 servicios reales vs lo planificado en repo.
Corregido y sincronizado el 01-jul-2026.

## Pendiente
- [ ] Reorganizar filesystem varopc — todos los composes activos a `~/docker/`
- [ ] Eliminar `batcueva-nueva/docker-compose.yml` obsoleto
- [ ] Sincronizar todos los composes activos con sus repos correspondientes

## Ver también
- [[docs/infra/procedimientos/madre-arranque]]
- [[ESTADO-SISTEMA]]

---
_Creado desde inbox 2026-07-01 — Perplexity vía MCP_
