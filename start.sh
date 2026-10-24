#!/bin/bash
set -e

echo "Starting ImmRTX application..."

# Verificar que los navegadores están instalados
if [ ! -d "/ms-playwright" ]; then
    echo "Installing browsers..."
    playwright install chromium
fi

# Iniciar la aplicación
# Ajusta 'python app.py' según tu estructura real
# Si usas Flask: gunicorn app:app
# Si usas un script específico: python your_script.py

echo "Launching process..."
exec python app.py
