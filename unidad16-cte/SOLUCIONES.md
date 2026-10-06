# Soluciones razonadas: Unidad 16

Intenta primero [PRACTICA.md](PRACTICA.md). Una consulta puede tener varias soluciones correctas si responde a la misma población, conserva cardinalidad y maneja los mismos límites.

## A. Laboratorio

**Resultado de referencia:** Ana 470.00; Luis, Sara y Tomás 0. Las cuatro personas aparecen.

**Interpretación:** La primera CTE fija una fila por pedido; la segunda suma solo pagados por cliente y la consulta exterior conserva todos los clientes. Una CTE no persiste después de la sentencia. PostgreSQL puede integrarla al plan o materializarla según sus características: legibilidad y rendimiento se evalúan por separado.

El script termina en `ROLLBACK`. Los cambios de tablas u objetos del laboratorio se revierten. Los valores de secuencia consumidos pueden dejar huecos; no uses una lista consecutiva de IDs como prueba de recuperación.

## B. Práctica adicional

**Enunciado:** Calcula total por pedido, conserva todos, y filtra los que superan 100 mediante una CTE.

```sql
WITH totales AS (SELECT p.id,COALESCE(SUM(d.cantidad*d.precio_unitario),0) AS total FROM pedido p LEFT JOIN detalle_pedido d ON d.pedido_id=p.id GROUP BY p.id) SELECT id,total FROM totales WHERE total>100 ORDER BY id;
```

**Resultado o evidencia:** Pedidos 1 (320), 3 (150) y 5 (450), considerando todos los estados.

La versión ejecutable está en [SOLUCION.sql](SOLUCION.sql). Identifica en ella la fuente de cada columna y las condiciones que limitan su alcance. Si propones otra forma, compara todas las filas y valores; que produzca el mismo conteo no basta para demostrar equivalencia.

## C. Explicar el límite

Vuelve a la decisión central de esta unidad: La primera CTE fija una fila por pedido; la segunda suma solo pagados por cliente y la consulta exterior conserva todos los clientes. Una CTE no persiste después de la sentencia. PostgreSQL puede integrarla al plan o materializarla según sus características: legibilidad y rendimiento se evalúan por separado.

Registra el dato cambiado, predicción, resultado y conclusión. Un resultado distinto es válido cuando cambió deliberadamente la población; uno inesperado exige revisar la consulta y el supuesto.

[Unidad](README.md) · [Caso y resultados de referencia](../docs/CASO_TIENDA.md)
