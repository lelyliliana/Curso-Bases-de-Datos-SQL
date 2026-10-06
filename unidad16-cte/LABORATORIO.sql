-- Unidad 16: ¿Cómo separar población, cálculo y presentación en un reporte de ventas?
-- Ejecutar desde la raíz con psql -X -v ON_ERROR_STOP=1 -f unidad16-cte/LABORATORIO.sql
-- Requiere tienda cargada; Unidad 27 requiere administrador con CREATEROLE.
BEGIN;
SET LOCAL search_path = tienda, public;
SET LOCAL TIME ZONE 'UTC';
WITH total_pedido AS (
 SELECT p.id,p.cliente_id,p.estado,COALESCE(SUM(d.cantidad*d.precio_unitario),0) AS total
 FROM pedido p LEFT JOIN detalle_pedido d ON d.pedido_id=p.id GROUP BY p.id
), pagado_cliente AS (
 SELECT cliente_id,SUM(total) AS total FROM total_pedido WHERE estado='PAGADO' GROUP BY cliente_id
)
SELECT c.id,c.nombre,COALESCE(pc.total,0) AS pagado FROM cliente c
LEFT JOIN pagado_cliente pc ON pc.cliente_id=c.id ORDER BY c.id;
ROLLBACK;
