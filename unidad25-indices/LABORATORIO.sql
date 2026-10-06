-- Unidad 25: ¿Por qué un índice útil en una tabla grande puede ignorarse en una tabla pequeña?
-- Ejecutar desde la raíz con psql -X -v ON_ERROR_STOP=1 -f unidad25-indices/LABORATORIO.sql
-- Requiere tienda cargada; Unidad 27 requiere administrador con CREATEROLE.
BEGIN;
SET LOCAL search_path = tienda, public;
SET LOCAL TIME ZONE 'UTC';
CREATE TEMP TABLE pedido_volumen_lab AS
SELECT g AS id,(g%1000)::integer AS cliente_id,'2026-01-01'::date+(g%365)::integer AS fecha
FROM generate_series(1,100000) AS g;
ANALYZE pedido_volumen_lab;
EXPLAIN (ANALYZE,BUFFERS) SELECT id FROM pedido_volumen_lab WHERE cliente_id=42;
CREATE INDEX volumen_cliente_fecha_lab ON pedido_volumen_lab(cliente_id,fecha DESC);
ANALYZE pedido_volumen_lab;
EXPLAIN (ANALYZE,BUFFERS) SELECT id FROM pedido_volumen_lab WHERE cliente_id=42;
SELECT COUNT(*) FROM pedido_volumen_lab WHERE cliente_id=42;
ROLLBACK;
