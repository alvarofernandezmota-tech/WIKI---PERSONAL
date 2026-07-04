# Diario sesión — 27 junio 2026 (madrugada 03:00–04:18)
#diario #sesion #infra #seguridad #madrugada

**Inicio:** 03:00 CEST
**Fin:** 04:18 CEST
**Duración:** ~1h 20min
**Contexto:** Fuera de casa, trabajo desde móvil vía Perplexity + GitHub MCP

---

## Qué se hizo

### Problema resuelto: MadreAP WiFi
El punto de acceso WiFi de Madre (hostapd) no arrancaba de forma persistente tras reboot. Se identificó conflicto con `iwd`, se desactivó, se configuraron reglas UFW para wlan0 (DHCP port 67, IP forward) y se verificó que Acer (theodora) conecta y tiene internet.

### Documentación e inbox
- 3 ficheros de inbox migrados a `docs/` y `diarios/`
- `ESTADO-SISTEMA.md` actualizado
- `docs/infra/red-madre-ap.md` creado como referencia permanente
- `ADR-004` creado: seguridad privilege explosion

### Plan estratégico
- Orden óptimo confirmado: seguridad red → scripts → monitorización → Docker
- `PLAN-SEGURIDAD-Y-DESPLIEGUE.md` ya existía y está al día con 9 fases
- Investigación SOC homelab stack (7 capas) documentada en inbox
- Prompt Gemini generado con contexto completo para generar scripts en casa

---

## Decisiones tomadas

1. **No levantar Docker hasta tener UFW + SSH hardening aplicados**
2. **Primero ver el entorno, luego cerrar superficie, luego construir encima** (filosofía SOC)
3. **Gemini para generar los scripts** → ejecutar en Madre en la próxima sesión
4. **Todo pasa por yggdrasil-dew** — es la fuente única de verdad

---

## Estado al cerrar sesión

| Item | Estado |
|---|---|
| MadreAP WiFi | ✅ Resuelto y persistente |
| Inbox | ✅ Vaciada |
| Documentación repo | ✅ Al día |
| Investigación SOC stack | ✅ Documentada |
| Prompt Gemini | ✅ Listo |
| UFW Fase 1 | ⏳ Pendiente — en casa |
| SSH hardening | ⏳ Pendiente — en casa |
| Scripts Gemini | ⏳ Pendiente — en casa |

---

## Próxima sesión (en casa)

1. `git pull --rebase` en Madre
2. Pegar prompt en Gemini → obtener scripts
3. Ejecutar `instalar-dependencias.sh`
4. Ejecutar `ufw-completo.sh` y verificar
5. Ejecutar `ssh-hardening.sh` y verificar
6. Reboot Madre y verificar que todo sigue activo
7. Levantar stack Docker con `start-batcueva.sh`
8. Configurar dashboards Grafana
9. Activar alertas Uptime Kuma → THDORA → Telegram

---

*Batcueva homelab — 2026-06-27 04:18 CEST*
