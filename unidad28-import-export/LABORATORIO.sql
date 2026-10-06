-- Unidad 28: ¿Cómo cargar un CSV sin perder los valores crudos de filas rechazadas?
-- Ejecutar desde la raíz con psql -X -v ON_ERROR_STOP=1 -f unidad28-import-export/LABORATORIO.sql
-- Requiere tienda cargada; Unidad 27 requiere administrador con CREATEROLE.
BEGIN;
SET LOCAL search_path = tienda, public;
SET LOCAL TIME ZONE 'UTC';
CREATE TEMP TABLE carga_lab(fuente text,nombre_raw text,correo_raw text);
\copy carga_lab FROM 'datos/clientes_importacion.csv' WITH (FORMAT csv,HEADER true,ENCODING 'UTF8')
CREATE TEMP VIEW clasificacion_lab AS
WITH normalizado AS (
 SELECT *,btrim(nombre_raw) AS nombre,lower(btrim(correo_raw)) AS correo FROM carga_lab
), repetidos AS (
 SELECT *,COUNT(*) OVER(PARTITION BY correo) AS repeticiones FROM normalizado
)
SELECT *,CASE WHEN nombre IS NULL OR nombre='' THEN 'NOMBRE_VACIO'
 WHEN correo IS NULL OR correo='' THEN 'CORREO_VACIO'
 WHEN repeticiones>1 THEN 'CORREO_REPETIDO' ELSE 'ACEPTADO' END AS regla FROM repetidos;
SELECT regla,COUNT(*) FROM clasificacion_lab GROUP BY regla ORDER BY regla;
CREATE TEMP TABLE destino_lab(nombre text NOT NULL,correo text NOT NULL UNIQUE);
INSERT INTO destino_lab SELECT nombre,correo FROM clasificacion_lab WHERE regla='ACEPTADO';
SELECT nombre,correo FROM destino_lab ORDER BY correo;
ROLLBACK;
