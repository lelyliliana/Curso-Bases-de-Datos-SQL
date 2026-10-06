-- Una solución a la práctica adicional de Unidad 04.
BEGIN;
SET LOCAL search_path = tienda, public;
SET LOCAL TIME ZONE 'UTC';
SELECT column_name,data_type FROM information_schema.columns WHERE table_schema='tienda' AND table_name='producto' ORDER BY ordinal_position;
ROLLBACK;
