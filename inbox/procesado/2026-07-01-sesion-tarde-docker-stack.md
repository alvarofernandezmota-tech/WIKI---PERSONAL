---
tags: [tipo/sesion, estado/draft, #infra/docker, #infra/arch]
---

# Sesión Tarde — 2026-07-01

> 📥 inbox — pendiente de procesar al cierre de sesión

**Hora:** ~16:00 – 19:00 CEST  
**Nodo:** madre (SSH desde theodora)  
**Conectividad:** Redmi A5 hotspot 4G DIGI ES

---

## Completado esta tarde

### Descargas overnight — resultado
- ✅ `wazuh/wazuh-dashboard:4.7.0` — descargado (1.56GB)
- ❌ `kasmweb/kali-rolling-desktop:1.16.0` — se cayó por `tls: bad record MAC`
- ❌ `jasonish/suricata:latest` — no llegó

### Problema TLS — solución aplicada
Error `tls: bad record MAC` = corrupción de paquetes por inestabilidad del hotspot.  
Solución: bucle `until` para reintentar automáticamente:

```bash
until docker compose -f ~/yggdrasil-dew/osint-stack/docker-compose.kali.yml pull; do
  echo "Reintentando en 10s..."
  sleep 10
done && docker pull jasonish/suricata:latest
```

### Estado imágenes Docker ahora
| Imagen | Estado |
|--------|--------|
| `pihole/pihole:latest` | ✅ listo |
| `searxng/searxng:latest` | ✅ listo |
| `wazuh/wazuh-manager:4.7.0` | ✅ listo |
| `wazuh/wazuh-dashboard:4.7.0` | ✅ listo |
| `kasmweb/kali-rolling-desktop:1.16.0` | 🔄 descargando (bucle activo) |
| `jasonish/suricata:latest` | ⏳ en cola tras kali |

---

## Pendiente levantar (Fase 5)

- [ ] Pihole + SearXNG — imágenes listas, levantar ya
- [ ] Wazuh Manager + Dashboard — imágenes listas
- [ ] Kali KasmWeb — esperando descarga
- [ ] Suricata IDS — esperando descarga

---

## 🔴 Crítico pendiente
- [ ] Cerrar puerto 21 FTP en router (hallazgo Fase 3)

---

*🔧 WIP — procesar al cerrar sesión*
