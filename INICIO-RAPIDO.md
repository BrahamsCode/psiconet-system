# 🚀 Guía de Inicio Rápido - Psiconet Sistema

## ⚡ En 3 Pasos

### 1️⃣ Preparar la Aplicación
```bash
cd psiconet-system
./crear-app-mac.sh
```

### 2️⃣ Iniciar el Sistema
Haz doble clic en: **IniciarPsiconet.app**

### 3️⃣ ¡Listo!
Tu navegador se abrirá automáticamente en `http://localhost:8000`

---

## 📋 Requisitos Previos

✅ macOS 10.12 o superior  
✅ Python 3 (ya incluido en Mac)  
✅ Navegador web moderno  

---

## 🎯 Primera Vez Usando el Sistema

### Paso 1: Registrar un Consultante
1. Click en **"Nuevo Consultante"**
2. Llena el formulario:
   - Nombre: María García
   - Edad: 35
   - Teléfono: 987654321
   - Fecha de registro: [Fecha actual]
3. Click en **"Guardar Consultante"**

### Paso 2: Registrar una Intervención
1. En la lista, click en **"Ver"** del consultante
2. Click en **"➕ Nueva Intervención"**
3. Llena el formulario:
   - Fecha: [Fecha actual]
   - Asistidos: Paciente
   - Actividades: Primera sesión de evaluación...
   - Terapeuta: Dr. Juan Pérez
4. Click en **"Guardar Intervención"**

### Paso 3: Ver el Historial
- En la página del consultante verás todas sus sesiones
- Cada sesión tiene su número consecutivo
- Puedes editar o eliminar cualquier registro

---

## ⌨️ Atajos de Teclado

- `Cmd + W` - Cerrar ventana del navegador
- `Cmd + R` - Recargar página
- `Ctrl + C` - Detener servidor (en Terminal)

---

## 🛑 Cómo Detener el Sistema

1. Ve a la ventana de Terminal que se abrió
2. Presiona `Ctrl + C`
3. El servidor se detendrá correctamente

---

## 📁 Ubicación de los Datos

Tu base de datos está en:
```
psiconet-system/database/database.sqlite
```

**💡 Tip:** Respalda este archivo regularmente para no perder tus datos.

---

## 🆘 Problemas Comunes

### El navegador no se abre automáticamente
**Solución:** Abre manualmente: http://localhost:8000

### Error "Puerto 8000 en uso"
**Solución:** Cierra otras aplicaciones que usen ese puerto, o edita `server.py` para usar otro puerto (ej: 8080)

### No puedo hacer doble clic en IniciarPsiconet.app
**Solución:** 
```bash
chmod +x IniciarPsiconet.app/Contents/MacOS/IniciarPsiconet
```

---

## 📞 Soporte Rápido

### Verificar Python
```bash
python3 --version
```
Debe mostrar: Python 3.x.x

### Verificar Base de Datos
```bash
ls -lh database/database.sqlite
```
Debe mostrar el archivo creado

### Ver Logs del Servidor
Los logs aparecen en la Terminal cuando ejecutas la aplicación

---

## 🎨 Personalización

### Cambiar Puerto del Servidor
Edita `server.py` línea 10:
```python
PORT = 8080  # Cambia 8000 por el puerto que prefieras
```

### Cambiar Nombre de la Aplicación
Edita `crear-app-mac.sh` línea 7:
```bash
APP_NAME="MiPsiconet.app"
```

---

## ✅ Checklist de Instalación

- [ ] Descargar/copiar carpeta psiconet-system
- [ ] Abrir Terminal
- [ ] Navegar a la carpeta del proyecto
- [ ] Ejecutar `./crear-app-mac.sh`
- [ ] Hacer doble clic en IniciarPsiconet.app
- [ ] Sistema funcionando ✨

---

## 🔐 Seguridad

- ✅ Todos los datos son locales (en tu Mac)
- ✅ No se envía nada a Internet
- ✅ No requiere conexión para funcionar
- ✅ Puedes usar FileVault para encriptar
- ✅ Incluye en Time Machine para respaldos

---

## 📊 Próximos Pasos

1. **Registra tus consultantes actuales**
2. **Documenta las sesiones realizadas**
3. **Mantén un registro ordenado**
4. **Respalda periódicamente**

---

## 🎓 Recursos Adicionales

- `README.md` - Documentación completa
- `RUTAS.md` - Rutas y API del sistema
- `database/schema.sql` - Estructura de la base de datos

---

**Versión:** 1.0.0  
**Soporte:** Sistema diseñado para uso privado  
**Última actualización:** 2024

---

## ⭐ Tips Pro

1. **Agrega al Dock:** Arrastra IniciarPsiconet.app al Dock para acceso rápido
2. **Alias en Finder:** Crea un alias para tener acceso desde el escritorio
3. **Respaldo Automático:** Usa Time Machine para respaldar automáticamente
4. **Datos de Prueba:** El sistema crea datos de ejemplo en la primera ejecución

---

¡Disfruta usando Psiconet Sistema! 🧠✨
