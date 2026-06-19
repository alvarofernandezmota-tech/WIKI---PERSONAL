# 🔍 Informe OSINT — [NOMBRE OBJETIVO]

> Fecha: YYYY-MM-DD
> Objetivo: dominio / IP / red / persona (propia o con permiso)
> Herramientas usadas:
> Permiso: ✅ propio / ✅ autorizado por escrito

---

## 1. Objetivo

- **Tipo**: dominio / IP / red local / VM laboratorio
- **Valor**: `ejemplo.com` / `10.0.0.0/24`
- **Motivo**: aprendizaje / auditoría propia / laboratorio

---

## 2. Reconocimiento pasivo (sin tocar el objetivo)

### WHOIS
```
[pegar output aquí]
```

### DNS
```
[dig / nslookup output]
```

### Subdominios
```
[theHarvester / subfinder output]
```

---

## 3. Reconocimiento activo (toca el objetivo — solo con permiso)

### Puertos abiertos (nmap)
```bash
# Comando exacto usado:
nmap -sV -p- [objetivo]
```
```
[output]
```

### Servicios detectados

| Puerto | Servicio | Versión | Notas |
|---|---|---|---|
| 22 | SSH | OpenSSH 9.x | |
| 80 | HTTP | nginx | |

---

## 4. Hallazgos relevantes

- Hallazgo 1
- Hallazgo 2

---

## 5. Conclusiones y siguientes pasos

- ¿Hay algo que corregir / hardening que hacer?
- Siguiente acción:

---

## 6. Evidencias

> Capturas, ficheros de output, logs — guardar en la misma carpeta.

---

_Informe generado en yggdrasil-dew/osint/ · [fecha]_
