-- Una solución a la práctica adicional de Unidad 08.
BEGIN;
SET LOCAL search_path = tienda, public;
SET LOCAL TIME ZONE 'UTC';
SELECT id,nombre FROM cliente WHERE telefono IS NULL ORDER BY id; SELECT id,nombre FROM producto WHERE activo AND (precio<90 OR precio>110) ORDER BY id;
ROLLBACK;
