-- Unidad 29: ¿Qué inventario debes guardar antes de comprobar una restauración?
-- Ejecutar desde la raíz con psql -X -v ON_ERROR_STOP=1 -f unidad29-backup/LABORATORIO.sql
-- Requiere tienda cargada; Unidad 27 requiere administrador con CREATEROLE.
BEGIN;
SET LOCAL search_path = tienda, public;
SET LOCAL TIME ZONE 'UTC';
SELECT 'categoria' AS tabla,COUNT(*) AS filas FROM categoria UNION ALL
SELECT 'cliente',COUNT(*) FROM cliente UNION ALL SELECT 'producto',COUNT(*) FROM producto UNION ALL
SELECT 'pedido',COUNT(*) FROM pedido UNION ALL SELECT 'detalle_pedido',COUNT(*) FROM detalle_pedido ORDER BY tabla;
SELECT COUNT(*) AS fk FROM pg_constraint WHERE contype='f' AND connamespace='tienda'::regnamespace;
ROLLBACK;
