# Soluciones razonadas: Unidad 13

Intenta primero [PRACTICA.md](PRACTICA.md). Una consulta puede tener varias soluciones correctas si responde a la misma población, conserva cardinalidad y maneja los mismos límites.

## A. Laboratorio

**Resultado de referencia:** Categorías 1 y 2: dos activos cada una, promedios 85 y 105. Pedidos por cliente: 1→2, 2→2, 4→1.

**Interpretación:** WHERE elimina la Lámpara antes del grupo; HAVING elimina grupos pequeños. Sara no aparece en el segundo reporte porque la población es pedido. GROUP BY no genera categorías o clientes ausentes; la unidad siguiente incorpora LEFT JOIN. PostgreSQL puede reconocer dependencias de la PK, pero agrupar explícitamente los atributos del reporte facilita leerlo.

El script termina en `ROLLBACK`. Los cambios de tablas u objetos del laboratorio se revierten. Los valores de secuencia consumidos pueden dejar huecos; no uses una lista consecutiva de IDs como prueba de recuperación.

## B. Práctica adicional

**Enunciado:** Encuentra clientes con más de un pedido PAGADO. Define qué representa cada fila.

```sql
SELECT cliente_id,COUNT(*) AS pagados FROM pedido WHERE estado='PAGADO' GROUP BY cliente_id HAVING COUNT(*)>1 ORDER BY cliente_id;
```

**Resultado o evidencia:** Solo cliente 1, con dos pedidos pagados.

La versión ejecutable está en [SOLUCION.sql](SOLUCION.sql). Identifica en ella la fuente de cada columna y las condiciones que limitan su alcance. Si propones otra forma, compara todas las filas y valores; que produzca el mismo conteo no basta para demostrar equivalencia.

## C. Explicar el límite

Vuelve a la decisión central de esta unidad: WHERE elimina la Lámpara antes del grupo; HAVING elimina grupos pequeños. Sara no aparece en el segundo reporte porque la población es pedido. GROUP BY no genera categorías o clientes ausentes; la unidad siguiente incorpora LEFT JOIN. PostgreSQL puede reconocer dependencias de la PK, pero agrupar explícitamente los atributos del reporte facilita leerlo.

Registra el dato cambiado, predicción, resultado y conclusión. Un resultado distinto es válido cuando cambió deliberadamente la población; uno inesperado exige revisar la consulta y el supuesto.

[Unidad](README.md) · [Caso y resultados de referencia](../docs/CASO_TIENDA.md)
