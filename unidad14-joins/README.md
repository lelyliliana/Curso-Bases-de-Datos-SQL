# Unidad 14 — JOIN: combinar tablas

## Qué aprenderás
Comprender por qué necesitamos JOIN, construir INNER/LEFT JOIN y razonar la cardinalidad antes de ejecutar.

# 1. El problema

PRODUCTO guarda `categoria_id`, no el nombre:

**categoria**

| id | nombre |
|---:|---|
| 1 | Libros |
| 2 | Tecnología |
| 3 | Hogar |

**producto**

| id | categoria_id | nombre |
|---:|---:|---|
| 10 | 1 | Algoritmos |
| 11 | 1 | Bases de Datos |
| 12 | 2 | Teclado |

Queremos:

| producto | categoria |
|---|---|
| Algoritmos | Libros |
| Bases de Datos | Libros |
| Teclado | Tecnología |

# 2. INNER JOIN

```sql
SELECT p.nombre AS producto,
       c.nombre AS categoria
FROM producto p
JOIN categoria c
  ON c.id = p.categoria_id;
```

Lee `ON` como la condición que dice qué filas se relacionan.

# 3. Qué ocurre conceptualmente

Producto 10 tiene categoria_id=1.

Buscamos:
```text
categoria.id = 1
```

Encontramos Libros y formamos una fila combinada.

Se repite para cada producto.

# 4. Cardinalidad y multiplicación de filas

Pedido 1 tiene tres detalles.

```sql
SELECT p.id,d.producto_id
FROM pedido p
JOIN detalle_pedido d ON d.pedido_id=p.id;
```

Pedido 1 aparecerá tres veces.

Eso **no es automáticamente un duplicado**. Cada fila representa un detalle diferente.

# 5. LEFT JOIN

La categoría Hogar no tiene productos.

```sql
SELECT c.nombre,p.nombre
FROM categoria c
LEFT JOIN producto p
  ON p.categoria_id=c.id;
```

Hogar aparece igualmente; las columnas de producto serán NULL.

LEFT JOIN conserva las filas del lado izquierdo aunque no exista coincidencia.

# 6. INNER vs LEFT

Pregunta:
> “Mostrar productos con su categoría.”

INNER puede ser apropiado si todo producto válido tiene categoría.

Pregunta:
> “Mostrar todas las categorías, incluso vacías.”

Necesitamos conservar categorías: LEFT JOIN.

El tipo de JOIN depende de la pregunta.

# 7. Tres tablas

```sql
SELECT pe.id AS pedido,
       pr.nombre AS producto,
       d.cantidad
FROM pedido pe
JOIN detalle_pedido d ON d.pedido_id=pe.id
JOIN producto pr ON pr.id=d.producto_id;
```

Antes de ejecutar, predice una fila por cada detalle.

# 8. Encontrar quienes no tienen relación

```sql
SELECT c.id,c.nombre
FROM cliente c
LEFT JOIN pedido p ON p.cliente_id=c.id
WHERE p.id IS NULL;
```

Más adelante compararemos con NOT EXISTS.

# 9. Error frecuente: JOIN sin condición correcta

Una condición ausente/equivocada puede producir combinaciones masivas.

Siempre pregunta:
> ¿qué columna de A corresponde a qué columna de B?

# 10. Error frecuente: DISTINCT como curita

Si aparecen varias filas, investiga cardinalidad antes de añadir DISTINCT.

# 11. Práctica guiada

1. Producto + categoría.
2. Pedido + cliente.
3. Pedido + detalle.
4. Añade producto.
5. Predice filas en cada etapa.
6. Crea categoría sin productos y compara INNER/LEFT.

# 12. Ejercicios

- productos/categorías;
- pedidos/clientes;
- detalles/productos;
- categorías vacías;
- clientes sin pedidos.

Para cada uno anota cardinalidad esperada.

# 13. Reto

Construye un reporte:
```text
pedido | cliente | producto | cantidad | subtotal
```

Explica qué representa **una fila** del resultado.

# 14. Autoevaluación

1. ¿Qué hace ON?
2. ¿Qué conserva LEFT JOIN?
3. ¿Por qué un pedido puede repetirse?
4. ¿Cuándo varias filas son correctas?
5. ¿Por qué DISTINCT puede ocultar un error?
6. ¿Qué pregunta debes hacer antes de elegir JOIN?

# 15. Checklist

- [ ] Construyo INNER JOIN.
- [ ] Construyo LEFT JOIN.
- [ ] Predigo cardinalidad.
- [ ] Comprendo filas multiplicadas.
- [ ] No uso DISTINCT sin explicación.

Continúa con subconsultas.
