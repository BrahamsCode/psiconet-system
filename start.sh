#!/bin/bash

# Script de inicialización de Psiconet Sistema
# Este script prepara la base de datos e inicia el servidor

set -e  # Salir si hay algún error

# Colores para output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Directorio del script
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$SCRIPT_DIR"

echo -e "${BLUE}"
echo "╔═══════════════════════════════════════════════════╗"
echo "║                                                   ║"
echo "║      🧠 INICIANDO PSICONET SISTEMA 🧠             ║"
echo "║                                                   ║"
echo "╚═══════════════════════════════════════════════════╝"
echo -e "${NC}"

# Verificar si existe la base de datos
DB_PATH="$SCRIPT_DIR/database/database.sqlite"

if [ ! -f "$DB_PATH" ]; then
    echo -e "${BLUE}📊 Creando base de datos...${NC}"
    
    # Usar el script Python para inicializar la base de datos
    python3 "$SCRIPT_DIR/init-database.py"
    
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✅ Base de datos creada exitosamente${NC}"
    else
        echo -e "${RED}❌ Error al crear la base de datos${NC}"
        exit 1
    fi
else
    echo -e "${GREEN}✅ Base de datos ya existe${NC}"
fi

# Dar permisos de ejecución al servidor
chmod +x "$SCRIPT_DIR/server.py"

# Iniciar el servidor
echo -e "${BLUE}🚀 Iniciando servidor web...${NC}\n"
python3 "$SCRIPT_DIR/server.py"
