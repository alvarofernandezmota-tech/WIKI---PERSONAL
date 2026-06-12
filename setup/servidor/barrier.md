# Input Leap / Barrier — Teclado y Ratón Compartido

> Última actualización: 12 junio 2026

---

## Qué es

**Input Leap** (fork activo de Barrier) permite usar **un solo teclado y ratón** para controlar varias máquinas en la misma red local. El cursor pasa de una pantalla a otra simplemente moviéndolo al borde.

- **Servidor** = la máquina con el teclado/ratón físico
- **Cliente** = la máquina que recibe el control por red

---

## Setup actual

```
Acer Aspire (SERVIDOR Input Leap)
    teclado + ratón físico aquí
         │
         │ LAN (puerto 24800)
         │
MacBook (CLIENTE Input Leap)
    controlado remotamente
```

**Estado:** ✅ Funcionando

---

## Setup objetivo (con Ordenador Madre)

```
Ordenador Madre (SERVIDOR Input Leap)
    teclado + ratón físico aquí
         │
    ┌────┴─────┐
    │          │
  Acer      MacBook
 (cliente)  (cliente)
```

Un solo teclado/ratón controla las tres máquinas.

---

## Instalación en Arch/Omarchy

```bash
# Input Leap (recomendado sobre Barrier en Wayland)
yay -S input-leap

# Barrier (alternativa, peor soporte Wayland)
yay -S barrier
```

> ⚠️ **Wayland:** Hyprland/Wayland tiene limitaciones con Barrier. Input Leap tiene mejor soporte. Usar `input-leap` en Omarchy.

---

## Configuración básica (servidor)

```bash
# Arrancar servidor Input Leap
input-leap --server

# Como servicio systemd (recomendado)
sudo systemctl enable --now input-leap-server
```

Archivo de configuración: `~/.config/input-leap/input-leap.conf`

```
section: screens
    madre:
    acer:
    macbook:
end

section: links
    madre:
        right = acer
    acer:
        left = madre
        right = macbook
    macbook:
        left = acer
end
```

---

## TLS / Seguridad

```bash
# Generar certificado para cifrar la conexión
openssl req -x509 -nodes -days 365 \
  -newkey rsa:2048 \
  -keyout ~/.local/share/input-leap/SSL/Barrier.pem \
  -out ~/.local/share/input-leap/SSL/Barrier.pem
```

---

## TODO

- [ ] Migrar servidor de Acer a Ordenador Madre
- [ ] Configurar TLS
- [ ] Añadir servicio systemd
- [ ] Documentar layout de pantallas definitivo

---

_Ver también: `setup/servidor/lan.md` | `setup/equipos.md`_
