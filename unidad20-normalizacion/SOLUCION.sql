-- Una solución a la práctica adicional de Unidad 20.
BEGIN;
SET LOCAL search_path = tienda, public;
SET LOCAL TIME ZONE 'UTC';
SELECT COUNT(*) AS filas_reconstruidas FROM detalle_pedido d JOIN pedido p ON p.id=d.pedido_id JOIN producto pr ON pr.id=d.producto_id;
ROLLBACK;
