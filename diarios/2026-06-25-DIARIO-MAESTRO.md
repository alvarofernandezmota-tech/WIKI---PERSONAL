# 🗓️ Diario Maestro — 2026-06-25 (Jueves)

## Estado del día
- **Sesión activa:** 11:41 CEST
- **Prioridad:** Descargas modelos pendientes + virtualización + hotspot permanente + móvil

---

## 🔥 Pendientes críticos (heredados del día 24)

### 1. 📥 Descargas de modelos (las 5 que faltaron)
Referencia: `inbox/2026-06-24-DESCARGAS-COMPLETAS-06h10.md`
- [ ] Verificar qué modelos descargaron correctamente
- [ ] Relanzar los que fallaron con `ollama pull <modelo>`
- [ ] Documentar estado en `ollama/modelos-estado.md`

### 2. 💻 Virtualización (Kali Linux sandbox)
Referencia: `inbox/2026-06-24-fase4-litellm-sops-plan.md`
- [ ] Descargar ISO Kali (UUP o sitio oficial)
- [ ] Crear VM en Proxmox/VirtualBox
- [ ] Red aislada para pentesting lab
- [ ] Ver: `docs/pentesting/sandbox-setup.md` (creado hoy)

### 3. 📱 Móvil — Hotspot + ADB + Tailscale
Referencia: `inbox/2026-06-24-SESION-NOCHE-MOVIL.md` + `inbox/2026-06-24-hotspot-red-situacion.md`
- [ ] Probar `adb shell settings put global tether_dun_required 0`
- [ ] Instalar Tailscale APK (cuando baje la ISO)
- [ ] Hotspot siempre activo: desactivar ahorro batería + configurar systemd keepalive
- [ ] Ver: `hardware/movil-hotspot-config.md` (creado hoy)

### 4. 🕷️ SpiderFoot error descarga
Referencia: `inbox/2026-06-24-error-spiderfoot-descarga.md`
- [ ] Resolver conflicto de dependencias
- [ ] Alternativa: usar imagen Docker oficial de SpiderFoot
- [ ] Ver: `osint/spiderfoot-setup.md` (migrado hoy)

### 5. 🐳 Docker Stack completo (Thdora + servicios)
Referencia: `inbox/2026-06-24-PENDIENTES-THDORA-COMANDOS-Y-DOCKER.md`
- [ ] Aplicar `docker-compose-final-completo.md`
- [ ] LiteLLM + SOPS (fase 4)
- [ ] n8n + LiteLLM integración
- [ ] Ver: `setup/docker-compose-final.md` (migrado hoy)

---

## 📋 Agenda del día 25

```
11:41 → Auditoría inbox + migración (AHORA)
12:00 → Verificar descargas de modelos (ollama list)
12:30 → Hotspot móvil: probar fix ADB
13:00 → SpiderFoot: resolver con Docker
14:00 → Kali VM: arrancar descarga ISO
16:00 → Docker stack: aplicar compose final
noche → Virtualización activa, primeras pruebas
```

---

## 📝 Log de commits de hoy

| Hora | Commit | Descripción |
|------|--------|-------------|
| 11:41 | `feat(diario+migración)` | Diario maestro 25 + migración inbox → estructura repo |

---

## 🧠 Decisiones tomadas hoy

- **Pentesting lab**: La guía de prácticas recibida hoy se documenta en `docs/pentesting/`
- **Hotspot permanente**: Prioridad alta — bloquea la movilidad del stack
- **Virtualización**: Kali en VM antes que Proxmox (menos overhead para empezar)
- **Inbox**: Migración inteligente, inbox solo para notas crudas del día

---

## 🔗 Archivos relacionados
- [`MASTER-PENDIENTES.md`](../MASTER-PENDIENTES.md)
- [`ESTADO-SISTEMA.md`](../ESTADO-SISTEMA.md)
- [`diarios/2026-06-24-SESION-COMPLETA-RESUMEN.md`](2026-06-24-SESION-COMPLETA-RESUMEN.md) *(migrado desde inbox)*
