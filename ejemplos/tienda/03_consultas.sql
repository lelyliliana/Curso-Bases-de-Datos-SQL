-- Catálogo con categoría
SELECT p.id,p.nombre,c.nombre AS categoria,p.precio
FROM producto p JOIN categoria c ON c.id=p.categoria_id
WHERE p.activo
ORDER BY p.nombre;

-- Total por pedido
SELECT pe.id,cl.nombre,SUM(d.cantidad*d.precio_unitario) AS total
FROM pedido pe
JOIN cliente cl ON cl.id=pe.cliente_id
JOIN detalle_pedido d ON d.pedido_id=pe.id
GROUP BY pe.id,cl.nombre
ORDER BY pe.id;

-- Clientes con pedidos
SELECT cl.nombre
FROM cliente cl
WHERE EXISTS (SELECT 1 FROM pedido p WHERE p.cliente_id=cl.id);
