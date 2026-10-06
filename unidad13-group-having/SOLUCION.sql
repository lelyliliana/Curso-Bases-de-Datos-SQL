-- Una solución a la práctica adicional de Unidad 13.
BEGIN;
SET LOCAL search_path = tienda, public;
SET LOCAL TIME ZONE 'UTC';
SELECT cliente_id,COUNT(*) AS pagados FROM pedido WHERE estado='PAGADO' GROUP BY cliente_id HAVING COUNT(*)>1 ORDER BY cliente_id;
ROLLBACK;
