#!/bin/bash

# ==========================================
# Script: agregar_puerto.sh
# Descripción: Añade un puerto de escucha a Apache si no existe.
# Uso: sudo ./agregar_puerto.sh <numero_puerto>
# ==========================================

# 1. Verificar si el usuario es root (necesario para editar configuración)
if [ "$(id -u)" -ne 0 ]; then
    echo "Error: Este script debe ejecutarse con sudo o como root."
    exit 1
fi

# 2. Verificar que se ha pasado un parámetro
if [ -z "$1" ]; then
    echo "Uso: $0 <numero_puerto>"
    exit 1
fi

PUERTO=$1
ARCHIVO_CONF="/etc/apache2/ports.conf"

# 3. Comprobar si el archivo de configuración existe
if [ ! -f "$ARCHIVO_CONF" ]; then
    echo "Error: No se encuentra el archivo $ARCHIVO_CONF"
    exit 1
fi

# 4. Comprobar si el puerto ya está en el archivo
# Usamos espacios alrededor de Listen o anclajes para asegurar que 80 no coincida con 8080
if grep -q "Listen $PUERTO" "$ARCHIVO_CONF"; then
    echo "Aviso: El puerto $PUERTO ya está configurado en Apache."
else
    # 5. Añadir el puerto al final del archivo
    echo "Listen $PUERTO" >> "$ARCHIVO_CONF"
    echo "Éxito: Se ha añadido 'Listen $PUERTO' a $ARCHIVO_CONF"
    echo "Reinicia Apache para aplicar cambios: sudo systemctl restart apache2"
fi
