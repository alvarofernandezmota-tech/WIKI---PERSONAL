# whisrs — Dictado por voz offline

> Última actualización: 12 junio 2026

---

## Estado por máquina

| Máquina | Estado | Modelo | Notas |
|---|---|---|---|
| **Acer** | ✅ Instalado | `base.en` (142 MB) | Funcionando |
| **Madre** | ⏳ Pendiente | `small.en` (466 MB) | Usar GPU GTX 1060 |

---

## Qué es

Dictado por voz 100% offline para Wayland/Hyprland.
Pulsa hotkey, hablas, el texto aparece donde esté el cursor.

| Dato | Valor |
|---|---|
| Backend | whisper.cpp (local) |
| Conexión | Sin internet ✅ |
| Wayland | Nativo ✅ |
| Hyprland | Compatible ✅ |

---

## Instalación

```bash
yay -S whisrs-git
whisrs setup
# → Local → whisper.cpp → base.en (Acer) / small.en (Madre)
```

---

## Hotkey en Hyprland

Añadir en `~/.config/hypr/hyprland.conf`:

```bash
bind = SUPER, V, exec, whisrs toggle
```

---

## Modelos

| Modelo | Tamaño | Para qué |
|---|---|---|
| `tiny.en` | 75 MB | Comandos simples |
| **`base.en`** | 142 MB | **Acer (8 GB RAM) ✅** |
| **`small.en`** | 466 MB | **Madre (16 GB + GTX 1060) ⏳** |
| `medium.en` | 1.5 GB | Servidores potentes |

---

## Instalar en Madre (pendiente)

```bash
# En Madre
yay -S whisrs-git
whisrs setup
# → Local → whisper.cpp → small.en
# → activar GPU: whisrs config --gpu
```

---

_Volver al índice: [README.md](README.md)_
