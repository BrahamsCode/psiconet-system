# 🧠 Psiconet Sistema

Sistema de Gestión de Intervenciones Psicológicas desarrollado con Laravel.

## 📋 Características

- ✅ Gestión completa de consultantes (pacientes)
- ✅ Registro de intervenciones psicológicas por sesión
- ✅ Historial completo de sesiones
- ✅ Base de datos SQLite local (sin necesidad de servidor externo)
- ✅ Interfaz moderna y fácil de usar
- ✅ Funciona 100% offline
- ✅ Inicio con un solo clic en Mac

## 🚀 Instalación y Uso en Mac

### Opción 1: Inicio Rápido (Recomendado)

1. **Crear la aplicación de inicio rápido:**
   ```bash
   cd psiconet-system
   ./crear-app-mac.sh
   ```

2. **Hacer doble clic en `IniciarPsiconet.app`**
   - El sistema se iniciará automáticamente
   - Se abrirá tu navegador en http://localhost:8000
   - ¡Listo para usar!

### Opción 2: Inicio Manual

1. **Abrir Terminal y navegar al directorio:**
   ```bash
   cd /ruta/a/psiconet-system
   ```

2. **Ejecutar el script de inicio:**
   ```bash
   ./start.sh
   ```

3. **Abrir navegador:**
   - Ir a: http://localhost:8000

## 📁 Estructura del Proyecto

```
psiconet-system/
├── app/
│   ├── Http/
│   │   └── Controllers/
│   │       ├── ConsultanteController.php
│   │       └── IntervencionController.php
│   └── Models/
│       ├── Consultante.php
│       └── Intervencion.php
├── database/
│   ├── migrations/
│   │   ├── 2024_01_01_000001_create_consultantes_table.php
│   │   └── 2024_01_01_000002_create_intervenciones_table.php
│   └── database.sqlite (se crea automáticamente)
├── resources/
│   └── views/
│       ├── layouts/
│       │   └── app.blade.php
│       ├── consultantes/
│       │   ├── index.blade.php
│       │   ├── create.blade.php
│       │   ├── show.blade.php
│       │   └── edit.blade.php
│       └── intervenciones/
│           ├── create.blade.php
│           └── edit.blade.php
├── routes/
│   └── web.php
├── public/
│   ├── index.html
│   └── demo.html
├── start.sh (script de inicio)
├── server.py (servidor web)
└── IniciarPsiconet.scpt (script de AppleScript)
```

## 💾 Base de Datos

El sistema utiliza SQLite con dos tablas principales:

### Tabla: consultantes
- `id` - ID único
- `nombre` - Nombre completo
- `edad` - Edad del consultante
- `telefono` - Teléfono (opcional)
- `email` - Email (opcional)
- `observaciones` - Notas adicionales
- `fecha_registro` - Fecha de registro
- `created_at` / `updated_at` - Timestamps

### Tabla: intervenciones
- `id` - ID único
- `consultante_id` - ID del consultante (Foreign Key)
- `numero_sesion` - Número de sesión
- `fecha` - Fecha de la intervención
- `asistidos` - Quiénes asistieron
- `actividades` - Descripción de actividades
- `terapeuta` - Nombre del terapeuta
- `created_at` / `updated_at` - Timestamps

## 🔧 Requisitos del Sistema

- macOS 10.12 o superior
- Python 3.x (ya viene instalado en Mac)
- SQLite3 (ya viene instalado en Mac)
- Navegador web moderno (Safari, Chrome, Firefox)

## 📖 Guía de Uso

### 1. Gestionar Consultantes

#### Crear Nuevo Consultante:
1. Click en "Nuevo Consultante" en la barra de navegación
2. Completar el formulario:
   - Nombre completo (requerido)
   - Edad (requerido)
   - Teléfono (opcional)
   - Email (opcional)
   - Fecha de registro (requerido)
   - Observaciones (opcional)
3. Click en "Guardar Consultante"

#### Ver Lista de Consultantes:
- La página principal muestra todos los consultantes registrados
- Información visible: ID, Nombre, Edad, Teléfono, Email, Número de sesiones
- Acciones disponibles: Ver detalles, Editar

#### Ver Detalles de Consultante:
- Click en "Ver" en cualquier consultante
- Muestra información completa del consultante
- Lista de todas sus intervenciones/sesiones
- Opciones para: agregar nueva intervención, editar datos, eliminar

### 2. Gestionar Intervenciones

#### Registrar Nueva Intervención:
1. Desde la página de detalles del consultante, click en "Nueva Intervención"
2. Completar el formulario:
   - Fecha de la sesión (requerido)
   - Asistidos - quiénes estuvieron presentes (requerido)
   - Actividades realizadas (requerido)
   - Terapeuta a cargo (requerido)
3. El número de sesión se asigna automáticamente
4. Click en "Guardar Intervención"

#### Ver Historial de Intervenciones:
- En la página de detalles del consultante
- Tabla con todas las sesiones registradas
- Información: N° sesión, Fecha, Asistidos, Actividades, Terapeuta

#### Editar Intervención:
- Click en "Editar" en cualquier intervención
- Modificar los campos necesarios
- Guardar cambios

## 🛡️ Seguridad y Privacidad

- ✅ Todos los datos se almacenan localmente en tu Mac
- ✅ No se envía información a servidores externos
- ✅ No requiere conexión a Internet
- ✅ Base de datos encriptable si usas FileVault en Mac
- ✅ Respaldo recomendado: incluir `database/database.sqlite` en Time Machine

## 🔄 Respaldos

Para respaldar tus datos:

```bash
# Copiar la base de datos
cp database/database.sqlite database/database_backup_$(date +%Y%m%d).sqlite

# O respaldar todo el proyecto
tar -czf psiconet_backup_$(date +%Y%m%d).tar.gz psiconet-system/
```

## 🐛 Solución de Problemas

### El servidor no inicia:
```bash
# Verificar que el puerto 8000 no esté en uso
lsof -i :8000

# Si está en uso, matar el proceso
kill -9 [PID]

# Intentar con otro puerto
python3 server.py --port 8080
```

### Error de permisos:
```bash
chmod +x start.sh
chmod +x server.py
```

### Base de datos corrupta:
```bash
# Verificar integridad
sqlite3 database/database.sqlite "PRAGMA integrity_check;"

# Si hay problemas, restaurar desde backup
cp database/database_backup_YYYYMMDD.sqlite database/database.sqlite
```

## 📞 Soporte

Si encuentras algún problema o tienes sugerencias:
1. Verifica que todos los archivos estén presentes
2. Revisa los logs en la terminal
3. Asegúrate de tener Python 3 instalado: `python3 --version`

## 📝 Licencia

Este sistema está diseñado para uso privado en consultorios de psicología.

## 🎯 Funcionalidades Futuras

- [ ] Exportar reportes a PDF
- [ ] Búsqueda avanzada de consultantes
- [ ] Estadísticas y gráficos
- [ ] Sistema de recordatorios de sesiones
- [ ] Multi-usuario con autenticación
- [ ] Backup automático

## 👥 Créditos

Desarrollado para gestión de intervenciones psicológicas.
Sistema Laravel + SQLite para uso local en Mac.

---

**Versión:** 1.0.0  
**Última actualización:** 2024  
**Compatibilidad:** macOS 10.12+
