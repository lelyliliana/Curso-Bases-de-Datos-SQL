-- Unidad 07: ¿Qué cambia al calcular un descuento en una consulta?
-- Ejecutar desde la raíz con psql -X -v ON_ERROR_STOP=1 -f unidad07-select/LABORATORIO.sql
-- Requiere tienda cargada; Unidad 27 requiere administrador con CREATEROLE.
BEGIN;
SET LOCAL search_path = tienda, public;
SET LOCAL TIME ZONE 'UTC';
SELECT id,nombre,precio,round(precio*0.90,2) AS precio_descuento
FROM producto ORDER BY id;
SELECT precio FROM producto WHERE id=1;
ROLLBACK;
