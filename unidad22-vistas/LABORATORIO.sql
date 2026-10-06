-- Unidad 22: ¿Una vista normal se actualiza al cambiar la tabla o conserva una copia?
-- Ejecutar desde la raíz con psql -X -v ON_ERROR_STOP=1 -f unidad22-vistas/LABORATORIO.sql
-- Requiere tienda cargada; Unidad 27 requiere administrador con CREATEROLE.
BEGIN;
SET LOCAL search_path = tienda, public;
SET LOCAL TIME ZONE 'UTC';
CREATE VIEW tienda.resumen_lab AS SELECT p.id,COALESCE(SUM(d.cantidad*d.precio_unitario),0) AS total
FROM pedido p LEFT JOIN detalle_pedido d ON d.pedido_id=p.id GROUP BY p.id;
SELECT id,total FROM tienda.resumen_lab ORDER BY id;
UPDATE detalle_pedido SET cantidad=2 WHERE pedido_id=1 AND producto_id=1;
SELECT total FROM tienda.resumen_lab WHERE id=1;
CREATE MATERIALIZED VIEW tienda.resumen_materializado_lab AS SELECT * FROM tienda.resumen_lab;
UPDATE detalle_pedido SET cantidad=3 WHERE pedido_id=1 AND producto_id=1;
SELECT total FROM tienda.resumen_materializado_lab WHERE id=1;
REFRESH MATERIALIZED VIEW tienda.resumen_materializado_lab;
SELECT total FROM tienda.resumen_materializado_lab WHERE id=1;
ROLLBACK;
