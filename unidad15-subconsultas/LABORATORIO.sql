-- Unidad 15: ¿Cómo consultar existencia sin multiplicar clientes por sus pedidos?
-- Ejecutar desde la raíz con psql -X -v ON_ERROR_STOP=1 -f unidad15-subconsultas/LABORATORIO.sql
-- Requiere tienda cargada; Unidad 27 requiere administrador con CREATEROLE.
BEGIN;
SET LOCAL search_path = tienda, public;
SET LOCAL TIME ZONE 'UTC';
SELECT c.id,c.nombre FROM cliente c WHERE EXISTS
 (SELECT 1 FROM pedido p WHERE p.cliente_id=c.id) ORDER BY c.id;
SELECT c.id,c.nombre FROM cliente c WHERE NOT EXISTS
 (SELECT 1 FROM pedido p WHERE p.cliente_id=c.id) ORDER BY c.id;
SELECT 3 NOT IN (1,2,NULL) AS not_in_con_nulo;
SELECT id,nombre FROM producto WHERE precio>(SELECT AVG(precio) FROM producto) ORDER BY id;
ROLLBACK;
