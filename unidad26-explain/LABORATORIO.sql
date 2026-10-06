-- Unidad 26: ¿Cómo distinguir estimación, ejecución real y costo sin inventar conclusiones?
-- Ejecutar desde la raíz con psql -X -v ON_ERROR_STOP=1 -f unidad26-explain/LABORATORIO.sql
-- Requiere tienda cargada; Unidad 27 requiere administrador con CREATEROLE.
BEGIN;
SET LOCAL search_path = tienda, public;
SET LOCAL TIME ZONE 'UTC';
CREATE TEMP TABLE plan_lab AS SELECT g AS id,g%1000 AS grupo FROM generate_series(1,100000) g;
ANALYZE plan_lab;
EXPLAIN (ANALYZE,BUFFERS,FORMAT JSON) SELECT id FROM plan_lab WHERE grupo=42;
CREATE INDEX plan_grupo_lab ON plan_lab(grupo);
ANALYZE plan_lab;
EXPLAIN (ANALYZE,BUFFERS,FORMAT JSON) SELECT id FROM plan_lab WHERE grupo=42;
SELECT COUNT(*) FROM plan_lab WHERE grupo=42;
ROLLBACK;
