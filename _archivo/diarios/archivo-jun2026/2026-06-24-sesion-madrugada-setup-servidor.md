# Sesión Madrugada — 24 junio 2026 (~02:30–02:45 CEST)

> Agente: Perplexity (Space: Repo Personal)
> Estado: Madre descargando imágenes en background

---

## Contexto de entrada

Al inicio de sesión se detectó que el usuario estaba pegando texto en la terminal en lugar de ejecutar comandos. Causa: confusión entre ventana de chat y terminal. Resuelto.

---

## Auditoría `setup/servidor/` — Estado verificado

Estructura revisada y confirmada como correcta y completa:

| Fichero | Estado |
|---|---|
| `docker-compose.yml` | ✅ Fase 1 — Ollama + Open WebUI + Qdrant |
| `batcueva-fase2.yml` | ✅ Fase 2 — Grafana + Prometheus + Portainer |
| `batcueva-fase3.yml` | ✅ Fase 3 — n8n + Paperless + Vaultwarden |
| `batcueva-fase2-doc.md` | ✅ Documentado |
| `batcueva-fase3-doc.md` | ✅ Documentado |
| `scripts/arranque-madre.sh` | ✅ Script maestro |
| `scripts/pre-descarga-todo.sh` | ✅ Pre-descarga todas las imágenes |
| `scripts/configurar-fase2.sh` | ✅ Config Fase 2 |
| `scripts/configurar-fase3.sh` | ✅ Config Fase 3 |
| `.env.plantilla` | ✅ Variables de entorno |

---

## Comparativa plan-maestro vs realidad hoy

| El repo decía (13 jun) | Realidad 24 jun |
|---|---|
| Activar sshd en Madre — pendiente | ✅ SSH operativo |
| Descargar modelos Ollama — pendiente | ✅ Descargando / descargado |
| Migrar THDORA a Madre — futuro | ✅ thdora corriendo :8000 |
| Uptime Kuma — configurar | ✅ healthy :3002 |
| Portainer — no mencionado | ✅ healthy :9000 |
| Open WebUI — futuro | ✅ descargando |
| personal-v2 como repo cerebro | ✅ migrado a yggdrasil-dew |

---

## Gaps identificados esta sesión

### ⚠️ Gap 1 — `batcueva-state.sh` no existe
Script idempotente que une todas las fases y lleva Madre al estado deseado desde cero. Es el fichero más importante que falta en `setup/servidor/scripts/`.

### ⚠️ Gap 2 — Fase 4 no tiene compose ejecutable
`inbox/2026-06-24-fase4-litellm-sops-plan.md` existe como plan detallado pero falta:
- `batcueva-fase4.yml`
- `scripts/pre-descarga-fase4.sh`
- `scripts/configurar-fase4.sh`
- `batcueva-fase4-doc.md`

### ⚠️ Gap 3 — `plan-maestro.md` desfasado
Está en `setup/servidor/plan-maestro.md` con fecha 13 jun. Debería moverse/actualizarse como `ESTADO-SISTEMA.md` en la raíz del repo para que cualquier IA lo encuentre en frío.

### ⚠️ Gap 4 — Script `cierre-sesion.sh` no existe
El flujo de cierre diario (resumen → inbox → git commit+push automático) está en el mapa como idea pero no implementado como script ejecutable.

### ⚠️ Gap 5 — Migración inbox → repo no automatizada
Los 60+ ficheros del inbox nunca se mueven a sus directorios definitivos. Esto es trabajo de agente (THDORA/n8n), no de bash. Pendiente para cuando THDORA esté estable en Madre.

---

## Decisiones tomadas esta sesión

1. **Madre descarga en background** — `pre-descarga-todo.sh` lanzado con `nohup`
2. **Orden de ataque documentación**: ESTADO-SISTEMA.md → cierre-sesion.sh → resumen sesión inbox
3. **Migración inbox→repo**: se delega a THDORA cuando esté operativo, no se hace con bash

---

## Próximos pasos inmediatos

- [ ] Ejecutar `pre-descarga-todo.sh` en Madre (comando dado al usuario)
- [ ] Crear `ESTADO-SISTEMA.md` en raíz del repo
- [ ] Crear `setup/servidor/scripts/cierre-sesion.sh`
- [ ] Crear `setup/servidor/scripts/batcueva-state.sh` idempotente
- [ ] Crear Fase 4: compose + scripts + doc

---

## Stack Madre — estado confirmado esta sesión

| Servicio | Puerto | Estado |
|---|---|---|
| THDORA | :8000 | ✅ running |
| Ollama | :11434 | ✅ running |
| Qdrant | :6333 | ✅ running |
| Open WebUI | :3001 | descargando |
| Portainer | :9000 | ✅ healthy |
| Grafana | :3000 | ✅ healthy |
| Uptime Kuma | :3002 | ✅ healthy |
| Prometheus | :9090 | ✅ healthy |
| n8n | :5678 | pendiente Fase 3 |
| Paperless | :8010 | pendiente Fase 3 |
| Vaultwarden | :8888 | pendiente Fase 3 |
| LiteLLM | :4000 | pendiente Fase 4 |

---

_Siguiente sesión: verificar log de descarga → levantar Fase 2 → Fase 3 → batcueva-state.sh_
