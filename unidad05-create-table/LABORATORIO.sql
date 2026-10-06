-- Unidad 05: ¿Cómo evolucionar una tabla sin confundir tipos, valores por defecto y restricciones?
-- Ejecutar desde la raíz con psql -X -v ON_ERROR_STOP=1 -f unidad05-create-table/LABORATORIO.sql
-- Requiere tienda cargada; Unidad 27 requiere administrador con CREATEROLE.
BEGIN;
SET LOCAL search_path = tienda, public;
SET LOCAL TIME ZONE 'UTC';
CREATE TEMP TABLE articulo_lab (
 id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
 nombre text NOT NULL CHECK (btrim(nombre) <> ''),
 precio numeric(12,2) NOT NULL CHECK (precio > 0 AND precio <> 'NaN'::numeric),
 activo boolean NOT NULL DEFAULT true
);
ALTER TABLE articulo_lab ADD COLUMN codigo text;
ALTER TABLE articulo_lab ADD CONSTRAINT codigo_unico_lab UNIQUE(codigo);
INSERT INTO articulo_lab(nombre,precio,codigo) VALUES ('Cuaderno',12.345,'CU-01');
SELECT nombre,precio,activo,codigo FROM articulo_lab;
ROLLBACK;
