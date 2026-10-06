# Soluciones razonadas: Unidad 26

Intenta primero [PRACTICA.md](PRACTICA.md). Una consulta puede tener varias soluciones correctas si responde a la misma población, conserva cardinalidad y maneja los mismos límites.

## A. Laboratorio

**Resultado de referencia:** 100 filas reales. Registra Node Type, Plan Rows, Actual Rows, Actual Loops, buffers y tiempo de ejecución en ambos planes.

**Interpretación:** cost son unidades del optimizador, no milisegundos. Actual Rows y tiempos se muestran por ejecución del nodo; observa loops antes de interpretar trabajo total. BUFFERS distingue bloques encontrados en caché y leídos, no mide únicamente disco físico. Ejecutar dos veces favorece caché; repite y registra condiciones antes de atribuir toda la diferencia al índice.

El script termina en `ROLLBACK`. Los cambios de tablas u objetos del laboratorio se revierten. Los valores de secuencia consumidos pueden dejar huecos; no uses una lista consecutiva de IDs como prueba de recuperación.

## B. Práctica adicional

**Enunciado:** Obtén un plan de agregación por estado en la tienda. Explica por qué cinco filas no permiten demostrar una mejora de rendimiento.

```sql
EXPLAIN (ANALYZE,BUFFERS) SELECT estado,COUNT(*) FROM pedido GROUP BY estado; SELECT estado,COUNT(*) FROM pedido GROUP BY estado ORDER BY estado;
```

**Resultado o evidencia:** CANCELADO 1, CREADO 2, PAGADO 2. El plan puede cambiar sin afectar esos resultados.

La versión ejecutable está en [SOLUCION.sql](SOLUCION.sql). Identifica en ella la fuente de cada columna y las condiciones que limitan su alcance. Si propones otra forma, compara todas las filas y valores; que produzca el mismo conteo no basta para demostrar equivalencia.

## C. Explicar el límite

Vuelve a la decisión central de esta unidad: cost son unidades del optimizador, no milisegundos. Actual Rows y tiempos se muestran por ejecución del nodo; observa loops antes de interpretar trabajo total. BUFFERS distingue bloques encontrados en caché y leídos, no mide únicamente disco físico. Ejecutar dos veces favorece caché; repite y registra condiciones antes de atribuir toda la diferencia al índice.

Registra el dato cambiado, predicción, resultado y conclusión. Un resultado distinto es válido cuando cambió deliberadamente la población; uno inesperado exige revisar la consulta y el supuesto.

[Unidad](README.md) · [Caso y resultados de referencia](../docs/CASO_TIENDA.md)
