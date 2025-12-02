#!/bin/bash

# ==========================================
# Script: agregar_host.sh
# Descripción: Añade un dominio e IP al archivo hosts si el dominio no existe.
# Uso: sudo ./agregar_host.sh <dominio> <ip>
# ==========================================

# 1. Verificar permisos de root
if [ "$(id -u)" -ne 0 ]; then
    echo "Error: Necesitas permisos de root para editar /etc/hosts."
    exit 1
fi

# 2. Verificar parámetros (Esperamos 2: Dominio e IP)
if [ $# -ne 2 ]; then
    echo "Uso: $0 <dominio> <ip>"
    echo "Ejemplo: $0 miweb.local 127.0.0.1"
    exit 1
fi

DOMINIO=$1
IP=$2
ARCHIVO_HOSTS="/etc/hosts"

# 3. Comprobar si el dominio ya existe en el archivo
# \b son límites de palabra para asegurar coincidencia exacta del dominio
if grep -q "\b$DOMINIO\b" "$ARCHIVO_HOSTS"; then
    echo "Error: El dominio '$DOMINIO' ya existe en $ARCHIVO_HOSTS."
else
    # 4. Añadir la IP y el Dominio
    echo "$IP   $DOMINIO" >> "$ARCHIVO_HOSTS"
    echo "Éxito: Se ha añadido '$IP $DOMINIO' al archivo hosts."
fi
