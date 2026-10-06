-- Unidad 09: ¿Cómo obtener un top reproducible si dos productos cuestan lo mismo?
-- Ejecutar desde la raíz con psql -X -v ON_ERROR_STOP=1 -f unidad09-order-limit/LABORATORIO.sql
-- Requiere tienda cargada; Unidad 27 requiere administrador con CREATEROLE.
BEGIN;
SET LOCAL search_path = tienda, public;
SET LOCAL TIME ZONE 'UTC';
SELECT id,nombre,precio FROM producto ORDER BY precio DESC,id ASC LIMIT 3;
SELECT DISTINCT precio FROM producto ORDER BY precio;
SELECT id,descripcion FROM producto ORDER BY descripcion ASC NULLS LAST,id;
ROLLBACK;
