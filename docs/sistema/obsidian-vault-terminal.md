# Obsidian vault desde terminal — sin abrir la app

> Todo se gestiona con git. Obsidian solo es el visor.
> Puedes trabajar 100% desde terminal y Obsidian sincroniza solo.

---

## Setup inicial del vault (una sola vez)

```bash
# 1. Crear estructura del vault
mkdir -p ~/Obsidian/cerebro
cd ~/Obsidian/cerebro

# 2. Clonar los dos repos
git clone git@github.com:alvarofernandezmota-tech/personal.git personal
git clone git@github.com:alvarofernandezmota-tech/yggdrasil-dew.git tecnico

# 3. Abrir Obsidian → Open folder as vault → ~/Obsidian/cerebro
# (solo esta vez para configurar)
```

---

## Flujo diario — 100% terminal

```bash
# Sync al empezar el día (traer cambios)
cd ~/Obsidian/cerebro/personal && git pull
cd ~/Obsidian/cerebro/tecnico && git pull

# Escribir una nota (sin abrir Obsidian)
nvim ~/Obsidian/cerebro/personal/01_diarios/$(date +%Y-%m-%d).md

# Añadir al inbox técnico
nvim ~/Obsidian/cerebro/tecnico/inbox/$(date +%Y-%m-%d)-idea.md

# Commit y push al final del día
cd ~/Obsidian/cerebro/tecnico
bash setup/servidor/scripts/cierre-sesion.sh "descripción"

# Commit personal
cd ~/Obsidian/cerebro/personal
git add -A && git commit -m "diario $(date +%Y-%m-%d)" && git push
```

---

## Alias recomendados (añadir a ~/.bashrc o ~/.zshrc)

```bash
# Navegación rápida
alias cerebro='cd ~/Obsidian/cerebro'
alias tecnico='cd ~/Obsidian/cerebro/tecnico'
alias personal='cd ~/Obsidian/cerebro/personal'

# Notas rápidas
alias diario='nvim ~/Obsidian/cerebro/personal/01_diarios/$(date +%Y-%m-%d).md'
alias inbox='nvim ~/Obsidian/cerebro/tecnico/inbox/$(date +%Y-%m-%d)-inbox.md'

# Sync completo
alias sync-cerebro='cd ~/Obsidian/cerebro/personal && git pull && cd ../tecnico && git pull'

# Cierre de sesión
alias cierre='bash ~/Obsidian/cerebro/tecnico/setup/servidor/scripts/cierre-sesion.sh'
```

---

## Obsidian Git — auto-sync sin tocar nada

Con el plugin Obsidian Git configurado, el vault hace push/pull automático cada 10 minutos. []
Pero cada carpeta (`personal/`, `tecnico/`) es un repo git independiente — necesitas configurar
el plugin dos veces o usar el plugin **Multi-Root Vaults** (experimental).

Solución más simple: usar el alias `cierre` desde terminal al final del día.

---

## Crear nota nueva sin abrir Obsidian

```bash
# Nota en inbox personal
cat > ~/Obsidian/cerebro/personal/inbox/$(date +%Y-%m-%d)-idea.md << 'EOF'
# Idea — $(date +%Y-%m-%d)

EOF

# Diario personal de hoy
cat > ~/Obsidian/cerebro/personal/01_diarios/$(date +%Y-%m-%d).md << 'EOF'
# Diario — $(date +%d %b %Y)

## Cómo estoy

## Qué pasó hoy

## Qué aprendí

## Mañana
EOF
nvim ~/Obsidian/cerebro/personal/01_diarios/$(date +%Y-%m-%d).md
```

---
_Ver: [obsidian-setup.md](../obsidian-setup.md) · [estructura-repo.md](estructura-repo.md)_
