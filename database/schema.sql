-- Estructura de la Base de Datos Psiconet Sistema
-- SQLite Database Schema

-- Tabla: consultantes
-- Almacena información básica de los consultantes/pacientes
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
);

-- Tabla: intervenciones
-- Almacena el registro de cada sesión/intervención psicológica
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
);

-- Índices para optimizar consultas
CREATE INDEX IF NOT EXISTS idx_consultantes_nombre ON consultantes(nombre);
CREATE INDEX IF NOT EXISTS idx_consultantes_fecha_registro ON consultantes(fecha_registro);
CREATE INDEX IF NOT EXISTS idx_intervenciones_consultante_id ON intervenciones(consultante_id);
CREATE INDEX IF NOT EXISTS idx_intervenciones_fecha ON intervenciones(fecha);

-- Trigger para actualizar updated_at automáticamente en consultantes
CREATE TRIGGER IF NOT EXISTS update_consultantes_timestamp 
AFTER UPDATE ON consultantes
BEGIN
    UPDATE consultantes SET updated_at = CURRENT_TIMESTAMP WHERE id = NEW.id;
END;

-- Trigger para actualizar updated_at automáticamente en intervenciones
CREATE TRIGGER IF NOT EXISTS update_intervenciones_timestamp 
AFTER UPDATE ON intervenciones
BEGIN
    UPDATE intervenciones SET updated_at = CURRENT_TIMESTAMP WHERE id = NEW.id;
END;

-- Datos de ejemplo (opcional - comentar si no se desean datos de prueba)
-- INSERT INTO consultantes (nombre, edad, telefono, email, fecha_registro) 
-- VALUES ('María García', 35, '987654321', 'maria@example.com', date('now'));

-- INSERT INTO intervenciones (consultante_id, numero_sesion, fecha, asistidos, actividades, terapeuta)
-- VALUES (1, 1, date('now'), 'Paciente', 'Primera sesión de evaluación. Se estableció rapport y se identificaron objetivos terapéuticos iniciales.', 'Dr. Juan Pérez');

-- Consultas útiles para administración
-- Ver todos los consultantes con su número de sesiones:
-- SELECT 
--     c.id,
--     c.nombre,
--     c.edad,
--     c.fecha_registro,
--     COUNT(i.id) as total_sesiones
-- FROM consultantes c
-- LEFT JOIN intervenciones i ON c.id = i.consultante_id
-- GROUP BY c.id
-- ORDER BY c.nombre;

-- Ver historial completo de un consultante:
-- SELECT 
--     i.numero_sesion,
--     i.fecha,
--     i.asistidos,
--     i.actividades,
--     i.terapeuta
-- FROM intervenciones i
-- WHERE i.consultante_id = ?
-- ORDER BY i.numero_sesion;

-- Estadísticas generales:
-- SELECT 
--     COUNT(DISTINCT c.id) as total_consultantes,
--     COUNT(i.id) as total_intervenciones,
--     AVG(sesiones.total) as promedio_sesiones
-- FROM consultantes c
-- LEFT JOIN intervenciones i ON c.id = i.consultante_id
-- LEFT JOIN (
--     SELECT consultante_id, COUNT(*) as total
--     FROM intervenciones
--     GROUP BY consultante_id
-- ) sesiones ON c.id = sesiones.consultante_id;
