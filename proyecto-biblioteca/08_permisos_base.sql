-- Reaplicar después de restaurar con --no-privileges.
-- Ejecutar como propietario de las funciones o administrador, antes de habilitar usuarios.
BEGIN;
REVOKE ALL ON FUNCTION biblioteca.prestar(bigint,bigint,timestamptz,timestamptz) FROM PUBLIC;
REVOKE ALL ON FUNCTION biblioteca.devolver(bigint,timestamptz) FROM PUBLIC;
REVOKE CREATE ON SCHEMA biblioteca FROM PUBLIC;
COMMIT;
