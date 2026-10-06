-- Una solución a la práctica adicional de Unidad 15.
BEGIN;
SET LOCAL search_path = tienda, public;
SET LOCAL TIME ZONE 'UTC';
SELECT c.id,c.nombre FROM cliente c WHERE EXISTS (SELECT 1 FROM pedido p JOIN detalle_pedido d ON d.pedido_id=p.id JOIN producto pr ON pr.id=d.producto_id JOIN categoria ca ON ca.id=pr.categoria_id WHERE p.cliente_id=c.id AND p.estado='PAGADO' AND ca.nombre='Libros') ORDER BY c.id;
ROLLBACK;
