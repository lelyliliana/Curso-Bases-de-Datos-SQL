# Guía práctica de psql

Sigue primero [ENTORNO.md](../docs/ENTORNO.md). Conexión explícita:

```text
psql -X -h localhost -U estudiante -d curso_sql
```

`-X` evita que un archivo de configuración personal cambie los resultados de un script. Dentro de psql:

```text
\conninfo
\encoding UTF8
\dt tienda.*
\d tienda.producto
\l
\du
\q
```

SQL termina con punto y coma; estos comandos empiezan por barra invertida y no necesitan punto y coma. `\c curso_sql` cambia de base; comprueba conexión con `\conninfo`. `\i ruta.sql` resuelve la ruta desde la carpeta actual del cliente; `\ir ruta.sql` desde la carpeta del archivo que lo contiene. Por eso los accesos históricos de práctica utilizan `\ir`.

Para cargar scripts usa `-v ON_ERROR_STOP=1`: psql retorna un código de error al encontrar un fallo. Si el script deja una transacción abortada en una sesión interactiva, ejecuta ROLLBACK antes de continuar. La [tienda](../docs/CASO_TIENDA.md) está en el esquema tienda; ajusta search_path o utiliza nombres cualificados.

`\copy` usa archivos del equipo cliente. COPY con una ruta de archivo utiliza el equipo servidor y requiere permisos distintos. En pgAdmin puedes ejecutar SQL, pero estos comandos de psql no son sentencias SQL.

[Unidad](README.md)
