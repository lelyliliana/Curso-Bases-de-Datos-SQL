-- Una solución a la práctica adicional de Unidad 14.
BEGIN;
SET LOCAL search_path = tienda, public;
SET LOCAL TIME ZONE 'UTC';
SELECT p.id,COALESCE(SUM(d.cantidad*d.precio_unitario),0) AS total FROM pedido p LEFT JOIN detalle_pedido d ON d.pedido_id=p.id GROUP BY p.id ORDER BY p.id;
ROLLBACK;
