-- Unidad 30: ¿Cómo medir calidad y conservar el dato original antes de corregir espacios?
-- Ejecutar desde la raíz con psql -X -v ON_ERROR_STOP=1 -f unidad30-calidad/LABORATORIO.sql
-- Requiere tienda cargada; Unidad 27 requiere administrador con CREATEROLE.
BEGIN;
SET LOCAL search_path = tienda, public;
SET LOCAL TIME ZONE 'UTC';
CREATE TEMP TABLE calidad_lab(id integer PRIMARY KEY,nombre_raw text,precio_raw text);
INSERT INTO calidad_lab VALUES(1,'  Libro  ','80.00'),(2,'Teclado','-5'),(3,'','abc'),(4,NULL,'25');
SELECT COUNT(*) AS filas,
 COUNT(*) FILTER(WHERE nombre_raw IS NULL OR btrim(nombre_raw)='') AS sin_nombre,
 COUNT(*) FILTER(WHERE NOT pg_input_is_valid(precio_raw,'numeric')) AS no_numericos FROM calidad_lab;
CREATE TEMP VIEW calidad_clasificada_lab AS
SELECT *,btrim(nombre_raw) AS nombre,
 CASE WHEN pg_input_is_valid(precio_raw,'numeric') THEN precio_raw::numeric END AS precio FROM calidad_lab;
SELECT id,nombre_raw,nombre,precio_raw,precio,
 CASE WHEN nombre IS NULL OR nombre='' THEN 'NOMBRE_VACIO'
 WHEN precio IS NULL THEN 'PRECIO_NO_NUMERICO'
 WHEN precio<=0 THEN 'PRECIO_NO_POSITIVO' ELSE 'ACEPTADO' END AS regla
FROM calidad_clasificada_lab ORDER BY id;
ROLLBACK;
