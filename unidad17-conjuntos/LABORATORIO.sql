-- Unidad 17: ¿Qué cambia entre combinar filas y combinar conjuntos sin duplicados?
-- Ejecutar desde la raíz con psql -X -v ON_ERROR_STOP=1 -f unidad17-conjuntos/LABORATORIO.sql
-- Requiere tienda cargada; Unidad 27 requiere administrador con CREATEROLE.
BEGIN;
SET LOCAL search_path = tienda, public;
SET LOCAL TIME ZONE 'UTC';
WITH a(x) AS (VALUES(1),(1),(2)),b(x) AS (VALUES(2),(3))
SELECT x FROM a UNION SELECT x FROM b ORDER BY x;
WITH a(x) AS (VALUES(1),(1),(2)),b(x) AS (VALUES(2),(3))
SELECT x FROM a UNION ALL SELECT x FROM b ORDER BY x;
WITH a(x) AS (VALUES(1),(1),(2)),b(x) AS (VALUES(2),(3))
SELECT x FROM a INTERSECT SELECT x FROM b ORDER BY x;
WITH a(x) AS (VALUES(1),(1),(2)),b(x) AS (VALUES(2),(3))
SELECT x FROM a EXCEPT SELECT x FROM b ORDER BY x;
ROLLBACK;
