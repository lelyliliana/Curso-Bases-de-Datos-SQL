-- Una solución a la práctica adicional de Unidad 19.
BEGIN;
SET LOCAL search_path = tienda, public;
SET LOCAL TIME ZONE 'UTC';
SELECT d.pedido_id,d.producto_id,d.precio_unitario AS historico,p.precio AS actual FROM detalle_pedido d JOIN producto p ON p.id=d.producto_id WHERE d.precio_unitario<>p.precio ORDER BY d.pedido_id,d.producto_id;
ROLLBACK;
