-- Una solución a la práctica adicional de Unidad 22.
BEGIN;
SET LOCAL search_path = tienda, public;
SET LOCAL TIME ZONE 'UTC';
CREATE VIEW tienda.catalogo_lab AS SELECT id,nombre,precio FROM tienda.producto WHERE activo; SELECT id,nombre,precio FROM tienda.catalogo_lab ORDER BY id;
ROLLBACK;
