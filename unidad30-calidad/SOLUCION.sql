-- Una solución a la práctica adicional de Unidad 30.
BEGIN;
SET LOCAL search_path = tienda, public;
SET LOCAL TIME ZONE 'UTC';
CREATE TEMP TABLE porcentaje_lab(nombre text); INSERT INTO porcentaje_lab VALUES ('Ana'),(''),(NULL),('Luis'); SELECT round(100.0*COUNT(*) FILTER(WHERE nombre IS NULL OR btrim(nombre)='')/NULLIF(COUNT(*),0),2) FROM porcentaje_lab;
ROLLBACK;
