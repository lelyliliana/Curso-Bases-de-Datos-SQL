-- Una solución a la práctica adicional de Unidad 17.
BEGIN;
SET LOCAL search_path = tienda, public;
SET LOCAL TIME ZONE 'UTC';
SELECT 'ana@example.com'::text AS correo,'archivo_a'::text AS fuente UNION ALL SELECT 'ana@example.com','archivo_b' ORDER BY fuente;
ROLLBACK;
