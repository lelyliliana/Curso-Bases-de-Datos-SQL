# Unidad 12 — Agregaciones

## Qué aprenderás
Resumir muchas filas con COUNT, SUM, AVG, MIN y MAX y comprender el efecto de NULL.

# 1. De filas a una medida

| nombre | precio |
|---|---:|
| Algoritmos | 80 |
| Bases de Datos | 90 |
| Teclado | 120 |

```sql
SELECT COUNT(*) cantidad,
       SUM(precio) suma,
       AVG(precio) promedio,
       MIN(precio) minimo,
       MAX(precio) maximo
FROM producto;
```

Resultado conceptual: una fila que resume las tres.

# 2. COUNT(*) vs COUNT(columna)

Con descripciones `Libro, NULL, Teclado`:

```text
COUNT(*) = 3
COUNT(descripcion) = 2
```

COUNT(columna) ignora NULL.

# 3. NULL

SUM, AVG, MIN y MAX normalmente ignoran valores NULL. No conviertas automáticamente “desconocido” en cero.

# 4. Agregar expresiones

```sql
SELECT SUM(cantidad * precio_unitario) AS total
FROM detalle_pedido;
```

Si hay 1×80 y 2×120, total = 320.

# 5. El promedio depende de la pregunta

Promedio de precios por línea no es necesariamente precio promedio por unidad.

Un promedio ponderado podría usar:

```sql
SELECT SUM(cantidad*precio_unitario) / SUM(cantidad)
FROM detalle_pedido;
```

Define primero qué significa la métrica.

# 6. Práctica guiada

Responde:
1. ¿cuántos productos?
2. ¿precio mínimo?
3. ¿máximo?
4. ¿promedio?
5. ¿valor total de líneas?

Antes del SQL escribe qué filas participan.

# 7. Error frecuente

“Promedio de ventas” puede significar por pedido, cliente, día, unidad o línea. SQL correcto para la pregunta equivocada sigue siendo una respuesta equivocada.

# 8. Ejercicios

Cuenta clientes/pedidos, suma unidades, calcula valor total y compara COUNT(*) con COUNT(columna).

# 9. Reto

Define cinco métricas. Para cada una explica población, numerador y denominador cuando corresponda.

# 10. Autoevaluación

1. ¿COUNT(*) y COUNT(columna) son iguales?
2. ¿Cómo afecta NULL?
3. ¿SUM acepta expresiones?
4. ¿Por qué dos promedios pueden diferir?
5. ¿Qué debes definir antes de una métrica?

# 11. Checklist

- [ ] Uso agregaciones.
- [ ] Comprendo NULL.
- [ ] Agrego expresiones.
- [ ] Defino la métrica antes del SQL.

Continúa con GROUP BY.
