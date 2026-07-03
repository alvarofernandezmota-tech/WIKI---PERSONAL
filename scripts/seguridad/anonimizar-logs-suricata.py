#!/usr/bin/env python3
"""
yggdrasil-dew/scripts/seguridad/anonimizar-logs-suricata.py
Propósito: Anonimizar logs EVE JSON de Suricata antes de enviarlos a Gemini API.
Elimina/reemplaza IPs reales, MACs, hostnames y tokens.
"""

import json
import re
import sys
import ipaddress
from pathlib import Path

# Rangos internos a sustituir
PRIVATE_RANGES = [
    ipaddress.ip_network("192.168.0.0/16"),
    ipaddress.ip_network("10.0.0.0/8"),
    ipaddress.ip_network("172.16.0.0/12"),
    ipaddress.ip_network("100.64.0.0/10"),  # Tailscale
]

ip_map: dict[str, str] = {}
ip_counter = 1


def is_private(ip: str) -> bool:
    try:
        addr = ipaddress.ip_address(ip)
        return any(addr in net for net in PRIVATE_RANGES)
    except ValueError:
        return False


def anonymize_ip(ip: str) -> str:
    global ip_counter
    if not ip:
        return ip
    if ip not in ip_map:
        if is_private(ip):
            ip_map[ip] = f"10.ANON.{ip_counter}.1"
        else:
            ip_map[ip] = f"203.0.113.{ip_counter}"  # TEST-NET RFC 5737
        ip_counter += 1
    return ip_map[ip]


def anonymize_event(event: dict) -> dict:
    """Anonimiza un evento EVE JSON de Suricata."""
    for field in ("src_ip", "dest_ip"):
        if field in event:
            event[field] = anonymize_ip(event[field])

    # Eliminar campos sensibles
    for field in ("community_id", "flow_id"):
        event.pop(field, None)

    # Anonimizar hostname en HTTP
    if "http" in event:
        host = event["http"].get("hostname", "")
        if host and not host.startswith("ANON"):
            event["http"]["hostname"] = "ANON_HOST"

    # Redactar tokens o credenciales en campos de texto libre
    for field in ("alert", "dns", "tls"):
        if field in event:
            raw = json.dumps(event[field])
            # Redactar patrones tipo token/key
            raw = re.sub(r'(Bearer\s)[A-Za-z0-9\-._~+/]+=*', r'\1REDACTED', raw)
            raw = re.sub(r'(password|token|secret|apikey)[":\s]+[^"\s,}]+',
                         r'\1: REDACTED', raw, flags=re.IGNORECASE)
            event[field] = json.loads(raw)

    return event


def process_file(input_path: str, output_path: str) -> None:
    input_file = Path(input_path)
    output_file = Path(output_path)

    anonymized = []
    errors = 0

    with input_file.open("r") as f:
        for line in f:
            line = line.strip()
            if not line:
                continue
            try:
                event = json.loads(line)
                anonymized.append(anonymize_event(event))
            except json.JSONDecodeError:
                errors += 1

    with output_file.open("w") as f:
        for event in anonymized:
            f.write(json.dumps(event) + "\n")

    print(f"[+] Procesados: {len(anonymized)} eventos")
    print(f"[+] IPs anonimizadas: {len(ip_map)}")
    print(f"[!] Errores de parseo: {errors}")
    print(f"[+] Salida: {output_path}")


if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Uso: python anonimizar-logs-suricata.py <eve.json> <eve-anon.json>")
        sys.exit(1)
    process_file(sys.argv[1], sys.argv[2])
