-- Una solución a la práctica adicional de Unidad 24.
BEGIN;
SET LOCAL search_path = tienda, public;
SET LOCAL TIME ZONE 'UTC';
SHOW transaction_isolation; SELECT id,precio FROM producto WHERE id=1;
ROLLBACK;
