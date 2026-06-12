# Procedimiento de Conexión Input-Leap (Wayland/Hyprland)

> Última actualización: 12 junio 2026
> Estado: investigando solución al bloqueo de portales Wayland

---

## Entorno

| Dato | Valor |
|---|---|
| Red | Tailscale ✅ funciona correctamente |
| Madre IP | `100.91.112.32` |
| Acer IP | `100.86.119.102` |
| WM | Hyprland (Wayland) en ambos |
| Software | `input-leap-git` (AUR) |

---

## Diagnóstico — 3 bloqueos identificados

| # | Máquina | Problema | Causa |
|---|---|---|---|
| 1 | **Madre** | El wrapper GUI genera configs volátiles en `/tmp/` | `input-leap` (GUI) sobreescribe `input-leap.conf` estático |
| 2 | **Acer** | `input-leapc` se autotermina | Dependencia estricta de `org.freedesktop.portal.RemoteDesktop` no activo |
| 3 | Ambos | Portal Wayland no expuesto | `xdg-desktop-portal-hyprland` no negocia `InputCapture` en esta versión |

> **Nota clave:** El problema es de protocolo de sesión, NO de conectividad. Tailscale funciona perfectamente.

---

## Procedimiento de arranque (en orden estricto)

### Paso 1 — Servidor en Madre (usar GUI, no CLI)

La GUI gestiona la negociación con los portales mejor que el binario directo en este caso:

1. Abrir `input-leap` (GUI)
2. Configurar pantallas: `madre` (izquierda/centro) → `acer` (derecha)
3. Dar a **Apply** / **Start Server**
4. Dejar la ventana minimizada — **no cerrarla**
5. Esperar hasta que indique: *"Server is running"*

### Paso 2 — Cliente en Acer (modo sin portales Wayland)

Una vez el servidor confirme *"running"*, lanzar en Acer:

```bash
# Limpiar variables de sesión Wayland antes de lanzar el cliente
env -u XDG_SESSION_TYPE -u XDG_CURRENT_DESKTOP -u WAYLAND_DISPLAY \
    /usr/bin/input-leapc -f -n acer 100.91.112.32:24800
```

> Esto evita que `input-leapc` intente negociar con el portal `RemoteDesktop` y falle.

### Paso 3 — Verificación

- Si el comando se queda “colgado” sin error → **mover el ratón hacia el borde derecho de Madre**
- Si el ratón salta a la pantalla de Acer → ✅ Éxito
- Si hay error → copiar el mensaje exacto y documentar aquí

---

## Troubleshooting

### Error: `QList(...)` en bucle
Estas lanzando el wrapper GUI (`input-leap`) en vez del binario servidor (`input-leaps`). Son binarios distintos.
- Wrapper GUI: `input-leap` — para configurar
- Servidor real: `input-leaps` — para ejecutar
- Cliente real: `input-leapc` — para conectar

### Error: portal `InputCapture` no encontrado
```bash
# Relanzar portal manualmente
WAYLAND_DISPLAY=wayland-1 /usr/lib/xdg-desktop-portal-hyprland &
systemctl --user restart input-leap.service
```

### Error: `RemoteDesktop` portal no disponible en Acer
Usar el comando `env -u` del Paso 2 para saltarse la negociación del portal.

---

## Estado de pruebas

| Intento | Comando | Resultado |
|---|---|---|
| CLI directo `input-leaps` | `QT_QPA_PLATFORM=xcb input-leaps ...` | Error: `InputCapture` no disponible |
| Wrapper `input-leap` | `input-leap ...` | Bucle infinito de procesos `/tmp/` |
| GUI + `env -u` cliente | *pendiente* | ⏳ Por probar |

---

_Ver plan completo: `setup/servidor/plan-maestro.md`_
