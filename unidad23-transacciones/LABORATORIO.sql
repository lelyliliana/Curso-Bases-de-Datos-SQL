-- Unidad 23: ¿Cómo recuperar una parte fallida sin confirmar una operación incompleta?
-- Ejecutar desde la raíz con psql -X -v ON_ERROR_STOP=1 -f unidad23-transacciones/LABORATORIO.sql
-- Requiere tienda cargada; Unidad 27 requiere administrador con CREATEROLE.
BEGIN;
SET LOCAL search_path = tienda, public;
SET LOCAL TIME ZONE 'UTC';
SELECT precio FROM producto WHERE id=1;
UPDATE producto SET precio=85 WHERE id=1;
SAVEPOINT antes_segundo_cambio;
UPDATE producto SET precio=95 WHERE id=1;
ROLLBACK TO SAVEPOINT antes_segundo_cambio;
SELECT precio FROM producto WHERE id=1;
RELEASE SAVEPOINT antes_segundo_cambio;
ROLLBACK;
