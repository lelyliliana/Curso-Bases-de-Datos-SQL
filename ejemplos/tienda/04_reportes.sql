SET search_path = tienda, public;
SELECT c.id,c.nombre,COUNT(p.id) AS productos
FROM categoria c LEFT JOIN producto p ON p.categoria_id=c.id
GROUP BY c.id,c.nombre ORDER BY c.id;
SELECT c.id,c.nombre FROM cliente c
WHERE NOT EXISTS (SELECT 1 FROM pedido p WHERE p.cliente_id=c.id)
ORDER BY c.id;
WITH pagado AS (
 SELECT p.cliente_id,SUM(d.cantidad*d.precio_unitario) AS total
 FROM pedido p JOIN detalle_pedido d ON d.pedido_id=p.id
 WHERE p.estado='PAGADO' GROUP BY p.cliente_id
)
SELECT c.id,c.nombre,COALESCE(p.total,0) AS total_pagado
FROM cliente c LEFT JOIN pagado p ON p.cliente_id=c.id
ORDER BY total_pagado DESC,c.id;
