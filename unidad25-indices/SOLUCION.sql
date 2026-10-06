-- Una solución a la práctica adicional de Unidad 25.
BEGIN;
SET LOCAL search_path = tienda, public;
SET LOCAL TIME ZONE 'UTC';
CREATE TEMP TABLE selectividad_lab AS SELECT g AS id,g%1000 AS grupo FROM generate_series(1,100000) g;
CREATE INDEX selectividad_grupo_lab ON selectividad_lab(grupo);
ANALYZE selectividad_lab;
EXPLAIN (ANALYZE,BUFFERS) SELECT * FROM selectividad_lab WHERE grupo>=0;
SELECT COUNT(*) FROM selectividad_lab WHERE grupo>=0;
ROLLBACK;
