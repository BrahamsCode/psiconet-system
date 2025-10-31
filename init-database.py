#!/usr/bin/env python3
"""
Script para inicializar la base de datos SQLite de Psiconet Sistema
"""

import sqlite3
import os
from datetime import datetime

# Ruta a la base de datos
DB_PATH = os.path.join(os.path.dirname(__file__), 'database', 'database.sqlite')

def init_database():
    """Inicializa la base de datos con las tablas necesarias"""
    
    print("🔧 Inicializando base de datos...")
    
    # Conectar a la base de datos (se crea si no existe)
    conn = sqlite3.connect(DB_PATH)
    cursor = conn.cursor()
    
    # Crear tabla de consultantes
    cursor.execute('''
        CREATE TABLE IF NOT EXISTS consultantes (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nombre TEXT NOT NULL,
            edad INTEGER NOT NULL,
            telefono TEXT,
            email TEXT,
            observaciones TEXT,
            fecha_registro DATE NOT NULL,
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        )
    ''')
    
    # Crear tabla de intervenciones
    cursor.execute('''
        CREATE TABLE IF NOT EXISTS intervenciones (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            consultante_id INTEGER NOT NULL,
            numero_sesion INTEGER NOT NULL,
            fecha DATE NOT NULL,
            asistidos TEXT NOT NULL,
            actividades TEXT NOT NULL,
            terapeuta TEXT NOT NULL,
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            FOREIGN KEY (consultante_id) REFERENCES consultantes(id) ON DELETE CASCADE
        )
    ''')
    
    # Crear índices
    cursor.execute('CREATE INDEX IF NOT EXISTS idx_consultantes_nombre ON consultantes(nombre)')
    cursor.execute('CREATE INDEX IF NOT EXISTS idx_consultantes_fecha_registro ON consultantes(fecha_registro)')
    cursor.execute('CREATE INDEX IF NOT EXISTS idx_intervenciones_consultante_id ON intervenciones(consultante_id)')
    cursor.execute('CREATE INDEX IF NOT EXISTS idx_intervenciones_fecha ON intervenciones(fecha)')
    
    # Crear triggers para actualizar updated_at
    cursor.execute('''
        CREATE TRIGGER IF NOT EXISTS update_consultantes_timestamp 
        AFTER UPDATE ON consultantes
        BEGIN
            UPDATE consultantes SET updated_at = CURRENT_TIMESTAMP WHERE id = NEW.id;
        END
    ''')
    
    cursor.execute('''
        CREATE TRIGGER IF NOT EXISTS update_intervenciones_timestamp 
        AFTER UPDATE ON intervenciones
        BEGIN
            UPDATE intervenciones SET updated_at = CURRENT_TIMESTAMP WHERE id = NEW.id;
        END
    ''')
    
    # Verificar si ya hay datos
    cursor.execute('SELECT COUNT(*) FROM consultantes')
    count = cursor.fetchone()[0]
    
    # Si no hay datos, insertar datos de ejemplo
    if count == 0:
        print("📊 Creando datos de ejemplo...")
        
        # Insertar consultante de ejemplo
        cursor.execute('''
            INSERT INTO consultantes (nombre, edad, telefono, email, fecha_registro) 
            VALUES (?, ?, ?, ?, ?)
        ''', ('María García', 35, '987654321', 'maria@example.com', datetime.now().date()))
        
        consultante_id = cursor.lastrowid
        
        # Insertar intervención de ejemplo
        cursor.execute('''
            INSERT INTO intervenciones (consultante_id, numero_sesion, fecha, asistidos, actividades, terapeuta)
            VALUES (?, ?, ?, ?, ?, ?)
        ''', (
            consultante_id,
            1,
            datetime.now().date(),
            'Paciente',
            'Primera sesión de evaluación. Se estableció rapport y se identificaron objetivos terapéuticos iniciales.',
            'Dr. Juan Pérez'
        ))
    
    # Guardar cambios
    conn.commit()
    
    # Mostrar estadísticas
    cursor.execute('SELECT COUNT(*) FROM consultantes')
    total_consultantes = cursor.fetchone()[0]
    
    cursor.execute('SELECT COUNT(*) FROM intervenciones')
    total_intervenciones = cursor.fetchone()[0]
    
    print(f"✅ Base de datos inicializada correctamente")
    print(f"   📊 Consultantes: {total_consultantes}")
    print(f"   📋 Intervenciones: {total_intervenciones}")
    
    # Cerrar conexión
    conn.close()

def check_database():
    """Verifica la integridad de la base de datos"""
    if not os.path.exists(DB_PATH):
        print("❌ Base de datos no encontrada")
        return False
    
    try:
        conn = sqlite3.connect(DB_PATH)
        cursor = conn.cursor()
        
        # Verificar integridad
        cursor.execute('PRAGMA integrity_check')
        result = cursor.fetchone()[0]
        
        conn.close()
        
        if result == 'ok':
            print("✅ Base de datos verificada correctamente")
            return True
        else:
            print(f"⚠️  Problemas de integridad: {result}")
            return False
    except Exception as e:
        print(f"❌ Error al verificar base de datos: {e}")
        return False

if __name__ == '__main__':
    print("""
╔═══════════════════════════════════════════════════╗
║                                                   ║
║   🧠 PSICONET SISTEMA - INICIALIZACIÓN DE BD      ║
║                                                   ║
╚═══════════════════════════════════════════════════╝
    """)
    
    # Crear directorio de base de datos si no existe
    db_dir = os.path.dirname(DB_PATH)
    if not os.path.exists(db_dir):
        os.makedirs(db_dir)
    
    # Inicializar base de datos
    try:
        init_database()
        check_database()
        print("\n✨ ¡Sistema listo para usar!\n")
    except Exception as e:
        print(f"\n❌ Error durante la inicialización: {e}\n")
        exit(1)
