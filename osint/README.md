# 🔍 OSINT — Base de Operaciones

> Carpeta dedicada a investigación OSINT y auditoría de seguridad.
> Todo lo que se recoge aquí es sobre objetivos **propios o con permiso explícito**.
> Última actualización: **20 junio 2026**

---

## Estructura

```
osint/
├── README.md              → este archivo — índice + reglas
├── plantilla-informe.md   → plantilla base para cada investigación
└── resultados/            → un .md por objetivo/fecha
    └── YYYY-MM-DD-objetivo.md
```

---

## Reglas de uso

1. **Solo objetivos propios o con permiso escrito** — red de casa, dominios propios, VMs de laboratorio.
2. Cada investigación = un fichero en `resultados/` con fecha y nombre de objetivo.
3. Guardar siempre el comando exacto que generó el resultado.
4. Nunca subir credenciales, tokens ni datos personales de terceros.

---

## Herramientas previstas

| Herramienta | Tipo | Estado | Instalada en |
|---|---|---|---|
| `nmap` | Escaneo de red / puertos | ⏳ Instalar | varopc / Madre |
| `theHarvester` | Recolección emails, subdominios | ⏳ Instalar | varopc |
| `whois` | Info de dominios | ✅ Suele venir por defecto | varopc |
| `subfinder` | Subdominios rápido | ⏳ Evaluar | varopc |
| Obsidian Canvas | Tablón visual de investigación | ⏳ Instalar Obsidian primero | varopc |

> ⚠️ Prioridad: instalar Obsidian en varopc antes de usar el Canvas para OSINT.

---

## Flujo de trabajo

```
1. Definir objetivo (dominio, IP, red) + confirmar permiso
2. Lanzar herramienta en terminal (varopc o Madre)
3. Copiar output relevante a resultados/YYYY-MM-DD-objetivo.md
4. Obsidian indexa el fichero automáticamente via plugin Git
5. Open WebUI puede consultarlo via RAG (cuando esté instalado en Madre)
```

---

## Primer ejercicio recomendado

Auditar **tu propia red de casa** con nmap:

```bash
# Instalar nmap si no está
sudo pacman -S nmap   # Arch Linux

# Escanear tu red local (sustituye por tu rango real)
nmap -sn 10.134.31.0/24

# Guardar resultado
nmap -sn 10.134.31.0/24 > ~/repos/yggdrasil-dew/osint/resultados/$(date +%Y-%m-%d)-red-casa.md
```

---

_Parte de [yggdrasil-dew](https://github.com/alvarofernandezmota-tech/yggdrasil-dew) · 20 junio 2026_
