-- Unidad 18: ¿Cómo verificar que el diagrama corresponde a las FK reales?
-- Ejecutar desde la raíz con psql -X -v ON_ERROR_STOP=1 -f unidad18-der/LABORATORIO.sql
-- Requiere tienda cargada; Unidad 27 requiere administrador con CREATEROLE.
BEGIN;
SET LOCAL search_path = tienda, public;
SET LOCAL TIME ZONE 'UTC';
SELECT conrelid::regclass AS tabla,conname,pg_get_constraintdef(oid) AS definicion
FROM pg_constraint WHERE contype='f' AND connamespace='tienda'::regnamespace
ORDER BY conrelid::regclass::text,conname;
ROLLBACK;
