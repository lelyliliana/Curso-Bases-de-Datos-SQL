-- Una solución a la práctica adicional de Unidad 10.
BEGIN;
SET LOCAL search_path = tienda, public;
SET LOCAL TIME ZONE 'UTC';
UPDATE producto SET activo=false WHERE categoria_id=2 RETURNING id,nombre,activo;
ROLLBACK;
