#!/bin/bash

# Script de Respaldo de Base de Datos - Psiconet Sistema
# Crea una copia de seguridad de la base de datos con fecha y hora

set -e

# Colores
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Directorio del script
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$SCRIPT_DIR"

echo -e "${BLUE}"
echo "╔═══════════════════════════════════════════════════╗"
echo "║                                                   ║"
echo "║     🧠 RESPALDO DE BASE DE DATOS 🧠               ║"
echo "║                                                   ║"
echo "╚═══════════════════════════════════════════════════╝"
echo -e "${NC}"

# Rutas
DB_PATH="$SCRIPT_DIR/database/database.sqlite"
BACKUP_DIR="$SCRIPT_DIR/database/backups"

# Verificar que existe la base de datos
if [ ! -f "$DB_PATH" ]; then
    echo -e "${YELLOW}⚠️  No se encontró la base de datos en: $DB_PATH${NC}"
    echo "   Asegúrate de haber iniciado el sistema al menos una vez."
    exit 1
fi

# Crear directorio de backups si no existe
if [ ! -d "$BACKUP_DIR" ]; then
    echo -e "${BLUE}📁 Creando directorio de respaldos...${NC}"
    mkdir -p "$BACKUP_DIR"
fi

# Generar nombre del backup con fecha y hora
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
BACKUP_NAME="psiconet_backup_${TIMESTAMP}.sqlite"
BACKUP_PATH="$BACKUP_DIR/$BACKUP_NAME"

# Copiar base de datos
echo -e "${BLUE}💾 Creando respaldo...${NC}"
cp "$DB_PATH" "$BACKUP_PATH"

# Verificar que se creó correctamente
if [ -f "$BACKUP_PATH" ]; then
    # Obtener tamaño del archivo
    SIZE=$(du -h "$BACKUP_PATH" | cut -f1)
    
    echo -e "${GREEN}"
    echo "✅ Respaldo creado exitosamente!"
    echo ""
    echo "📊 Información del respaldo:"
    echo "   📁 Ubicación: $BACKUP_PATH"
    echo "   💾 Tamaño: $SIZE"
    echo "   🕐 Fecha: $(date '+%Y-%m-%d %H:%M:%S')"
    echo -e "${NC}"
    
    # Contar registros en la base de datos
    if command -v sqlite3 &> /dev/null; then
        CONSULTANTES=$(sqlite3 "$BACKUP_PATH" "SELECT COUNT(*) FROM consultantes;")
        INTERVENCIONES=$(sqlite3 "$BACKUP_PATH" "SELECT COUNT(*) FROM intervenciones;")
        
        echo -e "${BLUE}📈 Datos respaldados:${NC}"
        echo "   👥 Consultantes: $CONSULTANTES"
        echo "   📋 Intervenciones: $INTERVENCIONES"
        echo ""
    fi
    
    # Listar backups existentes
    echo -e "${BLUE}📚 Respaldos disponibles:${NC}"
    ls -lh "$BACKUP_DIR" | grep "\.sqlite$" | awk '{print "   " $9 " (" $5 ")"}'
    echo ""
    
    # Limpiar backups antiguos (mantener solo los últimos 10)
    BACKUP_COUNT=$(ls -1 "$BACKUP_DIR"/*.sqlite 2>/dev/null | wc -l)
    if [ $BACKUP_COUNT -gt 10 ]; then
        echo -e "${YELLOW}🧹 Limpiando backups antiguos (manteniendo los últimos 10)...${NC}"
        cd "$BACKUP_DIR"
        ls -t *.sqlite | tail -n +11 | xargs rm -f
        echo -e "${GREEN}✅ Limpieza completada${NC}"
        echo ""
    fi
    
    echo -e "${GREEN}💡 Tip: Guarda este respaldo en un lugar seguro (USB, cloud, etc.)${NC}"
    
else
    echo -e "${YELLOW}❌ Error al crear el respaldo${NC}"
    exit 1
fi

# Preguntar si se desea abrir el directorio de backups
echo ""
read -p "¿Deseas abrir el directorio de respaldos? (s/n): " -n 1 -r
echo ""
if [[ $REPLY =~ ^[Ss]$ ]]; then
    open "$BACKUP_DIR"
fi
