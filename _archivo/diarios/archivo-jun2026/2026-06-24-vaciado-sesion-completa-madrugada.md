# Vaciado completo sesión madrugada — 24 jun 2026 (~02:30–03:12 CEST)

> Agente: Perplexity (Space: Repo Personal)
> Documentado: 03:12 CEST
> Este fichero recoge TODO lo hallado, decidido y pendiente en la sesión.

---

## 1. Contexto de entrada

- Usuario llegaba de ~48h de trabajo continuo escalando el ecosistema
- Madre (torre servidor) con SSH activo, Tailscale operativo
- Repo yggdrasil-dew creciendo rápido, muchos ficheros sin mapear
- Objetivo sesión: documentar todo, estructurar, dejar descargando imágenes Docker

---

## 2. Hallazgos en el repo (cosas que no estaban documentadas)

### tools/local-brain/ — proyecto activo no mapeado
```
tools/local-brain/
├── main.py              ← script principal cerebro IA local
├── deploy_brain.sh
├── requirements.txt
├── .env.example
├── README.md
└── TROUBLESHOOTING.md
tools/local-brain-claude/
├── main_claude.py       ← variante con Claude API
└── deploy_brain_claude.sh
```
- [ ] Auditar qué hace `main.py` exactamente
- [ ] Decidir: ¿mover a `proyectos/local-brain/`?
- [ ] ¿Compatible con stack Ollama actual?

### tools/pull-stack-robusto.sh — no mapeado
- Script robusto para pull de imágenes Docker
- [ ] Comparar con `pre-descarga-todo.sh` — ¿reemplaza o complementa?

### agentes/ y ollama/ — existen pero sin README actualizado
- Tienen contenido (15 fichas LLM según historial) pero no aparecían en ESTADO-SISTEMA
- [ ] Auditar contenido y actualizar README de cada uno

### yo/ en yggdrasil-dew — contenido personal mezclado con técnico
- `perfil.md`, `cv.md`, `habitos.md`, `objetivos-2026.md`, `begona.md`, `empleabilidad.md`
- Debe migrarse a repo `personal/00_yo/`
- [ ] Migrar contenido a `personal/00_yo/`
- [ ] Dejar `yo/README.md` en yggdrasil-dew apuntando a repo personal

---

## 3. Decisiones tomadas esta sesión

| Decisión | Detalle |
|---|---|
| Vault Obsidian = 2 repos | `~/Obsidian/cerebro/personal/` + `~/Obsidian/cerebro/tecnico/` |
| Repo `personal` → vida | privado, todo lo personal va aquí |
| Repo `yggdrasil-dew` → técnico | puede ser público en el futuro |
| `personal` es el repo raíz | define quién eres, yggdrasil-dew sirve a personal |
| Wikilinks cruzados | `[[tecnico/ESTADO-SISTEMA]]` desde personal y viceversa |
| Obsidian 100% terminal | git + nvim, sin abrir la app salvo primera vez |
| `pre-descarga-todo.sh` lanzar solo | nunca encadenar con `&&` y `\|\|` en misma línea |
| Separación formación | técnica en `yggdrasil-dew/formacion/`, personal en `personal/05_formacion/` |

---

## 4. Ficheros creados esta sesión

### En yggdrasil-dew
| Fichero | Descripción |
|---|---|
| `ESTADO-SISTEMA.md` | Foto viva del stack con estructura completa real |
| `MASTER-PENDIENTES.md` | Movido desde inbox/ a raíz, actualizado |
| `ROADMAP.md` | 7 fases + principios de diseño |
| `CONVENCIONES.md` | 12 reglas del sistema (documento más importante) |
| `setup/servidor/scripts/batcueva-state.sh` | Script idempotente todas las fases |
| `setup/servidor/scripts/cierre-sesion.sh` | Commit diario automático |
| `docs/obsidian-setup.md` | Plugins + Dataview + Templater + Local REST API |
| `docs/estructura-madre.md` | Árbol directorios + URLs Tailscale + backups |
| `docs/sistema/estructura-repo.md` | Filosofía estructura + refs repos |
| `docs/sistema/alternativas-llm.md` | 9 alternativas Ollama + cuándo migrar |
| `docs/sistema/referencias-inspiracion.md` | Repos investigados + skills a añadir |
| `docs/sistema/obsidian-vault-terminal.md` | Setup vault + flujo terminal + aliases |
| `inbox/2026-06-24-sesion-madrugada-setup-servidor.md` | Resumen sesión |
| `inbox/2026-06-24-descubrimiento-tools-local-brain.md` | tools/ no mapeado |

### En personal
| Fichero | Descripción |
|---|---|
| `README.md` | Filosofía + setup vault + wikilinks |
| `00_yo/README.md` | Estructura sección personal |
| `01_diarios/README.md` | Plantilla diario personal |
| `02_metas/README.md` | Objetivos + revisión semanal |
| `03_reflexiones/README.md` | Ideas y pensamientos |
| `inbox/README.md` | Flujo inbox personal |

---

## 5. Errores técnicos encontrados esta sesión

### Error descarga Madre — comando encadenado
**Problema:** `&&` y `|| true` en una línea cortaron el proceso nohup
```bash
# MAL — || true corta la cadena
cd repo && git pull && docker network create batcueva 2>/dev/null || true && nohup bash script.sh &

# BIEN — lanzar el script solo
nohup bash ~/Projects/yggdrasil-dew/setup/servidor/scripts/pre-descarga-todo.sh > /tmp/pre-descarga.log 2>&1 &
echo "PID: $!"
```

### Error confusión terminal/chat
- Al inicio de sesión el usuario pegaba texto en terminal en lugar del chat
- Resuelto identificando la ventana correcta

---

## 6. Estado Madre al final de sesión

| Servicio | Estado |
|---|---|
| SSH | ✅ operativo |
| Tailscale | ✅ operativo (100.91.112.32) |
| Docker | ✅ corriendo |
| Red batcueva | ✅ creada |
| Descarga imágenes | ✅ en background PID 186734 |
| Fase 1 stack | ⏳ pendiente verificar tras descarga |
| Obsidian | ✅ instalado en Madre |

---

## 7. Pendientes que quedan de esta sesión

- [ ] Verificar log descarga: `tail -f /tmp/pre-descarga.log`
- [ ] Cuando termine: `bash setup/servidor/scripts/batcueva-state.sh`
- [ ] Auditar `tools/local-brain/main.py`
- [ ] Migrar `yo/` de yggdrasil-dew a `personal/00_yo/`
- [ ] Dejar `yo/README.md` como puntero a repo personal
- [ ] Auditar `agentes/` y `ollama/` — contenido y README
- [ ] Añadir aliases del vault al `.bashrc` de Acer y Madre
- [ ] Setup vault: `git clone` de ambos repos en `~/Obsidian/cerebro/`
- [ ] Configurar Obsidian Git plugin en el vault
- [ ] Fase 3: levantar n8n + Paperless + Vaultwarden
- [ ] Fase 4: crear compose + scripts

---

## 8. Comandos listos para usar

```bash
# Verificar descarga en curso
tail -f /tmp/pre-descarga.log

# Lanzar descarga limpia si falló
nohup bash ~/Projects/yggdrasil-dew/setup/servidor/scripts/pre-descarga-todo.sh > /tmp/pre-descarga.log 2>&1 &
echo "PID: $!"

# Estado del stack cuando termine descarga
bash ~/Projects/yggdrasil-dew/setup/servidor/scripts/batcueva-state.sh

# Setup vault Obsidian
mkdir -p ~/Obsidian/cerebro
git clone git@github.com:alvarofernandezmota-tech/personal.git ~/Obsidian/cerebro/personal
git clone git@github.com:alvarofernandezmota-tech/yggdrasil-dew.git ~/Obsidian/cerebro/tecnico

# Cierre de sesión
bash ~/Projects/yggdrasil-dew/setup/servidor/scripts/cierre-sesion.sh "descripción"
```

---
_Próxima sesión: verificar descarga → batcueva-state.sh → Fase 3 → auditar tools/local-brain_
_Ver: [MASTER-PENDIENTES.md](../MASTER-PENDIENTES.md) · [ESTADO-SISTEMA.md](../ESTADO-SISTEMA.md)_
