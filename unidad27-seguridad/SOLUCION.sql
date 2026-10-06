-- Una solución a la práctica adicional de Unidad 27.
BEGIN;
SET LOCAL search_path = tienda, public;
SET LOCAL TIME ZONE 'UTC';
SELECT n.nspname,r.rolname AS propietario FROM pg_namespace n JOIN pg_roles r ON r.oid=n.nspowner WHERE n.nspname='tienda';
ROLLBACK;
