# Auditar Hotspot y Red — 2026-06-25

**Estado:** 🔧 Pendiente  
**Prioridad:** Media — bloquea descargas grandes y estabilidad de Madre

---

## Qué hay que revisar

- [ ] ¿El hotspot está en 2.4GHz o 5GHz? → cambiar a 5GHz si estamos cerca
- [ ] ¿Tiene activado el ahorro de batería del hotspot? → desactivar
- [ ] Instalar `wavemon` en varopc para monitorizar señal en tiempo real
- [ ] Ajustar potencia WiFi: `sudo iw dev wlan0 set txpower fixed 2000`
- [ ] Revisar qué consume ancho de banda con `nethogs`
- [ ] Documentar alternativas de red en `docs/sistema/red-alternativas.md` (ya existe en ygg)

---

## Objetivo final

Según `ECOSISTEMA.md` Regla 14: cuando haya red fija, Tailscale gestiona todo y el hotspot desaparece.
Mientras tanto: estabilizar lo que hay.

---

## Instalar tools

```bash
# En varopc
sudo pacman -S wavemon nethogs

# Monitorizar señal
wavemon

# Ver consumo por proceso
sudo nethogs wlan0
```
