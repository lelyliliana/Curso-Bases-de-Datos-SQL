-- Una solución a la práctica adicional de Unidad 09.
BEGIN;
SET LOCAL search_path = tienda, public;
SET LOCAL TIME ZONE 'UTC';
SELECT id,nombre,precio FROM producto ORDER BY precio,id LIMIT 2;
ROLLBACK;
