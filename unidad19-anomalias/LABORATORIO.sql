-- Unidad 19: ¿Cómo detectar una contradicción en una hoja que repite los datos de cliente?
-- Ejecutar desde la raíz con psql -X -v ON_ERROR_STOP=1 -f unidad19-anomalias/LABORATORIO.sql
-- Requiere tienda cargada; Unidad 27 requiere administrador con CREATEROLE.
BEGIN;
SET LOCAL search_path = tienda, public;
SET LOCAL TIME ZONE 'UTC';
CREATE TEMP TABLE venta_plana_lab(pedido integer,producto integer,cliente integer,correo text,cantidad integer);
INSERT INTO venta_plana_lab VALUES (1,10,7,'ana@viejo.example',1),(1,20,7,'ana@nuevo.example',2);
SELECT cliente,COUNT(DISTINCT correo) AS correos_distintos FROM venta_plana_lab
GROUP BY cliente HAVING COUNT(DISTINCT correo)>1;
ROLLBACK;
