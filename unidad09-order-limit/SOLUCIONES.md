# Soluciones razonadas: Unidad 09

Intenta primero [PRACTICA.md](PRACTICA.md). Una consulta puede tener varias soluciones correctas si responde a la misma población, conserva cardinalidad y maneja los mismos límites.

## A. Laboratorio

**Resultado de referencia:** Top: Teclado (3,120), Bases de datos (2,90), Mouse (4,90). Precios distintos: 50,80,90,120.

**Interpretación:** DISTINCT compara todas las columnas proyectadas: SELECT DISTINCT id,precio conservaría los cinco productos porque id es diferente. LIMIT sin orden no expresa los más caros. Agregar id desempata; NULLS LAST explicita dónde van los desconocidos. Para páginas grandes, OFFSET recorre filas anteriores y puede cambiar si llegan nuevos datos; una clave de continuación estable puede ser preferible.

El script termina en `ROLLBACK`. Los cambios de tablas u objetos del laboratorio se revierten. Los valores de secuencia consumidos pueden dejar huecos; no uses una lista consecutiva de IDs como prueba de recuperación.

## B. Práctica adicional

**Enunciado:** Obtén los dos productos más baratos, desempata por id y explica qué pasaría si ambos tuvieran el mismo precio.

```sql
SELECT id,nombre,precio FROM producto ORDER BY precio,id LIMIT 2;
```

**Resultado o evidencia:** Lámpara (5,50) y Algoritmos (1,80). En empate se elige primero el menor id.

La versión ejecutable está en [SOLUCION.sql](SOLUCION.sql). Identifica en ella la fuente de cada columna y las condiciones que limitan su alcance. Si propones otra forma, compara todas las filas y valores; que produzca el mismo conteo no basta para demostrar equivalencia.

## C. Explicar el límite

Vuelve a la decisión central de esta unidad: DISTINCT compara todas las columnas proyectadas: SELECT DISTINCT id,precio conservaría los cinco productos porque id es diferente. LIMIT sin orden no expresa los más caros. Agregar id desempata; NULLS LAST explicita dónde van los desconocidos. Para páginas grandes, OFFSET recorre filas anteriores y puede cambiar si llegan nuevos datos; una clave de continuación estable puede ser preferible.

Registra el dato cambiado, predicción, resultado y conclusión. Un resultado distinto es válido cuando cambió deliberadamente la población; uno inesperado exige revisar la consulta y el supuesto.

[Unidad](README.md) · [Caso y resultados de referencia](../docs/CASO_TIENDA.md)
