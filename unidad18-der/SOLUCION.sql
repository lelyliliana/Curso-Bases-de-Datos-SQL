-- Una solución a la práctica adicional de Unidad 18.
BEGIN;
SET LOCAL search_path = tienda, public;
SET LOCAL TIME ZONE 'UTC';
SELECT p.id FROM pedido p WHERE NOT EXISTS(SELECT 1 FROM detalle_pedido d WHERE d.pedido_id=p.id) ORDER BY p.id;
ROLLBACK;
