-- Unidad 10: ¿Cómo comprobar el alcance de una modificación y revertirla?
-- Ejecutar desde la raíz con psql -X -v ON_ERROR_STOP=1 -f unidad10-update-delete/LABORATORIO.sql
-- Requiere tienda cargada; Unidad 27 requiere administrador con CREATEROLE.
BEGIN;
SET LOCAL search_path = tienda, public;
SET LOCAL TIME ZONE 'UTC';
SELECT id,precio FROM producto WHERE categoria_id=1 ORDER BY id;
UPDATE producto SET precio=round(precio*1.10,2) WHERE categoria_id=1 RETURNING id,precio;
SELECT id,precio FROM producto WHERE categoria_id=1 ORDER BY id;
DELETE FROM producto WHERE id=5 RETURNING id,nombre;
SELECT COUNT(*) AS productos_durante FROM producto;
ROLLBACK;
