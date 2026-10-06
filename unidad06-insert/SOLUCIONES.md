# Soluciones razonadas: Unidad 06

Intenta primero [PRACTICA.md](PRACTICA.md). Una consulta puede tener varias soluciones correctas si responde a la misma población, conserva cardinalidad y maneja los mismos límites.

## A. Laboratorio

**Resultado de referencia:** Producto de laboratorio, 25.00, true, NULL; una categoría nueva dentro de la transacción.

**Interpretación:** RETURNING permite utilizar el ID que realmente se generó. No calcules MAX(id)+1: dos sesiones podrían obtener el mismo candidato. La CTE con INSERT es una extensión de PostgreSQL que une las dos instrucciones; primero puedes probarlas por separado leyendo el ID devuelto. El ROLLBACK elimina filas, pero no devuelve los valores consumidos de secuencias.

El script termina en `ROLLBACK`. Los cambios de tablas u objetos del laboratorio se revierten. Los valores de secuencia consumidos pueden dejar huecos; no uses una lista consecutiva de IDs como prueba de recuperación.

## B. Práctica adicional

**Enunciado:** Inserta un cliente ficticio con teléfono omitido y devuelve nombre, correo y teléfono. Verifica después del rollback que no existe.

```sql
INSERT INTO cliente(nombre,correo) VALUES ('Nora','nora.lab@example.com') RETURNING nombre,correo,telefono;
```

**Resultado o evidencia:** Nora, nora.lab@example.com, NULL. Repite sin modificar la carga original.

La versión ejecutable está en [SOLUCION.sql](SOLUCION.sql). Identifica en ella la fuente de cada columna y las condiciones que limitan su alcance. Si propones otra forma, compara todas las filas y valores; que produzca el mismo conteo no basta para demostrar equivalencia.

## C. Explicar el límite

Vuelve a la decisión central de esta unidad: RETURNING permite utilizar el ID que realmente se generó. No calcules MAX(id)+1: dos sesiones podrían obtener el mismo candidato. La CTE con INSERT es una extensión de PostgreSQL que une las dos instrucciones; primero puedes probarlas por separado leyendo el ID devuelto. El ROLLBACK elimina filas, pero no devuelve los valores consumidos de secuencias.

Registra el dato cambiado, predicción, resultado y conclusión. Un resultado distinto es válido cuando cambió deliberadamente la población; uno inesperado exige revisar la consulta y el supuesto.

[Unidad](README.md) · [Caso y resultados de referencia](../docs/CASO_TIENDA.md)
