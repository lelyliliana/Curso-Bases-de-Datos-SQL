# Leer un plan con evidencia

## Antes de medir

Anota versión, consulta, parámetros, cantidad de filas, distribución y estadísticas. Ejecuta ANALYZE sobre los datos sintéticos. Guarda EXPLAIN (ANALYZE,BUFFERS) antes y después de **un cambio identificado**; registra que ANALYZE ejecuta la consulta.

## Campos para comparar

| Campo | Interpretación |
|---|---|
| Node Type | estrategia (Seq Scan, Index Scan, Bitmap, Hash Join...) |
| cost | estimación interna, no milisegundos |
| Plan Rows | filas estimadas por ejecución del nodo |
| Actual Rows + Loops | filas reales y repeticiones del nodo |
| Buffers | bloques en caché/leídos/escritos; no es solo disco físico |
| Planning/Execution Time | tiempos de esa ejecución, sujetos a caché y carga |

Lee desde los nodos que alimentan otros y explica dónde se filtran/agregan filas. No sumes tiempos inclusivos de todos los nodos como si fueran independientes. Compara estimación con realidad, observa loops y recuerda que una segunda ejecución puede aprovechar caché.

## Conclusión de ejemplo

«El filtro devuelve 100 de 100000 filas. Después del índice el plan usa otra ruta y reduce bloques revisados en estas ejecuciones. Para un filtro que devuelve toda la tabla, el motor conserva Seq Scan. Los resultados coinciden; los tiempos observados dependen del entorno». Sustenta cada parte con tus planes, no copies los nombres de nodos si tu ejecución muestra otros.

[Laboratorio](LABORATORIO.sql) · [Unidad](README.md)
