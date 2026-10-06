# Soluciones razonadas: Unidad 12

Intenta primero [PRACTICA.md](PRACTICA.md). Una consulta puede tener varias soluciones correctas si responde a la misma población, conserva cardinalidad y maneja los mismos límites.

## A. Laboratorio

**Resultado de referencia:** 5 filas, 3 descripciones, suma 430, promedio 86, mínimo 50, máximo 120. 11 unidades, valor 1010, promedio por línea 91, por unidad 91.82. Población vacía: COUNT 0 y SUM NULL.

**Interpretación:** El promedio de cinco precios de línea da el mismo peso a una línea de una unidad que a otra de cinco. El ponderado usa cantidades. Las agregaciones ignoran NULL salvo COUNT(*), pero SUM vacío no es cero automáticamente. COUNT(DISTINCT columna) cuenta valores distintos no nulos.

El script termina en `ROLLBACK`. Los cambios de tablas u objetos del laboratorio se revierten. Los valores de secuencia consumidos pueden dejar huecos; no uses una lista consecutiva de IDs como prueba de recuperación.

## B. Práctica adicional

**Enunciado:** Calcula valor y unidades de pedidos PAGADO, sin incluir creados o cancelados.

```sql
SELECT SUM(d.cantidad) AS unidades,SUM(d.cantidad*d.precio_unitario) AS valor FROM pedido p JOIN detalle_pedido d ON d.pedido_id=p.id WHERE p.estado='PAGADO';
```

**Resultado o evidencia:** 5 unidades y 470.00. Se usan precios históricos de detalle.

La versión ejecutable está en [SOLUCION.sql](SOLUCION.sql). Identifica en ella la fuente de cada columna y las condiciones que limitan su alcance. Si propones otra forma, compara todas las filas y valores; que produzca el mismo conteo no basta para demostrar equivalencia.

## C. Explicar el límite

Vuelve a la decisión central de esta unidad: El promedio de cinco precios de línea da el mismo peso a una línea de una unidad que a otra de cinco. El ponderado usa cantidades. Las agregaciones ignoran NULL salvo COUNT(*), pero SUM vacío no es cero automáticamente. COUNT(DISTINCT columna) cuenta valores distintos no nulos.

Registra el dato cambiado, predicción, resultado y conclusión. Un resultado distinto es válido cuando cambió deliberadamente la población; uno inesperado exige revisar la consulta y el supuesto.

[Unidad](README.md) · [Caso y resultados de referencia](../docs/CASO_TIENDA.md)
