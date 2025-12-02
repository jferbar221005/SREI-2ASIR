#!/bin/bash

# ==========================================
# Script: crear_web.sh
# Descripción: Crea un archivo index.html básico pidiendo datos al usuario.
# Uso: ./crear_web.sh (Interactivo)
# ==========================================

# No necesitamos ser root obligatoriamente, a menos que escribamos en /var/www/
# Preguntaremos la ruta de destino.

echo "--- Generador de Página Web Básica ---"

# 1. Solicitar datos al usuario
read -p "Introduce la ruta y nombre del archivo (ej: index.html): " RUTA_ARCHIVO
read -p "Introduce el Título de la pestaña (Title): " TITULO
read -p "Introduce el Encabezado principal (H1): " CABECERA
read -p "Introduce el mensaje del cuerpo (P): " MENSAJE

# 2. Generar el contenido HTML
# Usamos cat <<EOF para escribir múltiples líneas fácilmente
CONTENIDO_HTML="<!DOCTYPE html>
<html lang=\"es\">
<head>
    <meta charset=\"UTF-8\">
    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">
    <title>$TITULO</title>
    <style>
        body { font-family: sans-serif; text-align: center; padding: 50px; }
        h1 { color: #333; }
        p { color: #666; font-size: 1.2em; }
    </style>
</head>
<body>
    <h1>$CABECERA</h1>
    <p>$MENSAJE</p>
</body>
</html>"

# 3. Guardar el archivo
# Intentamos escribir en la ruta. 
# Si falla, avisamos al usuario.
if echo "$CONTENIDO_HTML" > "$RUTA_ARCHIVO"; then
    echo "-----------------------------------"
    echo "¡Página creada con éxito en: $RUTA_ARCHIVO!"
else
    echo "-----------------------------------"
    echo "Error: No se pudo crear el archivo. Verifica la ruta o los permisos."
    echo "Si intentas escribir en /var/www/, usa 'sudo ./crear_web.sh'"
fi
