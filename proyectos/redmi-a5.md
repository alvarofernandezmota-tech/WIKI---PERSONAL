# 📱 Redmi A5 — Rescate Android

> Última actualización: 17 junio 2026

---

## Qué es

Redmi A5 con chip **Unisoc T765 / Qogirl6**. Bootloader OEM bloqueado definitivamente (`Err:0xffffffff`). Única salida viable: EDL / SPRD Download Mode.

---

## Estado actual

| Campo | Valor |
|---|---|
| Serial | `863d0058304831323851135e23407c` |
| Chip | Unisoc T765 / Qogirl6 |
| Bootloader | 🔴 OEM bloqueado permanente (`Err:0xffffffff`) |
| ROM descargando | ⏳ curl en curso — 4.54GB — desde 15/06 |
| ROM destino | `~/isos/redmi-a5/serenity_global.tgz` |
| Modo EDL | ⏳ Sin probar aun — `Vol↓ + USB` |

---

## Decisiones tomadas

- Herramienta nativa Linux: `sfd_tool` (compilado, funciona) ✅
- `mtkclient` instalado para diagnóstico rápido USB (aunque es MediaTek) ✅
- ROM: Xiaomi Global A15.0.26.0.VGWMIXM (serenity_global)
- Windows VM (KVM) preparada para SPD UpgradeDownload si EDL nativo falla

---

## TODO próximo

- [ ] Esperar a que termine descarga ROM (~4.54GB)
- [ ] `Vol↓ + USB` → `lsusb` → verificar VID Unisoc `0x1782`
- [ ] Si detecta → flash con `sfd_tool`
- [ ] Si no detecta → test point físico en la placa
- [ ] Último recurso: SPD UpgradeDownload en Windows VM

---

## Descarga ROM

```bash
cd ~/isos/redmi-a5
curl -L -C - -o serenity_global.tgz \
  "https://bkt-sgp-miui-ota-update-alisgp.oss-ap-southeast-1.aliyuncs.com/A15.0.26.0.VGWMIXM/serenity_global-images-A15.0.26.0.VGWMIXM-user-20260427.0000.00-15.0-global-26c6dc7975.tgz"
# -C - reanuda si se corta
```

---

## Historial

- 15/06/2026 — Detectado bootloader bloqueado permanente
- 15/06/2026 — KVM instalado en varopc, libvirtd activo
- 15/06/2026 — Descarga ROM iniciada con curl
- 17/06/2026 — Ficha creada en yggdrasil-dew
