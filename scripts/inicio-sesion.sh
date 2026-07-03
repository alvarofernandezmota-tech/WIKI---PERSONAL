#!/bin/bash
# inicio-sesion.sh — wrapper hacia 'bc sesion'
# Mantenido por compatibilidad. Usar 'bc sesion' en su lugar.
exec "$(dirname "$0")/bc" sesion "$@"
