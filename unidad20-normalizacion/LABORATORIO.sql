-- Unidad 20: ¿Separar tablas preserva los hechos al reconstruir una venta?
-- Ejecutar desde la raíz con psql -X -v ON_ERROR_STOP=1 -f unidad20-normalizacion/LABORATORIO.sql
-- Requiere tienda cargada; Unidad 27 requiere administrador con CREATEROLE.
BEGIN;
SET LOCAL search_path = tienda, public;
SET LOCAL TIME ZONE 'UTC';
SELECT d.pedido_id,p.cliente_id,c.correo,d.producto_id,pr.nombre,ca.nombre AS categoria,
 d.cantidad,d.precio_unitario FROM detalle_pedido d
JOIN pedido p ON p.id=d.pedido_id JOIN cliente c ON c.id=p.cliente_id
JOIN producto pr ON pr.id=d.producto_id JOIN categoria ca ON ca.id=pr.categoria_id
ORDER BY d.pedido_id,d.producto_id;
ROLLBACK;
