# Soluciones razonadas: Unidad 08

Intenta primero [PRACTICA.md](PRACTICA.md). Una consulta puede tener varias soluciones correctas si responde a la misma población, conserva cardinalidad y maneja los mismos límites.

## A. Laboratorio

**Resultado de referencia:** Primer filtro: 1,2,4. Sin descripción: 2,4. Comparaciones: NULL, true, false, true.

**Interpretación:** WHERE conserva solo TRUE. UNKNOWN (representado por NULL) no pasa el filtro. BETWEEN incluye extremos. AND tiene precedencia sobre OR; expresa paréntesis para que el negocio sea visible. ILIKE depende de reglas de comparación y no implica que dos textos con y sin tilde sean equivalentes.

El script termina en `ROLLBACK`. Los cambios de tablas u objetos del laboratorio se revierten. Los valores de secuencia consumidos pueden dejar huecos; no uses una lista consecutiva de IDs como prueba de recuperación.

## B. Práctica adicional

**Enunciado:** Encuentra clientes sin teléfono y productos activos cuyo precio sea menor que 90 o mayor que 110.

```sql
SELECT id,nombre FROM cliente WHERE telefono IS NULL ORDER BY id; SELECT id,nombre FROM producto WHERE activo AND (precio<90 OR precio>110) ORDER BY id;
```

**Resultado o evidencia:** Clientes 2,3; productos 1,3.

La versión ejecutable está en [SOLUCION.sql](SOLUCION.sql). Identifica en ella la fuente de cada columna y las condiciones que limitan su alcance. Si propones otra forma, compara todas las filas y valores; que produzca el mismo conteo no basta para demostrar equivalencia.

## C. Explicar el límite

Vuelve a la decisión central de esta unidad: WHERE conserva solo TRUE. UNKNOWN (representado por NULL) no pasa el filtro. BETWEEN incluye extremos. AND tiene precedencia sobre OR; expresa paréntesis para que el negocio sea visible. ILIKE depende de reglas de comparación y no implica que dos textos con y sin tilde sean equivalentes.

Registra el dato cambiado, predicción, resultado y conclusión. Un resultado distinto es válido cuando cambió deliberadamente la población; uno inesperado exige revisar la consulta y el supuesto.

[Unidad](README.md) · [Caso y resultados de referencia](../docs/CASO_TIENDA.md)
