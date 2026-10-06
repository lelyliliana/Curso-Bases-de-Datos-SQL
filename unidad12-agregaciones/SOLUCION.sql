-- Una solución a la práctica adicional de Unidad 12.
BEGIN;
SET LOCAL search_path = tienda, public;
SET LOCAL TIME ZONE 'UTC';
SELECT SUM(d.cantidad) AS unidades,SUM(d.cantidad*d.precio_unitario) AS valor FROM pedido p JOIN detalle_pedido d ON d.pedido_id=p.id WHERE p.estado='PAGADO';
ROLLBACK;
