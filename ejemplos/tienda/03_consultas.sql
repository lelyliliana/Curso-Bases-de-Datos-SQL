SET search_path = tienda, public;
SET TIME ZONE 'UTC';
SELECT p.id,p.nombre,c.nombre AS categoria,p.precio
FROM producto p JOIN categoria c ON c.id=p.categoria_id
WHERE p.activo ORDER BY p.id;
SELECT p.id,c.nombre AS cliente,
       COALESCE(SUM(d.cantidad*d.precio_unitario),0) AS total
FROM pedido p JOIN cliente c ON c.id=p.cliente_id
LEFT JOIN detalle_pedido d ON d.pedido_id=p.id
GROUP BY p.id,c.nombre ORDER BY p.id;
SELECT c.id,c.nombre FROM cliente c
WHERE EXISTS (SELECT 1 FROM pedido p WHERE p.cliente_id=c.id)
ORDER BY c.id;
