-- Unidad 08: ¿Por qué no aparece ninguna fila al comparar una columna con NULL mediante igual?
-- Ejecutar desde la raíz con psql -X -v ON_ERROR_STOP=1 -f unidad08-where/LABORATORIO.sql
-- Requiere tienda cargada; Unidad 27 requiere administrador con CREATEROLE.
BEGIN;
SET LOCAL search_path = tienda, public;
SET LOCAL TIME ZONE 'UTC';
SELECT id,nombre FROM producto WHERE activo AND precio BETWEEN 80 AND 90 ORDER BY id;
SELECT id,nombre FROM producto WHERE descripcion IS NULL ORDER BY id;
SELECT NULL = NULL AS igualdad, NULL IS NULL AS prueba_nulo,
       false AND NULL AS falso_y_desconocido, true OR NULL AS verdadero_o_desconocido;
ROLLBACK;
