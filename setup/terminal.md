# Setup Terminal

## Concepto

Se usan dos terminales en paralelo:

- **Terminal Omarchy (Acer)** → trabajo en Acer directamente, prompt `theodora ~ >`
- **Tmux (Madre)** → conexión SSH permanente a Madre en segundo plano

## Máquinas

| Máquina | Nombre prompt | Shell | Acceso |
|---------|--------------|-------|--------|
| Acer (local) | `theodora` | zsh + Starship | Terminal normal Omarchy |
| Madre (servidor) | `varopc` | zsh | SSH vía Tailscale |

## Prompt (Acer)

El prompt de Acer muestra `theodora ~ >`. Configurado en:

- `~/.config/starship.toml` — módulo hostname con nombre fijo `acervaro`
- `~/.zshrc` — `PROMPT="theodora %~ > "`

## Conexión SSH a Madre

Red: Tailscale  
IP Madre: `100.91.112.32`  
Usuario: `varo`

```bash
ssh madre
# o con IP directa
ssh varo@100.91.112.32
```

## Tmux — sesión permanente a Madre

Tmux permite mantener la conexión a Madre siempre activa en segundo plano.

### Instalación (pendiente en Acer)

```bash
sudo pacman -S tmux
```

### Alias (pendiente — añadir a ~/.zshrc)

```bash
alias madre='tmux new-session -s madre "ssh madre"'
```

### Uso básico

```bash
madre              # abrir/retomar sesión de Madre
Ctrl+b d           # salir de tmux (Madre sigue corriendo)
Ctrl+b %           # dividir pantalla en dos paneles
Ctrl+b →  /  ←    # moverse entre paneles
tmux attach -t madre  # reconectar a sesión existente
```

## Estado actual

- [x] SSH funcionando entre Acer y Madre vía Tailscale
- [x] Prompt `theodora` configurado en Acer
- [x] zsh instalado en Madre
- [ ] Tmux instalado en Acer
- [ ] Alias `madre` añadido a `~/.zshrc`
- [ ] Prompt diferenciado configurado en Madre
