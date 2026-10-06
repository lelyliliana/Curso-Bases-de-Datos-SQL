# Soluciones razonadas: Unidad 24

Intenta primero [PRACTICA.md](PRACTICA.md). Una consulta puede tener varias soluciones correctas si responde a la misma población, conserva cardinalidad y maneja los mismos límites.

## A. Laboratorio

**Resultado de referencia:** El aislamiento predeterminado es read committed. Esta ejecución toma y libera un bloqueo al hacer rollback.

**Interpretación:** MVCC permite que un SELECT normal lea la versión confirmada mientras otra sesión modifica la fila. SELECT FOR UPDATE y UPDATE pueden esperar. La práctica de dos sesiones muestra esa diferencia y utiliza lock_timeout para evitar esperas indefinidas. En PostgreSQL READ UNCOMMITTED se comporta como READ COMMITTED; no hay lecturas sucias.

El script termina en `ROLLBACK`. Los cambios de tablas u objetos del laboratorio se revierten. Los valores de secuencia consumidos pueden dejar huecos; no uses una lista consecutiva de IDs como prueba de recuperación.

## B. Práctica adicional

**Enunciado:** Reproduce una espera de bloqueo y compara snapshots READ COMMITTED y REPEATABLE READ con dos sesiones.

```sql
SHOW transaction_isolation; SELECT id,precio FROM producto WHERE id=1;
```

**Resultado o evidencia:** Consulta DOS_SESIONES.md: valor confirmado 80, espera controlada y cambios visibles por sentencia o por transacción.

La versión ejecutable está en [SOLUCION.sql](SOLUCION.sql). Identifica en ella la fuente de cada columna y las condiciones que limitan su alcance. Si propones otra forma, compara todas las filas y valores; que produzca el mismo conteo no basta para demostrar equivalencia.

## C. Explicar el límite

Vuelve a la decisión central de esta unidad: MVCC permite que un SELECT normal lea la versión confirmada mientras otra sesión modifica la fila. SELECT FOR UPDATE y UPDATE pueden esperar. La práctica de dos sesiones muestra esa diferencia y utiliza lock_timeout para evitar esperas indefinidas. En PostgreSQL READ UNCOMMITTED se comporta como READ COMMITTED; no hay lecturas sucias.

Registra el dato cambiado, predicción, resultado y conclusión. Un resultado distinto es válido cuando cambió deliberadamente la población; uno inesperado exige revisar la consulta y el supuesto.

[Unidad](README.md) · [Caso y resultados de referencia](../docs/CASO_TIENDA.md)
