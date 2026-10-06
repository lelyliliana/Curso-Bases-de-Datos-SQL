-- Unidad 04: ¿A qué servidor, base, usuario y esquema está conectada esta ventana?
-- Ejecutar desde la raíz con psql -X -v ON_ERROR_STOP=1 -f unidad04-postgresql/LABORATORIO.sql
-- Requiere tienda cargada; Unidad 27 requiere administrador con CREATEROLE.
BEGIN;
SET LOCAL search_path = tienda, public;
SET LOCAL TIME ZONE 'UTC';
SELECT current_database() AS base,current_user AS usuario;
SHOW server_version;
SHOW search_path;
SELECT table_name FROM information_schema.tables
WHERE table_schema='tienda' AND table_type='BASE TABLE'
ORDER BY table_name;
ROLLBACK;
