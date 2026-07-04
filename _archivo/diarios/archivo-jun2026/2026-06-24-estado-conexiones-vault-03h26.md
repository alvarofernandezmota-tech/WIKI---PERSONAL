# Estado conexiones y vault — 24 jun 2026 03:26

---

## Cómo está conectado todo ahora mismo

```
[Móvil]                    [Acer (varopc)]
    |                           |
    |                     SSH a Madre
    |                           |
                         [MADRE torre]
                         100.91.112.32
                         Docker corriendo
```

- Todo lo que se ejecuta en terminal es en **Madre vía SSH desde Acer**
- El Acer es el cliente, Madre es el servidor
- Móvil: pendiente configurar (Tailscale instalado, Obsidian pendiente)

---

## Vault Obsidian — estado

| Dispositivo | Estado |
|---|---|
| Acer (varopc) | ✅ vault montado en `~/Obsidian/cerebro/` |
| Madre | ❌ no instalado (solo servidor, no hace falta) |
| Móvil | ⏳ pendiente — instalar Obsidian + clonar repos |

```bash
# Vault en Acer — YA HECHO
~/Obsidian/cerebro/
├── personal/   ← repo personal clonado ✅
└── tecnico/    ← yggdrasil-dew clonado ✅
```

## Obsidian móvil — pendiente

- Instalar Obsidian desde Play Store / App Store
- Instalar plugin Obsidian Git
- Clonar repos con Working Copy (iOS) o Termux (Android)
- O usar Tailscale + SSH desde móvil directamente

---

## Descarga Madre — estado 03:26

- Script `pre-descarga-todo.sh` murió varias veces (Exit 126 = problema permisos)
- Spiderfoot eliminado del script con `sed`
- Siguiente intento: lanzar en primer plano sin nohup

```bash
# En terminal Madre (sin nohup, primer plano)
bash ~/Projects/yggdrasil-dew/setup/servidor/scripts/pre-descarga-todo.sh

# En otra terminal — Fase 1
bash ~/Projects/yggdrasil-dew/setup/servidor/scripts/batcueva-state.sh
```

---
_Ver: [vaciado-sesion](2026-06-24-vaciado-sesion-completa-madrugada.md) · [ESTADO-SISTEMA.md](../ESTADO-SISTEMA.md)_
