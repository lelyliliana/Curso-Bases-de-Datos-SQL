-- Una solución a la práctica adicional de Unidad 11.
BEGIN;
SET LOCAL search_path = tienda, public;
SET LOCAL TIME ZONE 'UTC';
SELECT round(100.0*COUNT(*) FILTER(WHERE activo)/NULLIF(COUNT(*),0),2) AS porcentaje FROM producto;
ROLLBACK;
