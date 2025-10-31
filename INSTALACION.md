# 📦 Instalación de Psiconet Sistema

## 🎯 Instalación Completa en Mac

### Paso 1: Descomprimir el Proyecto

```bash
# Opción 1: Usando Finder (Interfaz Gráfica)
# 1. Hacer doble clic en psiconet-sistema-completo.tar.gz
# 2. Se creará automáticamente la carpeta psiconet-system

# Opción 2: Usando Terminal
tar -xzf psiconet-sistema-completo.tar.gz
```

### Paso 2: Navegar al Proyecto

```bash
cd psiconet-system
```

### Paso 3: Crear la Aplicación de Mac

```bash
./crear-app-mac.sh
```

Este script creará `IniciarPsiconet.app`

### Paso 4: ¡Usar el Sistema!

Simplemente haz doble clic en `IniciarPsiconet.app` y el sistema se abrirá automáticamente en tu navegador.

---

## 📋 Contenido del Paquete

El archivo `psiconet-sistema-completo.tar.gz` contiene:

```
psiconet-system/
├── 📱 APLICACIÓN
│   ├── IniciarPsiconet.scpt       # Script de AppleScript
│   ├── crear-app-mac.sh           # Crea la aplicación .app
│   ├── start.sh                   # Script de inicio del sistema
│   ├── server.py                  # Servidor web Python
│   └── init-database.py           # Inicializador de BD
│
├── 🗄️ BASE DE DATOS
│   └── database/
│       ├── migrations/            # Migraciones de Laravel
│       ├── seeders/               # Semillas de datos
│       ├── schema.sql             # Esquema SQL
│       └── backups/               # Directorio de respaldos
│
├── 💻 CÓDIGO LARAVEL
│   ├── app/
│   │   ├── Http/Controllers/     # Controladores
│   │   └── Models/               # Modelos Eloquent
│   ├── resources/views/          # Vistas Blade
│   ├── routes/web.php            # Rutas web
│   └── config/                   # Configuración
│
├── 🌐 INTERFAZ WEB
│   └── public/
│       ├── index.html            # Página de inicio
│       └── demo.html             # Demo funcional
│
├── 📚 DOCUMENTACIÓN
│   ├── README.md                 # Documentación completa
│   ├── INICIO-RAPIDO.md          # Guía rápida
│   ├── RUTAS.md                  # Rutas y API
│   └── INSTALACION.md            # Este archivo
│
└── 🛠️ UTILIDADES
    └── backup.sh                 # Script de respaldo
```

---

## ⚙️ Configuración

### Variables de Entorno (.env)

El proyecto incluye un archivo `.env` preconfigurado:

```env
APP_NAME="Psiconet Sistema"
DB_CONNECTION=sqlite
DB_DATABASE=/ruta/al/database/database.sqlite
```

No necesitas modificar nada para empezar a usar el sistema.

### Puerto del Servidor

Por defecto, el sistema usa el puerto **8000**. Para cambiarlo:

```python
# Edita server.py, línea 10
PORT = 8080  # Cambia al puerto deseado
```

---

## 🔧 Requisitos del Sistema

### Obligatorios (Ya incluidos en Mac)
- ✅ macOS 10.12 o superior
- ✅ Python 3.x
- ✅ SQLite3

### Opcionales
- Navegador web moderno (Safari, Chrome, Firefox)
- Terminal (incluido en Mac)

---

## 🚀 Verificación de la Instalación

### 1. Verificar Python

```bash
python3 --version
```

Debe mostrar: `Python 3.x.x`

### 2. Verificar Estructura del Proyecto

```bash
ls -la psiconet-system/
```

Deberías ver todos los directorios y archivos listados arriba.

### 3. Verificar Permisos de Ejecución

```bash
ls -l *.sh *.py
```

Los archivos deben tener permisos de ejecución (`-rwxr-xr-x`)

Si no los tienen:

```bash
chmod +x start.sh crear-app-mac.sh backup.sh server.py init-database.py
```

---

## 🐛 Solución de Problemas

### Error: "Permission denied"

```bash
chmod +x start.sh
chmod +x crear-app-mac.sh
chmod +x backup.sh
chmod +x server.py
chmod +x init-database.py
```

### Error: "python3: command not found"

Python 3 viene instalado por defecto en macOS 10.15+. Si tienes una versión anterior:

```bash
# Instalar Homebrew (si no lo tienes)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Instalar Python 3
brew install python3
```

### Error: "Port 8000 already in use"

Otro programa está usando el puerto 8000:

```bash
# Ver qué programa usa el puerto
lsof -i :8000

# Matar el proceso (reemplaza PID con el número mostrado)
kill -9 PID

# O cambia el puerto en server.py
```

### Error al Crear la Aplicación

```bash
# Elimina la app existente
rm -rf IniciarPsiconet.app

# Vuelve a crearla
./crear-app-mac.sh
```

### Base de Datos No Se Crea

```bash
# Ejecuta manualmente el inicializador
python3 init-database.py

# Verifica que se creó
ls -lh database/database.sqlite
```

---

## 📱 Uso Diario

### Iniciar el Sistema

**Opción 1: Doble clic**
- Haz doble clic en `IniciarPsiconet.app`

**Opción 2: Terminal**
```bash
cd psiconet-system
./start.sh
```

### Acceder al Sistema

Abre tu navegador y ve a: `http://localhost:8000`

### Detener el Sistema

En la Terminal donde se está ejecutando, presiona: `Ctrl + C`

### Hacer Respaldo

```bash
cd psiconet-system
./backup.sh
```

---

## 🔐 Seguridad y Privacidad

- ✅ **100% Local:** Todos los datos se almacenan en tu Mac
- ✅ **Sin Internet:** No requiere conexión para funcionar
- ✅ **Sin Servidores Externos:** No se envía información a ningún lugar
- ✅ **Encriptación:** Usa FileVault en Mac para encriptar tus datos
- ✅ **Respaldos:** Incluye herramienta de respaldo automático

---

## 📊 Primeros Pasos

### 1. Crear tu Primer Consultante

1. Abre el sistema (http://localhost:8000)
2. Click en "Nuevo Consultante"
3. Llena el formulario
4. Guarda

### 2. Registrar una Sesión

1. En la lista de consultantes, click en "Ver"
2. Click en "➕ Nueva Intervención"
3. Llena los detalles de la sesión
4. Guarda

### 3. Ver Historial

- Desde la página del consultante verás todas sus sesiones
- Puedes editar o eliminar cualquier registro

---

## 🔄 Actualizar el Sistema

Si recibes una nueva versión:

1. **Respalda tu base de datos:**
   ```bash
   ./backup.sh
   ```

2. **Descomprime la nueva versión**

3. **Copia tu base de datos:**
   ```bash
   cp database/database.sqlite [ruta-nueva-version]/database/
   ```

4. **Usa la nueva versión**

---

## 💾 Política de Respaldos Recomendada

### Respaldos Manuales

```bash
# Crear respaldo manual
./backup.sh

# Los respaldos se guardan en:
database/backups/
```

### Respaldos Automáticos con Time Machine

1. Activa Time Machine en Mac
2. Tu proyecto será respaldado automáticamente
3. Puedes recuperar versiones anteriores

### Respaldo en la Nube

```bash
# Copia el archivo de BD a iCloud Drive, Dropbox, etc.
cp database/database.sqlite ~/iCloud\ Drive/Backups/
```

---

## 🎨 Personalización

### Cambiar el Nombre de la Aplicación

Edita `crear-app-mac.sh`:

```bash
APP_NAME="MiSistemaPsico.app"
```

### Personalizar Colores

Edita `resources/views/layouts/app.blade.php` y modifica los colores CSS.

### Agregar Logo Personalizado

Reemplaza el emoji 🧠 en las vistas con tu logo personalizado.

---

## 📞 Soporte

### Logs del Sistema

Los logs aparecen en la Terminal cuando ejecutas el sistema.

### Verificar Integridad de la Base de Datos

```bash
sqlite3 database/database.sqlite "PRAGMA integrity_check;"
```

Debe mostrar: `ok`

### Restaurar desde Respaldo

```bash
# Lista respaldos disponibles
ls -lh database/backups/

# Restaurar un respaldo específico
cp database/backups/psiconet_backup_YYYYMMDD_HHMMSS.sqlite database/database.sqlite
```

---

## ✨ Características Principales

- ✅ Gestión completa de consultantes
- ✅ Registro de sesiones/intervenciones
- ✅ Historial completo por consultante
- ✅ Base de datos local SQLite
- ✅ Interfaz moderna y responsive
- ✅ No requiere Internet
- ✅ Respaldos automáticos
- ✅ Inicio con un click

---

## 🎯 Próximas Funcionalidades

En futuras versiones:
- Exportar reportes a PDF
- Estadísticas y gráficos
- Búsqueda avanzada
- Sistema de recordatorios
- Multi-usuario

---

## 📝 Notas Finales

- **Versión:** 1.0.0
- **Compatible con:** macOS 10.12+
- **Tecnologías:** Laravel, SQLite, Python
- **Licencia:** Uso privado

---

## 🙏 Agradecimientos

Sistema desarrollado para facilitar la gestión de intervenciones psicológicas de manera profesional y segura.

---

**¿Listo para empezar? ¡Sigue los pasos de instalación arriba!** 🚀

Para más información, consulta:
- `README.md` - Documentación completa
- `INICIO-RAPIDO.md` - Guía de inicio rápido
- `RUTAS.md` - Documentación de rutas y API
