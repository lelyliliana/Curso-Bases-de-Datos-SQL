-- Demostración administrativa reversible. No deja identidades globales.
BEGIN;
CREATE ROLE curso_biblio_lector_demo NOLOGIN;
CREATE ROLE curso_biblio_operador_demo NOLOGIN;
GRANT USAGE ON SCHEMA biblioteca TO curso_biblio_lector_demo,curso_biblio_operador_demo;
GRANT SELECT ON biblioteca.prestamos_abiertos TO curso_biblio_lector_demo,curso_biblio_operador_demo;
GRANT EXECUTE ON FUNCTION biblioteca.prestar(bigint,bigint,timestamptz,timestamptz),biblioteca.devolver(bigint,timestamptz) TO curso_biblio_operador_demo;
SET LOCAL ROLE curso_biblio_lector_demo;
SELECT prestamo_id,codigo,titulo,socio FROM biblioteca.prestamos_abiertos ORDER BY prestamo_id;
DO $$ BEGIN BEGIN
 PERFORM biblioteca.prestar(1,1,'2026-01-10 10:00+00','2026-01-20 10:00+00');
 RAISE EXCEPTION 'Lector no debe prestar';
EXCEPTION WHEN insufficient_privilege THEN RAISE NOTICE 'Lector sin EXECUTE: 42501 esperado'; END; END $$;
RESET ROLE;
SET LOCAL ROLE curso_biblio_operador_demo;
SELECT biblioteca.prestar(1,1,'2026-01-10 10:00+00','2026-01-20 10:00+00') AS prestamo_creado;
DO $$ BEGIN BEGIN
 DELETE FROM biblioteca.prestamo;
 RAISE EXCEPTION 'Operador no debe borrar historial';
EXCEPTION WHEN insufficient_privilege THEN RAISE NOTICE 'Operador sin DELETE: 42501 esperado'; END; END $$;
RESET ROLE;
ROLLBACK;
