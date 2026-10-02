CREATE VIEW resumen_pedidos AS
SELECT p.id AS pedido_id,
       c.nombre AS cliente,
       SUM(d.cantidad*d.precio_unitario) AS total
FROM pedido p
JOIN cliente c ON c.id=p.cliente_id
JOIN detalle_pedido d ON d.pedido_id=p.id
GROUP BY p.id,c.nombre;

SELECT * FROM resumen_pedidos ORDER BY pedido_id;
