-- Unidad 13: ¿Qué elimina WHERE y qué elimina HAVING en un reporte por categoría?
-- Ejecutar desde la raíz con psql -X -v ON_ERROR_STOP=1 -f unidad13-group-having/LABORATORIO.sql
-- Requiere tienda cargada; Unidad 27 requiere administrador con CREATEROLE.
BEGIN;
SET LOCAL search_path = tienda, public;
SET LOCAL TIME ZONE 'UTC';
SELECT categoria_id,COUNT(*) AS activos,round(AVG(precio),2) AS promedio
FROM producto WHERE activo GROUP BY categoria_id HAVING COUNT(*)>=2 ORDER BY categoria_id;
SELECT cliente_id,COUNT(*) AS pedidos FROM pedido GROUP BY cliente_id ORDER BY cliente_id;
ROLLBACK;
