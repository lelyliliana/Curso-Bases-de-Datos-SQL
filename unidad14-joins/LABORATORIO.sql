-- Unidad 14: ¿Cómo incluir categorías vacías sin contar como producto la fila extendida con NULL?
-- Ejecutar desde la raíz con psql -X -v ON_ERROR_STOP=1 -f unidad14-joins/LABORATORIO.sql
-- Requiere tienda cargada; Unidad 27 requiere administrador con CREATEROLE.
BEGIN;
SET LOCAL search_path = tienda, public;
SET LOCAL TIME ZONE 'UTC';
SELECT c.id,c.nombre,COUNT(p.id) AS productos FROM categoria c
LEFT JOIN producto p ON p.categoria_id=c.id GROUP BY c.id,c.nombre ORDER BY c.id;
SELECT pe.id AS pedido,pr.nombre AS producto,d.cantidad,d.cantidad*d.precio_unitario AS subtotal
FROM pedido pe JOIN detalle_pedido d ON d.pedido_id=pe.id JOIN producto pr ON pr.id=d.producto_id
ORDER BY pe.id,pr.id;
SELECT c.id,COUNT(p.id) AS activos FROM categoria c
LEFT JOIN producto p ON p.categoria_id=c.id AND p.activo GROUP BY c.id ORDER BY c.id;
ROLLBACK;
