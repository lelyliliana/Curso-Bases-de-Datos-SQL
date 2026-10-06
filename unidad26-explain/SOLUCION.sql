-- Una solución a la práctica adicional de Unidad 26.
BEGIN;
SET LOCAL search_path = tienda, public;
SET LOCAL TIME ZONE 'UTC';
EXPLAIN (ANALYZE,BUFFERS) SELECT estado,COUNT(*) FROM pedido GROUP BY estado; SELECT estado,COUNT(*) FROM pedido GROUP BY estado ORDER BY estado;
ROLLBACK;
