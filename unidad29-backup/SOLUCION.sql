-- Una solución a la práctica adicional de Unidad 29.
BEGIN;
SET LOCAL search_path = tienda, public;
SET LOCAL TIME ZONE 'UTC';
SELECT SUM(d.cantidad*d.precio_unitario) AS venta_pagada FROM pedido p JOIN detalle_pedido d ON d.pedido_id=p.id WHERE p.estado='PAGADO';
ROLLBACK;
