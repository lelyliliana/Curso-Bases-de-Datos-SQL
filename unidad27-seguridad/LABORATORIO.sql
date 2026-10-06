-- Unidad 27: ¿USAGE sobre un esquema implica permiso para modificar sus tablas?
-- Ejecutar desde la raíz con psql -X -v ON_ERROR_STOP=1 -f unidad27-seguridad/LABORATORIO.sql
-- Requiere tienda cargada; Unidad 27 requiere administrador con CREATEROLE.
BEGIN;
SET LOCAL search_path = tienda, public;
SET LOCAL TIME ZONE 'UTC';
CREATE ROLE curso_sql_lector_demo NOLOGIN;
GRANT USAGE ON SCHEMA tienda TO curso_sql_lector_demo;
GRANT SELECT ON tienda.categoria TO curso_sql_lector_demo;
SET LOCAL ROLE curso_sql_lector_demo;
SELECT COUNT(*) FROM tienda.categoria;
DO $$ BEGIN
 BEGIN
  INSERT INTO tienda.categoria(nombre) VALUES ('Sin permiso');
  RAISE EXCEPTION 'INSERT no debía estar autorizado';
 EXCEPTION WHEN insufficient_privilege THEN RAISE NOTICE '42501: INSERT rechazado';
 END;
END $$;
RESET ROLE;
ROLLBACK;
