# Soluciones razonadas: Unidad 25

Intenta primero [PRACTICA.md](PRACTICA.md). Una consulta puede tener varias soluciones correctas si responde a la misma población, conserva cardinalidad y maneja los mismos límites.

## A. Laboratorio

**Resultado de referencia:** 100 coincidencias antes y después. Los planes y tiempos exactos dependen del entorno.

**Interpretación:** El filtro selecciona 100 de 100000 filas: es suficientemente selectivo para explorar una ruta por índice, sin exigir que un nodo específico aparezca. La PK y UNIQUE ya generan índices; una FK no crea automáticamente uno en su lado hijo. Un B-tree compuesto favorece filtros por columnas iniciales, aunque el optimizador puede usar otras estrategias según versión y distribución. No es una regla de imposible uso sin la primera columna.

El script termina en `ROLLBACK`. Los cambios de tablas u objetos del laboratorio se revierten. Los valores de secuencia consumidos pueden dejar huecos; no uses una lista consecutiva de IDs como prueba de recuperación.

## B. Práctica adicional

**Enunciado:** Compara igualdad selectiva con cliente_id>=0. ¿El mismo índice es útil para todas las filas?

```sql
CREATE TEMP TABLE selectividad_lab AS SELECT g AS id,g%1000 AS grupo FROM generate_series(1,100000) g;
CREATE INDEX selectividad_grupo_lab ON selectividad_lab(grupo);
ANALYZE selectividad_lab;
EXPLAIN (ANALYZE,BUFFERS) SELECT * FROM selectividad_lab WHERE grupo>=0;
SELECT COUNT(*) FROM selectividad_lab WHERE grupo>=0;
```

**Resultado o evidencia:** 100000 filas; un recorrido secuencial puede ser la mejor opción. No se exige un tiempo fijo.

La versión ejecutable está en [SOLUCION.sql](SOLUCION.sql). Identifica en ella la fuente de cada columna y las condiciones que limitan su alcance. Si propones otra forma, compara todas las filas y valores; que produzca el mismo conteo no basta para demostrar equivalencia.

## C. Explicar el límite

Vuelve a la decisión central de esta unidad: El filtro selecciona 100 de 100000 filas: es suficientemente selectivo para explorar una ruta por índice, sin exigir que un nodo específico aparezca. La PK y UNIQUE ya generan índices; una FK no crea automáticamente uno en su lado hijo. Un B-tree compuesto favorece filtros por columnas iniciales, aunque el optimizador puede usar otras estrategias según versión y distribución. No es una regla de imposible uso sin la primera columna.

Registra el dato cambiado, predicción, resultado y conclusión. Un resultado distinto es válido cuando cambió deliberadamente la población; uno inesperado exige revisar la consulta y el supuesto.

[Unidad](README.md) · [Caso y resultados de referencia](../docs/CASO_TIENDA.md)
