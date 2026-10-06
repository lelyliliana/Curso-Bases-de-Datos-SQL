-- Unidad 06: ¿Cómo insertar un padre y usar su identificador sin suponer cuál será el siguiente?
-- Ejecutar desde la raíz con psql -X -v ON_ERROR_STOP=1 -f unidad06-insert/LABORATORIO.sql
-- Requiere tienda cargada; Unidad 27 requiere administrador con CREATEROLE.
BEGIN;
SET LOCAL search_path = tienda, public;
SET LOCAL TIME ZONE 'UTC';
WITH nueva_categoria AS (
 INSERT INTO categoria(nombre) VALUES ('Laboratorio INSERT') RETURNING id
)
INSERT INTO producto(categoria_id,nombre,precio)
SELECT id,'Producto de laboratorio',25 FROM nueva_categoria
RETURNING nombre,precio,activo,descripcion;
SELECT COUNT(*) FROM categoria WHERE nombre='Laboratorio INSERT';
ROLLBACK;
