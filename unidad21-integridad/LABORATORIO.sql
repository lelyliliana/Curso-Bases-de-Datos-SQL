-- Unidad 21: ¿Qué cambia al borrar un padre protegido o un pedido con CASCADE?
-- Ejecutar desde la raíz con psql -X -v ON_ERROR_STOP=1 -f unidad21-integridad/LABORATORIO.sql
-- Requiere tienda cargada; Unidad 27 requiere administrador con CREATEROLE.
BEGIN;
SET LOCAL search_path = tienda, public;
SET LOCAL TIME ZONE 'UTC';
SELECT COUNT(*) AS antes FROM detalle_pedido WHERE pedido_id=1;
DELETE FROM pedido WHERE id=1 RETURNING id;
SELECT COUNT(*) AS despues FROM detalle_pedido WHERE pedido_id=1;
DO $$ BEGIN
 BEGIN
  DELETE FROM cliente WHERE id=2;
  RAISE EXCEPTION 'La FK debía impedir borrar al cliente 2';
 EXCEPTION WHEN foreign_key_violation THEN
  RAISE NOTICE '23503: cliente protegido por pedidos existentes';
 END;
END $$;
ROLLBACK;
