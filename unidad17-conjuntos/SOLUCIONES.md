# Soluciones razonadas: Unidad 17

Intenta primero [PRACTICA.md](PRACTICA.md). Una consulta puede tener varias soluciones correctas si responde a la misma población, conserva cardinalidad y maneja los mismos límites.

## A. Laboratorio

**Resultado de referencia:** UNION: 1,2,3. UNION ALL: 1,1,2,2,3. INTERSECT: 2. EXCEPT: 1.

**Interpretación:** Los tipos se alinean por posición, no por nombre. INTERSECT/EXCEPT sin ALL eliminan duplicados. Para estas operaciones dos NULL se tratan como no distintos, a diferencia de una comparación NULL=NULL. ORDER BY al final ordena el resultado combinado. Si agregas fuente, dos filas con el mismo correo pero distinta fuente ya no son duplicadas de toda la proyección.

El script termina en `ROLLBACK`. Los cambios de tablas u objetos del laboratorio se revierten. Los valores de secuencia consumidos pueden dejar huecos; no uses una lista consecutiva de IDs como prueba de recuperación.

## B. Práctica adicional

**Enunciado:** Combina dos fuentes con el mismo correo conservando la procedencia. Explica por qué UNION no eliminaría esas dos filas si fuente es distinta.

```sql
SELECT 'ana@example.com'::text AS correo,'archivo_a'::text AS fuente UNION ALL SELECT 'ana@example.com','archivo_b' ORDER BY fuente;
```

**Resultado o evidencia:** Dos filas, una por archivo. La procedencia forma parte del resultado.

La versión ejecutable está en [SOLUCION.sql](SOLUCION.sql). Identifica en ella la fuente de cada columna y las condiciones que limitan su alcance. Si propones otra forma, compara todas las filas y valores; que produzca el mismo conteo no basta para demostrar equivalencia.

## C. Explicar el límite

Vuelve a la decisión central de esta unidad: Los tipos se alinean por posición, no por nombre. INTERSECT/EXCEPT sin ALL eliminan duplicados. Para estas operaciones dos NULL se tratan como no distintos, a diferencia de una comparación NULL=NULL. ORDER BY al final ordena el resultado combinado. Si agregas fuente, dos filas con el mismo correo pero distinta fuente ya no son duplicadas de toda la proyección.

Registra el dato cambiado, predicción, resultado y conclusión. Un resultado distinto es válido cuando cambió deliberadamente la población; uno inesperado exige revisar la consulta y el supuesto.

[Unidad](README.md) · [Caso y resultados de referencia](../docs/CASO_TIENDA.md)
