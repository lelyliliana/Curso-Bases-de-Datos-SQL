-- Unidad 24: ¿Qué lecturas se permiten mientras otra transacción conserva un bloqueo de fila?
-- Ejecutar desde la raíz con psql -X -v ON_ERROR_STOP=1 -f unidad24-concurrencia/LABORATORIO.sql
-- Requiere tienda cargada; Unidad 27 requiere administrador con CREATEROLE.
BEGIN;
SET LOCAL search_path = tienda, public;
SET LOCAL TIME ZONE 'UTC';
SHOW transaction_isolation;
SELECT id,precio FROM producto WHERE id=1;
SELECT id,precio FROM producto WHERE id=1 FOR UPDATE;
ROLLBACK;
