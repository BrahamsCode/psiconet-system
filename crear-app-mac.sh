#!/bin/bash

# Script para crear la aplicación Mac de Psiconet Sistema

echo "🧠 Creando aplicación IniciarPsiconet.app..."

# Directorio del script
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$SCRIPT_DIR"

# Crear estructura de la aplicación
APP_NAME="IniciarPsiconet.app"
APP_PATH="$SCRIPT_DIR/$APP_NAME"

# Eliminar si ya existe
if [ -d "$APP_PATH" ]; then
    rm -rf "$APP_PATH"
fi

# Crear estructura de directorios
mkdir -p "$APP_PATH/Contents/MacOS"
mkdir -p "$APP_PATH/Contents/Resources"

# Crear el script ejecutable
cat > "$APP_PATH/Contents/MacOS/IniciarPsiconet" << 'EOF'
#!/bin/bash

# Obtener el directorio de la aplicación
APP_DIR="$(cd "$(dirname "$0")/../../.." && pwd)"

# Abrir Terminal y ejecutar el script de inicio
osascript -e "tell application \"Terminal\"
    do script \"cd '$APP_DIR' && ./start.sh\"
    activate
end tell"
EOF

# Dar permisos de ejecución
chmod +x "$APP_PATH/Contents/MacOS/IniciarPsiconet"

# Crear Info.plist
cat > "$APP_PATH/Contents/Info.plist" << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>CFBundleExecutable</key>
    <string>IniciarPsiconet</string>
    <key>CFBundleIconFile</key>
    <string>AppIcon</string>
    <key>CFBundleIdentifier</key>
    <string>com.psiconet.sistema</string>
    <key>CFBundleName</key>
    <string>Psiconet Sistema</string>
    <key>CFBundlePackageType</key>
    <string>APPL</string>
    <key>CFBundleShortVersionString</key>
    <string>1.0</string>
    <key>CFBundleVersion</key>
    <string>1.0</string>
    <key>LSMinimumSystemVersion</key>
    <string>10.12</string>
    <key>NSHighResolutionCapable</key>
    <true/>
</dict>
</plist>
EOF

# Crear un icono simple (opcional - se puede personalizar después)
# Por ahora usaremos el icono por defecto del sistema

echo ""
echo "✅ Aplicación creada exitosamente!"
echo ""
echo "📁 Ubicación: $APP_PATH"
echo ""
echo "Para usar el sistema:"
echo "1. Haz doble clic en IniciarPsiconet.app"
echo "2. El sistema se abrirá automáticamente en tu navegador"
echo ""
echo "💡 Tip: Puedes arrastrar IniciarPsiconet.app al Dock para acceso rápido"
echo ""
