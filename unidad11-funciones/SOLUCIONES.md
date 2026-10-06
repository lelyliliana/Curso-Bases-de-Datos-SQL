# Soluciones razonadas: Unidad 11

Intenta primero [PRACTICA.md](PRACTICA.md). Una consulta puede tener varias soluciones correctas si responde a la misma población, conserva cardinalidad y maneja los mismos límites.

## A. Laboratorio

**Resultado de referencia:** Rangos: Económico, Medio, Medio, Medio, Económico. Mes 1 para los cinco pedidos. División entera 2, decimal 2.5.

**Interpretación:** CASE usa la primera condición verdadera. COALESCE conserva el tipo compatible y no altera NULL en la tabla. AT TIME ZONE hace explícito el calendario del reporte. Una división entre enteros trunca; convierte antes de dividir si necesitas fracciones. CURRENT_TIMESTAMP es estable dentro de una transacción, no un reloj que avance en cada llamada.

El script termina en `ROLLBACK`. Los cambios de tablas u objetos del laboratorio se revierten. Los valores de secuencia consumidos pueden dejar huecos; no uses una lista consecutiva de IDs como prueba de recuperación.

## B. Práctica adicional

**Enunciado:** Calcula porcentaje de productos activos usando decimales y protege una división si no hay filas.

```sql
SELECT round(100.0*COUNT(*) FILTER(WHERE activo)/NULLIF(COUNT(*),0),2) AS porcentaje FROM producto;
```

**Resultado o evidencia:** 80.00. En una población vacía el denominador NULL produce NULL, no una división por cero.

La versión ejecutable está en [SOLUCION.sql](SOLUCION.sql). Identifica en ella la fuente de cada columna y las condiciones que limitan su alcance. Si propones otra forma, compara todas las filas y valores; que produzca el mismo conteo no basta para demostrar equivalencia.

## C. Explicar el límite

Vuelve a la decisión central de esta unidad: CASE usa la primera condición verdadera. COALESCE conserva el tipo compatible y no altera NULL en la tabla. AT TIME ZONE hace explícito el calendario del reporte. Una división entre enteros trunca; convierte antes de dividir si necesitas fracciones. CURRENT_TIMESTAMP es estable dentro de una transacción, no un reloj que avance en cada llamada.

Registra el dato cambiado, predicción, resultado y conclusión. Un resultado distinto es válido cuando cambió deliberadamente la población; uno inesperado exige revisar la consulta y el supuesto.

[Unidad](README.md) · [Caso y resultados de referencia](../docs/CASO_TIENDA.md)
