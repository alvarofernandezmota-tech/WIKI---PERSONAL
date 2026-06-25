---
tags: [scripts, referencia]
fecha: 2026-06-25
---

# Scripts de la Batcueva

## 🦇 Comando principal: `bc`

El comando maestro. **Instalar una vez:**

```bash
# Opción A — alias en .zshrc (recomendado)
echo "alias bc='~/yggdrasil-dew/scripts/bc'" >> ~/.zshrc
source ~/.zshrc
chmod +x ~/yggdrasil-dew/scripts/bc

# Opción B — symlink global
sudo ln -sf ~/yggdrasil-dew/scripts/bc /usr/local/bin/bc
```

### Comandos disponibles

| Comando | Qué hace |
|---------|----------|
| `bc sesion` | Pull + crea diario del día + status |
| `bc s` | Status rápido: contenedores + RAM + disco |
| `bc up` | Levanta toda la Batcueva |
| `bc up osint` | Solo stack OSINT (SpiderFoot + IVRE) |
| `bc up pentest` | Solo stack pentest (Kali + Bettercap...) |
| `bc up siem` | Solo SIEM (Wazuh + Suricata + DefectDojo) |
| `bc up vuln` | Solo vuln (Greenbone + Nuclei + ZAP) |
| `bc down [stack]` | Para todo o un stack |
| `bc logs <svc>` | Logs de un contenedor |
| `bc restart <svc>` | Reinicia un contenedor |
| `bc inbox` | Procesa inbox/ (migra ficheros) |
| `bc pentest` | Abre Kali Desktop en navegador |
| `bc osint [target]` | Levanta SpiderFoot |
| `bc scan [red]` | Nmap rápido desde Kali o host |
| `bc pull` | `git pull --rebase` |
| `bc push [msg]` | `git add + commit + push` |

---

## Scripts de soporte

| Script | Estado | Función |
|--------|--------|----------|
| `bc` | ✅ ACTIVO | Comando maestro |
| `batcueva-control.sh` | ✅ ACTIVO | Control de stacks (wrapper) |
| `migrar-inbox.sh` | ✅ ACTIVO | Migra inbox/ a destinos |
| `watchdog_adb.sh` | ✅ ACTIVO | Watchdog ADB/móvil |
| `inicio-sesion.sh` | ⚠️ LEGACY | Redirige a `bc sesion` |
| `inbox-cleanup-jun2024.sh` | 🗑️ OBSOLETO | Limpieza inbox jun2024 |
| `inbox-cleanup-jun2026.sh` | 🗑️ OBSOLETO | Limpieza inbox jun2026 |
| `procesar-inbox-masivo.sh` | 🗑️ OBSOLETO | Fusionado en `migrar-inbox.sh` |

> Los scripts OBSOLETOS se mantienen por historial pero no usar.
> Usar siempre `bc` para todo.

---

## Configuración inicial en un nodo nuevo

```bash
git clone git@github.com:alvarofernandezmota-tech/yggdrasil-dew.git ~/yggdrasil-dew
cd ~/yggdrasil-dew
cp .env.template .env
vim .env  # rellenar credenciales
chmod +x scripts/bc
echo "alias bc='~/yggdrasil-dew/scripts/bc'" >> ~/.zshrc
source ~/.zshrc
bc sesion
```

---
_Actualizado: 2026-06-25_
