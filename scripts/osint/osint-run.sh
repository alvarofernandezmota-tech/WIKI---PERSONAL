#!/bin/bash
# ================================================================
# OSINT RUN — Ejecuta recon básico sobre un objetivo
# Uso: bash scripts/osint/osint-run.sh <objetivo>
# Ejemplo: bash scripts/osint/osint-run.sh example.com
# ================================================================
GREEN='\033[0;32m'; YELLOW='\033[1;33b; NC='\033[0m'
OBJ="${1:-example.com}"
FECHA=$(date '+%Y-%m-%d_%H%M')
OUT=~/yggdrasil-dew/osint/resultados/${OBJ}_${FECHA}
mkdir -p "$OUT"

echo -e "\n${YELLOW}=== OSINT RUN: $OBJ ===${NC}\n"

# WHOIS
command -v whois &>/dev/null && whois "$OBJ" > "$OUT/whois.txt" && echo -e "${GREEN}✅ whois${NC}"

# DNS
command -v dig &>/dev/null && dig "$OBJ" ANY +short > "$OUT/dns.txt" && echo -e "${GREEN}✅ dns${NC}"

# theHarvester (si instalado)
command -v theHarvester &>/dev/null && \
  theHarvester -d "$OBJ" -b google,bing -l 100 > "$OUT/harvester.txt" 2>&1 && \
  echo -e "${GREEN}✅ theHarvester${NC}" || echo -e "${YELLOW}⚠️  theHarvester no instalado${NC}"

# nmap ping scan
command -v nmap &>/dev/null && nmap -sn "$OBJ" > "$OUT/nmap.txt" 2>&1 && echo -e "${GREEN}✅ nmap${NC}"

echo -e "\n${GREEN}Resultados en: $OUT${NC}\n"
