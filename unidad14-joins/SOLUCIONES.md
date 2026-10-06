# Soluciones razonadas: Unidad 14

Intenta primero [PRACTICA.md](PRACTICA.md). Una consulta puede tener varias soluciones correctas si responde a la misma población, conserva cardinalidad y maneja los mismos límites.

## A. Laboratorio

**Resultado de referencia:** Conteos 2,2,1,0. El reporte de líneas contiene cinco filas; pedido 4 no tiene líneas. Conteos activos 2,2,0,0.

**Interpretación:** COUNT(*) contaría una fila para Deportes, aunque p.id es NULL; COUNT(p.id) devuelve cero. Poner p.activo en WHERE eliminaría categorías sin coincidencia; en ON limita coincidencias y mantiene el lado izquierdo. RIGHT JOIN invierte el lado conservado, FULL JOIN conserva ambos y CROSS JOIN forma combinaciones; ninguno corrige una clave de unión equivocada.

El script termina en `ROLLBACK`. Los cambios de tablas u objetos del laboratorio se revierten. Los valores de secuencia consumidos pueden dejar huecos; no uses una lista consecutiva de IDs como prueba de recuperación.

## B. Práctica adicional

**Enunciado:** Reporta los cinco pedidos con total, incluso el pedido vacío. Evita usar el precio de producto.

```sql
SELECT p.id,COALESCE(SUM(d.cantidad*d.precio_unitario),0) AS total FROM pedido p LEFT JOIN detalle_pedido d ON d.pedido_id=p.id GROUP BY p.id ORDER BY p.id;
```

**Resultado o evidencia:** Totales por id: 320,90,150,0,450.

La versión ejecutable está en [SOLUCION.sql](SOLUCION.sql). Identifica en ella la fuente de cada columna y las condiciones que limitan su alcance. Si propones otra forma, compara todas las filas y valores; que produzca el mismo conteo no basta para demostrar equivalencia.

## C. Explicar el límite

Vuelve a la decisión central de esta unidad: COUNT(*) contaría una fila para Deportes, aunque p.id es NULL; COUNT(p.id) devuelve cero. Poner p.activo en WHERE eliminaría categorías sin coincidencia; en ON limita coincidencias y mantiene el lado izquierdo. RIGHT JOIN invierte el lado conservado, FULL JOIN conserva ambos y CROSS JOIN forma combinaciones; ninguno corrige una clave de unión equivocada.

Registra el dato cambiado, predicción, resultado y conclusión. Un resultado distinto es válido cuando cambió deliberadamente la población; uno inesperado exige revisar la consulta y el supuesto.

[Unidad](README.md) · [Caso y resultados de referencia](../docs/CASO_TIENDA.md)
