# Entorno: Ubuntu, Windows y macOS

Usa PostgreSQL 18 como referencia y la última revisión de mantenimiento disponible de esa versión. El SQL del curso también funciona con PostgreSQL 17. No mezcles instrucciones de MySQL, SQLite o SQL Server: comparten ideas, pero tienen diferencias de sintaxis y comportamiento.

Necesitas servidor PostgreSQL, el cliente `psql` y las herramientas `createdb`, `pg_dump` y `pg_restore`. pgAdmin es opcional. Python 3.11 o posterior se utiliza **solo para la comprobación automática**, no para aprender SQL. Usa herramientas cliente de la misma versión mayor que el servidor en las prácticas de respaldo.

## 1. Instalar según tu sistema

### Ubuntu

1. Consulta la [página oficial de Ubuntu](https://www.postgresql.org/download/linux/ubuntu/).
2. Para la versión que distribuye Ubuntu: `sudo apt update`, seguido de `sudo apt install postgresql postgresql-client`. Verifica qué versión instaló (una distribución puede ofrecer una versión anterior).
3. Si la distribución instaló una versión anterior a 17, o necesitas 18, sigue la sección oficial del repositorio PGDG (incluye su clave y la distribución compatible), luego instala `sudo apt install postgresql-18 postgresql-client-18`. No basta con pedir ese paquete si el repositorio no está configurado.
4. Comprueba el servicio con `sudo systemctl status postgresql`. Si no está iniciado, usa `sudo systemctl start postgresql`. En WSL el arranque del servicio puede variar según su configuración de systemd.
5. Abre una sesión administrativa local: `sudo -u postgres psql`. La autenticación local puede ser `peer`; la conexión por TCP que usaremos solicita contraseña.

### Windows

1. Ve a [descargas oficiales para Windows](https://www.postgresql.org/download/windows/) y sigue el enlace al instalador indicado allí.
2. Instala PostgreSQL 18, servidor y herramientas de línea de comandos. Recuerda el puerto (normalmente 5432) y conserva la contraseña administrativa fuera del repositorio.
3. Abre **SQL Shell (psql)** desde el menú de inicio. Indica servidor `localhost`, base `postgres`, puerto elegido, usuario `postgres` y tu contraseña.
4. Para trabajar en PowerShell, agrega la carpeta `bin` al PATH. Suele ser `C:\Program Files\PostgreSQL\18\bin`; verifica la ruta real. Para la sesión actual: `$env:Path = 'C:\Program Files\PostgreSQL\18\bin;' + $env:Path`.
5. Si no conecta, revisa que el servicio PostgreSQL esté iniciado desde Servicios de Windows. Cambiar PATH no inicia el servidor.

### macOS

1. Consulta [descargas oficiales para macOS](https://www.postgresql.org/download/macosx/). Elige **una** distribución (instalador, Postgres.app o Homebrew), evitando iniciar dos servidores en el mismo puerto.
2. Si usas Homebrew instalado: `brew install postgresql@18`, después `brew services start postgresql@18`.
3. Agrega las herramientas al PATH de la sesión: `export PATH="$(brew --prefix postgresql@18)/bin:$PATH"`. `brew --prefix` evita suponer una ruta Intel o Apple Silicon.
4. En Homebrew, el administrador inicial suele ser tu usuario del sistema. Conecta con `psql -d postgres`. Con el instalador, usa `psql -h localhost -U postgres -d postgres` y tu contraseña.
5. Comprueba el servicio con `brew services list` o la herramienta de la distribución elegida.

## 2. Crear una identidad y una base de práctica

Desde la sesión administrativa anterior, ejecuta una vez:

```sql
CREATE ROLE estudiante LOGIN;
```

En **psql**, establece la contraseña mediante `\password estudiante`. Ese comando solicita la clave sin escribirla como texto SQL en esta guía. Sal con `\q` cuando termines. No otorgues SUPERUSER al estudiante.

Crea la base desde la sesión administrativa:

```sql
CREATE DATABASE curso_sql OWNER estudiante;
```

`CREATE DATABASE` no puede ir dentro de `BEGIN`. Si la identidad o la base ya existen, inspecciónalas con `\du` y `\l`; no repitas la creación ni borres una base para resolver ese mensaje.

Desde terminal conecta como estudiante:

```text
psql -X -h localhost -p 5432 -U estudiante -d curso_sql
```

La clave se solicita interactivamente. Reemplaza el puerto si elegiste otro.

## 3. Ubicar el repositorio y cargar la tienda

Descarga el ZIP desde GitHub y descomprímelo, o usa `git clone https://github.com/lelyliliana/Curso-Bases-de-Datos-SQL.git`. Abre una terminal en su carpeta raíz. Si descargaste ZIP, el nombre puede terminar en `-main`; entra en la carpeta que realmente contiene `README.md`.

Ejecuta por separado, en este orden:

```text
psql -X -h localhost -U estudiante -d curso_sql -v ON_ERROR_STOP=1 -f ejemplos/tienda/01_schema.sql
psql -X -h localhost -U estudiante -d curso_sql -v ON_ERROR_STOP=1 -f ejemplos/tienda/02_datos.sql
psql -X -h localhost -U estudiante -d curso_sql -v ON_ERROR_STOP=1 -f ejemplos/tienda/03_consultas.sql
```

Estos comandos funcionan en Bash, PowerShell y Terminal de macOS si `psql` está en PATH. Usa comillas dobles si una ruta tiene espacios. No pegues las etiquetas de los bloques ni el prompt de una consola.

Los dos primeros scripts crean y cargan una vez. Si repites la carga, habrá errores de objetos existentes o claves únicas: los datos no se reinician automáticamente. Para empezar de nuevo sin perder trabajo, crea **otra base de práctica** con otro nombre y conéctate a ella.

Dentro de cada nueva conexión interactiva a la tienda:

```sql
SET search_path = tienda, public;
SET TIME ZONE 'UTC';
SELECT current_database(),current_user;
SELECT COUNT(*) FROM producto;
```

Resultado del último SELECT: `5`. `search_path` y la zona horaria son ajustes de sesión; no se transmiten a otras ventanas. Puedes escribir `tienda.producto` sin depender del primero. Los ejemplos sueltos de unidades iniciales son esquemas didácticos: no ejecutes otro `CREATE TABLE producto` sobre la tienda cargada. Usa sus laboratorios, que emplean transacciones o tablas temporales.

## 4. Ejecutar un laboratorio

Desde la raíz, por ejemplo:

```text
psql -X -h localhost -U estudiante -d curso_sql -v ON_ERROR_STOP=1 -f unidad14-joins/LABORATORIO.sql
```

Los laboratorios SQL terminan en `ROLLBACK` y se pueden repetir. Algunos crean objetos temporales. La Unidad 27 requiere una sesión administrativa para crear un rol de demostración, y la 24 necesita dos conexiones. Los comandos `\copy` y `\i` pertenecen a psql, no al editor SQL de pgAdmin. Cada laboratorio declara cómo ejecutarlo.

## 5. Diagnóstico de problemas

| Síntoma | Qué comprobar |
|---|---|
| `psql` no reconocido | PATH y carpeta `bin`, no la contraseña |
| `connection refused` | servicio, host, puerto y conflictos con otra instalación |
| `password authentication failed` | identidad, clave y método de autenticación configurado |
| `relation ... does not exist` | base seleccionada, esquema y carga de 01/02 |
| `current transaction is aborted` | `ROLLBACK` o `ROLLBACK TO SAVEPOINT` tras corregir la causa |
| error en `\copy` | ejecutarlo en psql y desde la raíz del repositorio |
| tildes ilegibles | archivos UTF-8 y `\encoding UTF8` en psql; en PowerShell moderno usa salida UTF-8 |

Anota `SELECT version();`, `psql --version`, sistema y comando exacto al investigar. No incluyas contraseñas en capturas ni reportes.

[Volver al índice](../README.md) · [Caso tienda](CASO_TIENDA.md) · [Verificación automática](VERIFICACION.md)
