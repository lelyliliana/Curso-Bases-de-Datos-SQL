-- Categorías incluso sin productos
SELECT c.nombre,COUNT(p.id) AS productos
FROM categoria c
LEFT JOIN producto p ON p.categoria_id=c.id
GROUP BY c.id,c.nombre
ORDER BY c.nombre;

-- Clientes sin pedidos
SELECT c.id,c.nombre
FROM cliente c
WHERE NOT EXISTS (
 SELECT 1 FROM pedido p WHERE p.cliente_id=c.id
);

-- Ventas por cliente
SELECT c.nombre,SUM(d.cantidad*d.precio_unitario) AS total
FROM cliente c
JOIN pedido p ON p.cliente_id=c.id
JOIN detalle_pedido d ON d.pedido_id=p.id
WHERE p.estado='PAGADO'
GROUP BY c.id,c.nombre
ORDER BY total DESC;
