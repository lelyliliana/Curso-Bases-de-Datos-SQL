-- Unidad 11: ¿Cómo producir etiquetas y manejar ausencias sin reescribir los datos originales?
-- Ejecutar desde la raíz con psql -X -v ON_ERROR_STOP=1 -f unidad11-funciones/LABORATORIO.sql
-- Requiere tienda cargada; Unidad 27 requiere administrador con CREATEROLE.
BEGIN;
SET LOCAL search_path = tienda, public;
SET LOCAL TIME ZONE 'UTC';
SELECT id,nombre,CASE WHEN precio<90 THEN 'Económico'
 WHEN precio<=120 THEN 'Medio' ELSE 'Alto' END AS rango,
 COALESCE(descripcion,'Sin descripción') AS descripcion_visible
FROM producto ORDER BY id;
SELECT id,(fecha AT TIME ZONE 'UTC')::date AS dia_utc,
 extract(month FROM fecha AT TIME ZONE 'UTC') AS mes FROM pedido ORDER BY id;
SELECT 5/2 AS division_entera,5::numeric/2 AS division_decimal;
ROLLBACK;
