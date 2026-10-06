# Unidad 12: Agregaciones

[Volver al índice del curso](../README.md) · [Ver el curso en Aprende con Leli](https://lelyliliana.github.io/aprende-con-leli/cursos/bases-datos-sql/)

## Qué aprenderás
Resumir muchas filas con COUNT, SUM, AVG, MIN y MAX y comprender el efecto de NULL.

## Cómo usar los ejemplos de esta unidad

Los ejemplos breves ilustran una idea y pueden usar un conjunto reducido de filas o una tabla independiente. Para ejecutarlos juntos sin conflictos, utiliza el laboratorio y la práctica de esta unidad sobre la [tienda de referencia](../docs/CASO_TIENDA.md). Sus scripts declaran la preparación, resultados y rollback. No vuelvas a crear las tablas de tienda ni repitas su carga para seguir un fragmento ilustrativo.

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


---

## Laboratorio completo y lectura del resultado

**Caso:** ¿Promedio de precio por línea y por unidad responden la misma pregunta?

El promedio de cinco precios de línea da el mismo peso a una línea de una unidad que a otra de cinco. El ponderado usa cantidades. Las agregaciones ignoran NULL salvo COUNT(*), pero SUM vacío no es cero automáticamente. COUNT(DISTINCT columna) cuenta valores distintos no nulos.

### Paso a paso

1. Comprueba que estás en la base de práctica y que la [tienda](../docs/CASO_TIENDA.md) conserva sus datos iniciales.
2. Abre [LABORATORIO.sql](LABORATORIO.sql). Lee el script antes de enviarlo al servidor.
3. Predice el resultado de cada sentencia. Anota qué representa una fila y qué operaciones pueden cambiar datos.
4. Desde la raíz, ejecuta:

```text
psql -X -h localhost -U estudiante -d curso_sql -v ON_ERROR_STOP=1 -f unidad12-agregaciones/LABORATORIO.sql
```

La contraseña se solicita en la terminal; no la escribas en el repositorio.

5. Compara con la referencia: **5 filas, 3 descripciones, suma 430, promedio 86, mínimo 50, máximo 120. 11 unidades, valor 1010, promedio por línea 91, por unidad 91.82. Población vacía: COUNT 0 y SUM NULL.**
6. Termina con la [práctica](PRACTICA.md), luego contrasta tus decisiones con las [soluciones razonadas](SOLUCIONES.md).

### Transferir la idea a otro problema

Calcula valor y unidades de pedidos PAGADO, sin incluir creados o cancelados.

Explica cómo cambiarían los datos si aparece una fila adicional, una referencia ausente o un empate. Distingue una garantía del esquema de una suposición que solo cumple esta muestra. El objetivo es construir una respuesta justificable, no copiar una consulta sin entender su población.

## Continuar el curso

- **Unidad anterior:** [Unidad 11: Funciones y expresiones](../unidad11-funciones/README.md)
- **Volver al índice:** [Todas las unidades](../README.md)
- **Siguiente unidad:** [Unidad 13: GROUP BY y HAVING](../unidad13-group-having/README.md)

