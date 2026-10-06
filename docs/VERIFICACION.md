# Comprobación automática del curso

La comprobación usa un servidor PostgreSQL real y herramientas de respaldo. No emula SQL ni cambia tu base curso_sql: crea dos bases propias con prefijo `curso_sql_verificacion_` y sufijo aleatorio, y las elimina al terminar, incluso si una prueba falla. Usa solo un servidor **local de práctica**, con una identidad administrativa; se necesitan permisos para crear bases y roles temporales. No concedas esos privilegios a la identidad habitual del estudiante.

## 1. Preparar herramientas

Instala PostgreSQL 17 o 18, `psql`, `pg_dump`, `pg_restore` y Python 3.11 o posterior. Usa cliente y servidor de la misma versión mayor. Desde la raíz del repositorio crea un entorno Python:

Ubuntu/macOS:

```bash
python3 -m venv .venv
.venv/bin/python -m pip install -r requirements.txt
```

Windows (PowerShell):

```powershell
py -m venv .venv
.venv\Scripts\python.exe -m pip install -r requirements.txt
```

psycopg se utiliza para comprobar resultados, errores y conexiones simultáneas. No es un requisito de las prácticas de SQL manuales. Si Python Ubuntu no puede crear el entorno, instala el paquete `python3-venv` correspondiente.

## 2. Indicar la conexión administrativa local

Bash en Ubuntu/macOS:

```bash
export PGHOST=localhost
export PGPORT=5432
export PGUSER=postgres
.venv/bin/python scripts/verificar.py
```

PowerShell en Windows:

```powershell
$env:PGHOST='localhost'
$env:PGPORT='5432'
$env:PGUSER='postgres'
.venv\Scripts\python.exe scripts/verificar.py
```

Reemplaza `postgres` por el administrador real de tu instalación (Homebrew puede usar tu nombre de usuario). Configura autenticación de las herramientas de libpq con un archivo de contraseñas local protegido: [documentación de .pgpass](https://www.postgresql.org/docs/18/libpq-pgpass.html). En Unix se ubica en tu directorio personal con permisos 0600; en Windows usa `%APPDATA%\postgresql\pgpass.conf`. El formato es host:puerto:base:usuario:contraseña; usa las bases temporales previstas o una entrada local adecuada para el ejercicio. Ese archivo permanece fuera del repositorio.

El verificador no solicita contraseñas interactivas. No pongas una clave real en el comando, un README o un archivo versionado. La automatización de GitHub usa un servidor temporal del runner con autenticación de prueba; no representa una configuración de producción.

## 3. Qué se comprueba

- 33 unidades, prácticas, soluciones y enlaces relativos existentes.
- Carga de tienda, consultas y métricas con valores esperados independientes.
- Los 28 laboratorios SQL (04–31), 27 soluciones SQL (04–30) y la ampliación de CTE/ventanas.
- Repetibilidad y conservación de filas después de rollback.
- Rechazos reales de PK/UNIQUE, NOT NULL, CHECK y FK con SQLSTATE específico.
- CASCADE, estado abortado y recuperación mediante savepoint.
- Lectura/escritura permitida o denegada con roles diferentes.
- COPY/\copy, clasificación de seis filas, exportación e importación.
- Dos conexiones reales: bloqueo, READ COMMITTED, REPEATABLE READ y anomalía evitada por SERIALIZABLE.
- Biblioteca: préstamo, devolución, idempotencia, errores y dos solicitudes simultáneas al mismo ejemplar.
- pg_dump custom, pg_restore en otro destino, comparación de valores, vistas, índices, restricciones, funciones y reaplicación de revocaciones base y permisos de demostración.

## 4. Interpretar la salida

Se muestra versión real del servidor y una línea `OK` al completar. Los logs de scripts se guardan en `salidas/`, excluido de Git. El número de comprobaciones incluye navegación y estructura documental además de las pruebas de base de datos; no equivale al número de escenarios SQL.

Un fallo detiene la verificación y señala su causa. Revisa `salidas/` y el mensaje: distinguir entorno, permisos y error de consulta evita modificar SQL correcto para ocultar un problema de conexión. Las pruebas no establecen un tiempo universal para planes ni garantizan ausencia de todos los posibles defectos.

La [automatización](../.github/workflows/verificar.yml) comprueba PostgreSQL 17 en Ubuntu, Windows y macOS, y PostgreSQL 18 en Ubuntu/macOS. En Windows esa acción usa la versión 17 provista por el runner; las instrucciones de instalación permiten trabajar con 18 y el SQL compartido se prueba también en 18 en las otras plataformas.

[Índice](../README.md) · [Entorno manual](ENTORNO.md)
