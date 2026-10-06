# Ampliación: recursión y funciones de ventana

## CTE recursiva con terminación

[AMPLIACION.sql](AMPLIACION.sql) genera 1..5. El primer SELECT es el caso inicial; UNION ALL agrega el resultado del paso recursivo usando las filas de la iteración anterior. `WHERE n<5` permite producir 5 y detiene nuevas iteraciones. Una jerarquía con ciclos necesita una estrategia explícita para detectarlos o evitarlos; no basta con esperar que la recursión termine.

Resuelve: genera meses 1..12 y explica qué condición detiene el proceso. Solución: inicia en 1 y usa `WHERE n<12`; la última fila será 12, no 11. Evita esta técnica si una serie simple con `generate_series` expresa mejor el problema.

## Ventanas: agregar sin perder filas

GROUP BY produce una fila por grupo. Una ventana conserva las filas de entrada y calcula sobre una partición. En el ranking de precios:

| id | precio | row_number | dense_rank |
|---:|---:|---:|---:|
| 3 | 120 | 1 | 1 |
| 2 | 90 | 2 | 2 |
| 4 | 90 | 3 | 2 |
| 1 | 80 | 4 | 3 |
| 5 | 50 | 5 | 4 |

`row_number` asigna posición única con desempate por id. `dense_rank` comparte rango entre precios iguales y no deja huecos. Agregar id al orden de dense_rank eliminaría el empate porque la ventana ya compararía precio e id.

`AVG(precio) OVER()` devuelve promedio global 86 en cada fila. `PARTITION BY categoria_id` calcularía uno por categoría sin colapsar los productos. El ORDER BY dentro de OVER determina el cálculo de ventana; el ORDER BY exterior determina el orden presentado.

## Acumulados y marco

La CTE de pedidos pagados obtiene 320 y 150. SUM OVER con `ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW` acumula 320 y 470. El marco ROWS explícito evita atribuir sin explicar el comportamiento del marco predeterminado ante empates. Un orden por fecha,id es estable.

Para filtrar por un resultado de ventana, calcula primero en CTE/subconsulta y filtra después: WHERE se evalúa conceptualmente antes de esas funciones. Pregunta siempre qué filas entran; no calcules acumulados sobre pedidos cancelados si la métrica son ventas pagadas.

Resuelve: los dos productos más caros de cada categoría con ROW_NUMBER PARTITION BY categoria_id. Explica si deseas dos posiciones o todos los empatados; DENSE_RANK responde otra pregunta. En la tienda actual resultan ids 1,2,3,4,5 porque cada categoría tiene a lo sumo dos productos.

[Unidad](README.md)
