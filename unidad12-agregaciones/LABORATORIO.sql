-- Unidad 12: ¿Promedio de precio por línea y por unidad responden la misma pregunta?
-- Ejecutar desde la raíz con psql -X -v ON_ERROR_STOP=1 -f unidad12-agregaciones/LABORATORIO.sql
-- Requiere tienda cargada; Unidad 27 requiere administrador con CREATEROLE.
BEGIN;
SET LOCAL search_path = tienda, public;
SET LOCAL TIME ZONE 'UTC';
SELECT COUNT(*) AS filas,COUNT(descripcion) AS descritos,SUM(precio) AS suma,
 round(AVG(precio),2) AS promedio,MIN(precio),MAX(precio) FROM producto;
SELECT SUM(cantidad) AS unidades,SUM(cantidad*precio_unitario) AS valor,
 round(AVG(precio_unitario),2) AS promedio_linea,
 round(SUM(cantidad*precio_unitario)/NULLIF(SUM(cantidad),0),2) AS promedio_unidad FROM detalle_pedido;
SELECT COUNT(*) AS filas,SUM(precio) AS suma FROM producto WHERE precio>1000;
ROLLBACK;
