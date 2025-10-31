# 🛣️ Rutas y API de Psiconet Sistema

## Rutas Web Principales

### Página Principal
- **URL:** `/`
- **Método:** GET
- **Descripción:** Redirige a la lista de consultantes
- **Controlador:** Redirect a `consultantes.index`

---

## Rutas de Consultantes

### Listar todos los consultantes
- **Nombre:** `consultantes.index`
- **URL:** `/consultantes`
- **Método:** GET
- **Descripción:** Muestra lista de todos los consultantes registrados
- **Controlador:** `ConsultanteController@index`
- **Vista:** `resources/views/consultantes/index.blade.php`

### Formulario para nuevo consultante
- **Nombre:** `consultantes.create`
- **URL:** `/consultantes/create`
- **Método:** GET
- **Descripción:** Muestra formulario para registrar nuevo consultante
- **Controlador:** `ConsultanteController@create`
- **Vista:** `resources/views/consultantes/create.blade.php`

### Guardar nuevo consultante
- **Nombre:** `consultantes.store`
- **URL:** `/consultantes`
- **Método:** POST
- **Descripción:** Procesa y guarda un nuevo consultante
- **Controlador:** `ConsultanteController@store`
- **Parámetros:**
  - `nombre` (string, requerido)
  - `edad` (integer, requerido, 0-120)
  - `telefono` (string, opcional)
  - `email` (email, opcional)
  - `observaciones` (text, opcional)
  - `fecha_registro` (date, requerido)
- **Redirección:** `consultantes.index`

### Ver detalles de consultante
- **Nombre:** `consultantes.show`
- **URL:** `/consultantes/{consultante}`
- **Método:** GET
- **Descripción:** Muestra información detallada del consultante y sus intervenciones
- **Controlador:** `ConsultanteController@show`
- **Vista:** `resources/views/consultantes/show.blade.php`
- **Parámetros:** `{consultante}` - ID del consultante

### Formulario de edición
- **Nombre:** `consultantes.edit`
- **URL:** `/consultantes/{consultante}/edit`
- **Método:** GET
- **Descripción:** Muestra formulario para editar consultante
- **Controlador:** `ConsultanteController@edit`
- **Vista:** `resources/views/consultantes/edit.blade.php`
- **Parámetros:** `{consultante}` - ID del consultante

### Actualizar consultante
- **Nombre:** `consultantes.update`
- **URL:** `/consultantes/{consultante}`
- **Método:** PUT/PATCH
- **Descripción:** Actualiza información del consultante
- **Controlador:** `ConsultanteController@update`
- **Parámetros:** Mismos que `store`
- **Redirección:** `consultantes.show`

### Eliminar consultante
- **Nombre:** `consultantes.destroy`
- **URL:** `/consultantes/{consultante}`
- **Método:** DELETE
- **Descripción:** Elimina consultante y todas sus intervenciones
- **Controlador:** `ConsultanteController@destroy`
- **Redirección:** `consultantes.index`

---

## Rutas de Intervenciones

### Formulario para nueva intervención
- **Nombre:** `intervenciones.create`
- **URL:** `/consultantes/{consultante}/intervenciones/create`
- **Método:** GET
- **Descripción:** Muestra formulario para registrar nueva intervención
- **Controlador:** `IntervencionController@create`
- **Vista:** `resources/views/intervenciones/create.blade.php`
- **Parámetros:** `{consultante}` - ID del consultante

### Guardar nueva intervención
- **Nombre:** `intervenciones.store`
- **URL:** `/consultantes/{consultante}/intervenciones`
- **Método:** POST
- **Descripción:** Procesa y guarda nueva intervención
- **Controlador:** `IntervencionController@store`
- **Parámetros:**
  - `fecha` (date, requerido)
  - `asistidos` (string, requerido)
  - `actividades` (text, requerido)
  - `terapeuta` (string, requerido)
- **Nota:** `numero_sesion` se asigna automáticamente
- **Redirección:** `consultantes.show`

### Formulario de edición de intervención
- **Nombre:** `intervenciones.edit`
- **URL:** `/intervenciones/{intervencion}/edit`
- **Método:** GET
- **Descripción:** Muestra formulario para editar intervención
- **Controlador:** `IntervencionController@edit`
- **Vista:** `resources/views/intervenciones/edit.blade.php`
- **Parámetros:** `{intervencion}` - ID de la intervención

### Actualizar intervención
- **Nombre:** `intervenciones.update`
- **URL:** `/intervenciones/{intervencion}`
- **Método:** PUT/PATCH
- **Descripción:** Actualiza información de la intervención
- **Controlador:** `IntervencionController@update`
- **Parámetros:** Mismos que `store` (excepto numero_sesion)
- **Redirección:** `consultantes.show`

### Eliminar intervención
- **Nombre:** `intervenciones.destroy`
- **URL:** `/intervenciones/{intervencion}`
- **Método:** DELETE
- **Descripción:** Elimina la intervención
- **Controlador:** `IntervencionController@destroy`
- **Redirección:** `consultantes.show`

---

## Estructura de Controladores

### ConsultanteController

```php
namespace App\Http\Controllers;

Métodos:
- index()          // GET  /consultantes
- create()         // GET  /consultantes/create
- store()          // POST /consultantes
- show()           // GET  /consultantes/{id}
- edit()           // GET  /consultantes/{id}/edit
- update()         // PUT  /consultantes/{id}
- destroy()        // DELETE /consultantes/{id}
```

### IntervencionController

```php
namespace App\Http\Controllers;

Métodos:
- create()         // GET  /consultantes/{id}/intervenciones/create
- store()          // POST /consultantes/{id}/intervenciones
- edit()           // GET  /intervenciones/{id}/edit
- update()         // PUT  /intervenciones/{id}
- destroy()        // DELETE /intervenciones/{id}
```

---

## Modelos Eloquent

### Consultante Model

```php
namespace App\Models;

Propiedades fillable:
- nombre
- edad
- telefono
- email
- observaciones
- fecha_registro

Relaciones:
- intervenciones() // hasMany

Casts:
- fecha_registro: date
```

### Intervencion Model

```php
namespace App\Models;

Propiedades fillable:
- consultante_id
- numero_sesion
- fecha
- asistidos
- actividades
- terapeuta

Relaciones:
- consultante() // belongsTo

Casts:
- fecha: date
```

---

## Ejemplos de Uso

### Crear un nuevo consultante (cURL)
```bash
curl -X POST http://localhost:8000/consultantes \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "nombre=Juan Pérez" \
  -d "edad=30" \
  -d "telefono=987654321" \
  -d "email=juan@example.com" \
  -d "fecha_registro=2024-01-15"
```

### Crear una nueva intervención (cURL)
```bash
curl -X POST http://localhost:8000/consultantes/1/intervenciones \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "fecha=2024-01-15" \
  -d "asistidos=Paciente" \
  -d "actividades=Primera sesión de evaluación" \
  -d "terapeuta=Dr. García"
```

---

## Validaciones

### Consultante
- `nombre`: requerido, string, máximo 255 caracteres
- `edad`: requerido, integer, entre 0 y 120
- `telefono`: opcional, string, máximo 20 caracteres
- `email`: opcional, email válido, máximo 255 caracteres
- `observaciones`: opcional, text
- `fecha_registro`: requerido, fecha válida

### Intervención
- `fecha`: requerido, fecha válida
- `asistidos`: requerido, string
- `actividades`: requerido, text
- `terapeuta`: requerido, string, máximo 255 caracteres
- `numero_sesion`: generado automáticamente

---

## Mensajes de Éxito

El sistema utiliza sesiones flash para mostrar mensajes:

- Consultante creado: "Consultante registrado exitosamente"
- Consultante actualizado: "Consultante actualizado exitosamente"
- Consultante eliminado: "Consultante eliminado exitosamente"
- Intervención creada: "Intervención registrada exitosamente"
- Intervención actualizada: "Intervención actualizada exitosamente"
- Intervención eliminada: "Intervención eliminada exitosamente"

---

## Navegación del Sistema

```
Inicio (/)
  ↓
Lista de Consultantes (/consultantes)
  ├── Nuevo Consultante (/consultantes/create)
  │     └── Guardar → Volver a Lista
  │
  └── Ver Consultante (/consultantes/{id})
        ├── Editar Consultante (/consultantes/{id}/edit)
        │     └── Actualizar → Volver a Detalles
        │
        ├── Nueva Intervención (/consultantes/{id}/intervenciones/create)
        │     └── Guardar → Volver a Detalles
        │
        └── Editar Intervención (/intervenciones/{id}/edit)
              └── Actualizar → Volver a Detalles
```

---

## Configuración de Base de Datos

```php
// .env
DB_CONNECTION=sqlite
DB_DATABASE=/ruta/al/database/database.sqlite

// config/database.php
'connections' => [
    'sqlite' => [
        'driver' => 'sqlite',
        'database' => env('DB_DATABASE', database_path('database.sqlite')),
        'foreign_key_constraints' => true,
    ],
]
```

---

## Notas Importantes

1. **Cascada en Eliminación:** Al eliminar un consultante, se eliminan automáticamente todas sus intervenciones (ON DELETE CASCADE)

2. **Números de Sesión:** Se asignan automáticamente de forma consecutiva basándose en el conteo de intervenciones existentes

3. **Timestamps:** Laravel mantiene automáticamente `created_at` y `updated_at` para cada registro

4. **Validación:** Todos los formularios tienen validación del lado del servidor

5. **Mensajes Flash:** Se usan sesiones para mostrar mensajes de éxito/error después de operaciones CRUD
