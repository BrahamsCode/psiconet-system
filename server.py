#!/usr/bin/env python3
"""
Servidor Web Simple para Psiconet Sistema
Este script inicia un servidor web local en el puerto 8000
"""

import http.server
import socketserver
import webbrowser
import os
import sys
from pathlib import Path

# Configuración
PORT = 8000
DIRECTORY = str(Path(__file__).parent / "public")

class MyHTTPRequestHandler(http.server.SimpleHTTPRequestHandler):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, directory=DIRECTORY, **kwargs)
    
    def end_headers(self):
        self.send_header('Cache-Control', 'no-store, no-cache, must-revalidate')
        super().end_headers()

def start_server():
    """Inicia el servidor web"""
    try:
        # Cambiar al directorio del proyecto
        os.chdir(os.path.dirname(os.path.abspath(__file__)))
        
        # Crear el servidor
        with socketserver.TCPServer(("", PORT), MyHTTPRequestHandler) as httpd:
            print(f"""
╔═══════════════════════════════════════════════════╗
║                                                   ║
║        🧠 PSICONET SISTEMA INICIADO 🧠            ║
║                                                   ║
║   Servidor corriendo en: http://localhost:{PORT}    ║
║                                                   ║
║   Presiona Ctrl+C para detener el servidor       ║
║                                                   ║
╚═══════════════════════════════════════════════════╝
            """)
            
            # Abrir el navegador automáticamente
            webbrowser.open(f'http://localhost:{PORT}')
            
            # Mantener el servidor corriendo
            httpd.serve_forever()
            
    except KeyboardInterrupt:
        print("\n\n✅ Servidor detenido correctamente\n")
        sys.exit(0)
    except OSError as e:
        if e.errno == 48:  # Puerto ya en uso
            print(f"\n❌ Error: El puerto {PORT} ya está en uso.")
            print("   Cierra otras aplicaciones que puedan estar usando este puerto.\n")
        else:
            print(f"\n❌ Error: {e}\n")
        sys.exit(1)

if __name__ == "__main__":
    start_server()
