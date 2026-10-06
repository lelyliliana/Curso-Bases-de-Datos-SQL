# Soluciones razonadas: Unidad 07

Intenta primero [PRACTICA.md](PRACTICA.md). Una consulta puede tener varias soluciones correctas si responde a la misma población, conserva cardinalidad y maneja los mismos límites.

## A. Laboratorio

**Resultado de referencia:** Descuentos: 72.00, 81.00, 108.00, 81.00, 45.00. El precio guardado del producto 1 sigue en 80.00.

**Interpretación:** La proyección selecciona atributos, AS nombra una columna del resultado y una expresión calcula un valor. Esta consulta no contiene operaciones con efectos laterales. En general, SELECT puede llamar funciones que sí modifiquen datos: observa lo que ejecutas, no solo la primera palabra.

El script termina en `ROLLBACK`. Los cambios de tablas u objetos del laboratorio se revierten. Los valores de secuencia consumidos pueden dejar huecos; no uses una lista consecutiva de IDs como prueba de recuperación.

## B. Práctica adicional

**Enunciado:** Muestra id, nombre y costo de tres unidades, sin alterar el precio almacenado.

```sql
SELECT id,nombre,precio*3 AS tres_unidades FROM producto ORDER BY id;
```

**Resultado o evidencia:** 240.00, 270.00, 360.00, 270.00, 150.00, en orden de id.

La versión ejecutable está en [SOLUCION.sql](SOLUCION.sql). Identifica en ella la fuente de cada columna y las condiciones que limitan su alcance. Si propones otra forma, compara todas las filas y valores; que produzca el mismo conteo no basta para demostrar equivalencia.

## C. Explicar el límite

Vuelve a la decisión central de esta unidad: La proyección selecciona atributos, AS nombra una columna del resultado y una expresión calcula un valor. Esta consulta no contiene operaciones con efectos laterales. En general, SELECT puede llamar funciones que sí modifiquen datos: observa lo que ejecutas, no solo la primera palabra.

Registra el dato cambiado, predicción, resultado y conclusión. Un resultado distinto es válido cuando cambió deliberadamente la población; uno inesperado exige revisar la consulta y el supuesto.

[Unidad](README.md) · [Caso y resultados de referencia](../docs/CASO_TIENDA.md)
