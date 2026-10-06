-- Una solución a la práctica adicional de Unidad 16.
BEGIN;
SET LOCAL search_path = tienda, public;
SET LOCAL TIME ZONE 'UTC';
WITH totales AS (SELECT p.id,COALESCE(SUM(d.cantidad*d.precio_unitario),0) AS total FROM pedido p LEFT JOIN detalle_pedido d ON d.pedido_id=p.id GROUP BY p.id) SELECT id,total FROM totales WHERE total>100 ORDER BY id;
ROLLBACK;
