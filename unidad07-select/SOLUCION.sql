-- Una solución a la práctica adicional de Unidad 07.
BEGIN;
SET LOCAL search_path = tienda, public;
SET LOCAL TIME ZONE 'UTC';
SELECT id,nombre,precio*3 AS tres_unidades FROM producto ORDER BY id;
ROLLBACK;
