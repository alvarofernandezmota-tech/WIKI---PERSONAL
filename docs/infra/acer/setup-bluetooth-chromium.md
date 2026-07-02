# Acer — Bluetooth + Chromium setup
#acer #bluetooth #chromium #infra

**Fecha:** 2026-07-02

---

## Bluetooth

```bash
# Debug bluetooth
rfkill list
bluetoothoctl show
sudo systemctl restart bluetooth

# Si el módulo no carga
sudo modprobe btusb
lsmod | grep bt
```

## Chromium como app

```bash
# Lanzar Perplexity como app standalone
chromium --app=https://perplexity.ai --profile-directory=Default

# Alias útil
echo 'alias perp="chromium --app=https://perplexity.ai"' >> ~/.bashrc
```

## Tailscale en Acer

```bash
# Estado
tailscale status
tailscale ip

# Conectar
tailscale up
```
