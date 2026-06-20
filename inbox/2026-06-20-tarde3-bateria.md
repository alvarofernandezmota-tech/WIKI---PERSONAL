# Inbox — Batería y Monitoreo Acer · 20 junio 2026

> Capturado desde conversación Perplexity · 17:05 CEST
> Estado: 🟡 Procesar

---

## 🔋 Diagnóstico real de la batería BAT1

| Métrica | Valor |
|---|---|
| **Dispositivo** | /sys/class/power_supply/BAT1 |
| **Fabricante** | LGC |
| **Modelo** | AP18C8K |
| **Salud** | **67.8%** ⚠️ |
| Capacidad actual | 2891 mAh (32553 mWh) |
| Capacidad original | 4267 mAh (48046 mWh) |
| Pérdida | 1376 mAh (32.2%) |
| Ciclos | 0 (no soportado por driver) |
| Control de carga | ❌ NO disponible (no se puede fijar límite 80%) |
| Estado al medir | Discharging @ 57.6% / 8.7W consumo |

> ⚠️ El Acer AP18C8K NO soporta charge_control_threshold via TLP.
> Gestión manual: no dejar enchufado al 100% durante horas, desconectar ~80-90%.

---

## 🛠️ Software instalado

- **TLP 1.10.0** ✅ — `sudo systemctl enable --now tlp` hecho
  - Warning: power-profiles-daemon corriendo en paralelo (conflicto potencial)
  - Plugin: generic (sin soporte de batería avanzado para este Acer)
- **btop** — pendiente instalar
- **acpi** — pendiente instalar
- **powertop** — pendiente instalar (no encontrado con `sudo powertop`)

---

## ⚡ Conflicto: TLP vs power-profiles-daemon

Al lanzar `sudo tlp start` sale:
```
Warning: CPU_ENERGY_PERF_POLICY_ON_AC/BAT/SAV is not set because power-profiles-daemon is running.
```

Opciones:
1. Desactivar power-profiles-daemon y dejar solo TLP:
   ```bash
   sudo systemctl disable --now power-profiles-daemon
   sudo tlp start
   ```
2. O dejar los dos y aceptar que TLP no controla CPU energy policy.

**Recomendación:** opción 1 para máxima optimización con TLP.

---

## 📦 Pendientes monitoreo

```bash
sudo pacman -S btop acpi powertop --noconfirm
```

- **btop** → monitor CPU/RAM/procesos/temp en tiempo real
- **acpi** → batería detallada
- **powertop** → qué procesos consumen más batería
- **sensors** → temperaturas CPU (requiere `lm_sensors` + `sudo sensors-detect`)

---

## 📋 Comandos rápidos de referencia (varopc)

```bash
# Estado batería rápido
cat /sys/class/power_supply/BAT1/capacity
cat /sys/class/power_supply/BAT1/status

# TLP stat completo
sudo tlp-stat -b

# Monitor en tiempo real
btop

# Consumo por proceso
sudo powertop

# Temperaturas
sensors
```

---

_Procesar a: `setup/varopc.md` · `hardware/acer-bateria.md`_
