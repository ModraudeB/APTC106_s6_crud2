# Simple CRUD con Django

Un proyecto CRUD (Crear, Leer, Actualizar, Borrar) simple hecho con Django. Utiliza vistas basadas en funciones y el sistema de autenticación de Django.

Este proyecto ha sido actualizado para funcionar con Django 4.2 y versiones más recientes de sus dependencias.

## Instrucciones de Instalación (Windows con PowerShell)

Sigue estos pasos para poner en marcha el proyecto en un entorno de desarrollo local.

### 1. Crear y activar el entorno virtual

Un entorno virtual aísla las dependencias de tu proyecto.

```powershell
# Crear el entorno virtual en el directorio raíz del workspace
python -m venv venv

# Activar el entorno virtual
.\venv\Scripts\Activate.ps1
```

**Nota sobre la política de ejecución:** Si al activar el entorno recibes un error de `UnauthorizedAccess`, ejecuta el siguiente comando para permitir scripts en tu sesión actual de PowerShell y vuelve a intentar activarlo:

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope Process
```

### 2. Instalar dependencias

Una vez activado el entorno virtual (verás `(venv)` al inicio de la línea de comandos), instala las librerías necesarias.

```powershell
pip install -r requierements.txt
```

### 3. Aplicar las migraciones de la base de datos

Estos comandos preparan la base de datos para la aplicación.

```powershell
python manage.py makemigrations
python manage.py migrate
```

### 4. Iniciar el servidor de desarrollo

Finalmente, inicia el servidor para ver la aplicación en funcionamiento.

```powershell
python manage.py runserver
```

La aplicación estará disponible en `http://127.0.0.1:8000/`.
