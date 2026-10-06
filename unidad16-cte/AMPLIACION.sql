-- CTE recursiva y ventanas: ampliación ejecutable, sin cambiar la tienda.
BEGIN;
SET LOCAL search_path=tienda,public;
WITH RECURSIVE numeros(n) AS (
 SELECT 1 UNION ALL SELECT n+1 FROM numeros WHERE n<5
) SELECT n FROM numeros ORDER BY n;
SELECT id,nombre,precio,
 row_number() OVER(ORDER BY precio DESC,id) AS posicion,
 dense_rank() OVER(ORDER BY precio DESC) AS grupo_precio,
 round(AVG(precio) OVER(),2) AS promedio_global
FROM producto ORDER BY precio DESC,id;
WITH total_pedido AS (
 SELECT p.id,p.fecha,COALESCE(SUM(d.cantidad*d.precio_unitario),0) AS total
 FROM pedido p LEFT JOIN detalle_pedido d ON d.pedido_id=p.id
 WHERE p.estado='PAGADO' GROUP BY p.id
)
SELECT id,total,SUM(total) OVER(ORDER BY fecha,id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS acumulado
FROM total_pedido ORDER BY fecha,id;
ROLLBACK;
