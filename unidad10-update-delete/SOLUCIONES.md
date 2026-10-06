# Soluciones razonadas: Unidad 10

Intenta primero [PRACTICA.md](PRACTICA.md). Una consulta puede tener varias soluciones correctas si responde a la misma población, conserva cardinalidad y maneja los mismos límites.

## A. Laboratorio

**Resultado de referencia:** Precios iniciales 80/90, después 88/99. Se elimina temporalmente Lámpara y quedan cuatro productos. Después de ROLLBACK hay cinco y los precios originales.

**Interpretación:** Comprueba primero SELECT con el criterio, luego RETURNING y número de filas. Esta inspección no bloquea por sí sola cambios concurrentes. En una operación real que dependa de una lectura previa, se necesita aislamiento o bloqueo adecuado. DELETE de Teclado fallaría porque está referenciado; no desactives la FK para resolverlo.

El script termina en `ROLLBACK`. Los cambios de tablas u objetos del laboratorio se revierten. Los valores de secuencia consumidos pueden dejar huecos; no uses una lista consecutiva de IDs como prueba de recuperación.

## B. Práctica adicional

**Enunciado:** Desactiva los productos de Tecnología sin borrar su historia y comprueba cuáles cambian.

```sql
UPDATE producto SET activo=false WHERE categoria_id=2 RETURNING id,nombre,activo;
```

**Resultado o evidencia:** Productos 3 y 4 pasan a false solo dentro de la transacción.

La versión ejecutable está en [SOLUCION.sql](SOLUCION.sql). Identifica en ella la fuente de cada columna y las condiciones que limitan su alcance. Si propones otra forma, compara todas las filas y valores; que produzca el mismo conteo no basta para demostrar equivalencia.

## C. Explicar el límite

Vuelve a la decisión central de esta unidad: Comprueba primero SELECT con el criterio, luego RETURNING y número de filas. Esta inspección no bloquea por sí sola cambios concurrentes. En una operación real que dependa de una lectura previa, se necesita aislamiento o bloqueo adecuado. DELETE de Teclado fallaría porque está referenciado; no desactives la FK para resolverlo.

Registra el dato cambiado, predicción, resultado y conclusión. Un resultado distinto es válido cuando cambió deliberadamente la población; uno inesperado exige revisar la consulta y el supuesto.

[Unidad](README.md) · [Caso y resultados de referencia](../docs/CASO_TIENDA.md)
