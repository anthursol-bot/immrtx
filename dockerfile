# Usamos una base Debian Slim para ser ligeros pero completos
FROM python:3.7-slim

# Variables de entorno para Playwright
ENV PLAYWRIGHT_BROWSERS_PATH=/ms-playwright
ENV PYTHONUNBUFFERED=1

# Instalar dependencias del sistema necesarias para navegadores
RUN apt-get update && apt-get install -y \
    wget \
    curl \
    gnupg \
    lsb-release \
    libglib2.0-0 \
    libnss3 \
    libnspr4 \
    libdbus-1-3 \
    libx11-xcb1 \
    libxcb1 \
    libxcomposite1 \
    libxdamage1 \
    libxext6 \
    libxfixes3 \
    libxi6 \
    libxrandr2 \
    libxrender1 \
    libxshmfence1 \
    libxtst6 \
    fonts-liberation \
    libatspi2.0-0 \
    libgbm1 \
    xdg-utils \
    && rm -rf /var/lib/apt/lists/*

# Establecer directorio de trabajo
WORKDIR /app

# Copiar primero solo las dependencias para aprovechar el caché de Docker
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Instalar los navegadores de Playwright dentro de la imagen
RUN playwright install chromium

# Copiar el resto del código
COPY . .

# Hacer ejecutable el script de inicio
RUN chmod +x start.sh

# Exponer puerto (ajusta si tu app usa otro, ej. 8000, 5000)
EXPOSE 8000

# Comando de inicio
CMD ["./start.sh"]
