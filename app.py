import os
import logging
from datetime import datetime
from flask import Flask, jsonify
# from playwright.sync_api import sync_playwright # Descomenta si usas Playwright

# Configuración básica
app = Flask(__name__)
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

# Puerto por defecto para Railway
PORT = int(os.environ.get('PORT', 8000))

@app.route('/')
def home():
    return jsonify({
        "status": "running",
        "message": "ImmRTX is active on Railway",
        "timestamp": datetime.now().isoformat()
    })

@app.route('/health')
def health():
    return jsonify({"status": "healthy"}), 200

# Ejemplo de uso de Playwright (Sincrónico para estabilidad)
@app.route('/scrape')
def scrape_example():
    try:
        # from playwright.sync_api import sync_playwright
        # with sync_playwright() as p:
        #     browser = p.chromium.launch(headless=True)
        #     page = browser.new_page()
        #     page.goto('https://example.com')
        #     title = page.title()
        #     browser.close()
        #     return jsonify({"title": title})
        
        # Placeholder para cuando implementes la lógica real
        return jsonify({"message": "Playwright integration ready"})
    except Exception as e:
        logger.error(f"Error scraping: {e}")
        return jsonify({"error": str(e)}), 500

if __name__ == '__main__':
    # En producción, Railway inyecta el puerto vía variable de entorno
    # Pero para desarrollo local:
    host = os.getenv('HOST', '0.0.0.0')
    app.run(host=host, port=PORT, debug=False)
