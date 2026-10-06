BEGIN;
SET LOCAL search_path=tienda,public;
SET LOCAL TIME ZONE 'UTC';
-- 1. Catálogo activo: cuatro productos.
SELECT p.id,p.nombre,c.nombre AS categoria,p.precio FROM producto p JOIN categoria c ON c.id=p.categoria_id WHERE p.activo ORDER BY p.nombre,p.id;
-- 2. Categorías sin productos: Deportes.
SELECT c.id,c.nombre FROM categoria c WHERE NOT EXISTS(SELECT 1 FROM producto p WHERE p.categoria_id=c.id) ORDER BY c.id;
-- 3. Clientes sin pedidos: Sara.
SELECT c.id,c.nombre FROM cliente c WHERE NOT EXISTS(SELECT 1 FROM pedido p WHERE p.cliente_id=c.id) ORDER BY c.id;
-- 4. Totales, incluye vacío.
SELECT p.id,COALESCE(SUM(d.cantidad*d.precio_unitario),0) AS total FROM pedido p LEFT JOIN detalle_pedido d ON d.pedido_id=p.id GROUP BY p.id ORDER BY p.id;
-- 5. Ventas pagadas por cliente, incluyendo cero.
WITH ventas AS(SELECT p.cliente_id,SUM(d.cantidad*d.precio_unitario) AS total FROM pedido p JOIN detalle_pedido d ON d.pedido_id=p.id WHERE p.estado='PAGADO' GROUP BY p.cliente_id)
SELECT c.id,c.nombre,COALESCE(v.total,0) AS total FROM cliente c LEFT JOIN ventas v ON v.cliente_id=c.id ORDER BY c.id;
-- 6. Categorías con precio promedio > 90 (Tecnología 105).
SELECT categoria_id,round(AVG(precio),2) AS promedio FROM producto GROUP BY categoria_id HAVING AVG(precio)>90 ORDER BY categoria_id;
-- 7. Alternativas de existencia.
SELECT c.id FROM cliente c WHERE EXISTS(SELECT 1 FROM pedido p WHERE p.cliente_id=c.id) ORDER BY c.id;
SELECT DISTINCT c.id FROM cliente c JOIN pedido p ON p.cliente_id=c.id ORDER BY c.id;
-- 8. Dos etapas: totales y pedidos superiores a 100.
WITH total AS(SELECT p.id,p.estado,COALESCE(SUM(d.cantidad*d.precio_unitario),0) AS importe FROM pedido p LEFT JOIN detalle_pedido d ON d.pedido_id=p.id GROUP BY p.id),altos AS(SELECT * FROM total WHERE importe>100)
SELECT id,estado,importe FROM altos ORDER BY id;
-- 12. Todo o nada: cambios revertidos hasta un savepoint.
SAVEPOINT mantenimiento;
UPDATE producto SET precio=round(precio*1.10,2) WHERE categoria_id=1;
SELECT id,precio FROM producto WHERE categoria_id=1 ORDER BY id;
ROLLBACK TO SAVEPOINT mantenimiento;
SELECT id,precio FROM producto WHERE categoria_id=1 ORDER BY id;
ROLLBACK;
