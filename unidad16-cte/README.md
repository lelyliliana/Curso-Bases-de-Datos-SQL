# Unidad 16 — CTE: nombrar etapas de una consulta

## Qué aprenderás
Usar WITH para dividir consultas complejas en pasos legibles y comprender que una CTE no implica automáticamente mejor rendimiento.

# 1. Problema

Queremos calcular total de cada pedido y después mostrar solo los mayores a 100.

Podríamos anidar consultas, pero podemos nombrar el paso.

# 2. CTE

```sql
WITH total_pedido AS (
  SELECT pedido_id,
         SUM(cantidad*precio_unitario) AS total
  FROM detalle_pedido
  GROUP BY pedido_id
)
SELECT pedido_id,total
FROM total_pedido
WHERE total > 100;
```

# 3. Léelo como una historia

```text
Paso 1: total_pedido
        ↓
Paso 2: filtrar total > 100
```

La CTE crea un nombre para un resultado intermedio dentro de la sentencia.

# 4. Varias CTE

```sql
WITH
total_pedido AS (...),
pedidos_altos AS (
  SELECT * FROM total_pedido WHERE total > 100
)
SELECT * FROM pedidos_altos;
```

Úsalo cuando cada etapa tenga significado. No fragmentes una consulta sencilla solo por usar WITH.

# 5. CTE vs vista

Una CTE vive dentro de una sentencia. Una vista es un objeto persistente del esquema que estudiaremos después.

# 6. Rendimiento

No afirmes “CTE es más rápida”. El optimizador de PostgreSQL puede tratar CTE de distintas formas según versión, consulta y opciones. Usa EXPLAIN cuando rendimiento importe.

# 7. CTE recursiva

PostgreSQL soporta `WITH RECURSIVE` para problemas jerárquicos/grafos. Aquí solo reconocemos el concepto; requiere un caso donde la recursión tenga sentido.

# 8. Práctica guiada

Crea:
1. CTE con total por pedido.
2. Únela a PEDIDO.
3. Añade CLIENTE.
4. Filtra totales.

En cada etapa ejecuta y observa columnas.

# 9. Errores frecuentes

- Usar CTE como almacenamiento permanente.
- Suponer mejora de rendimiento.
- Crear nombres sin significado.
- Construir demasiadas etapas para una consulta trivial.

# 10. Ejercicios

- total por pedido;
- ventas por cliente;
- categorías con métricas;
- dos etapas de filtrado;
- reescribe una subconsulta como CTE.

# 11. Reto

Construye un reporte de clientes con total pagado usando al menos dos etapas claramente justificadas.

# 12. Autoevaluación

1. ¿Qué hace WITH?
2. ¿Cuánto vive una CTE?
3. ¿CTE y vista son iguales?
4. ¿CTE garantiza mejor rendimiento?
5. ¿Qué ventaja pedagógica/estructural ofrece?

# 13. Checklist

- [ ] Creo CTE.
- [ ] Nombro etapas con sentido.
- [ ] Distingo CTE/vista.
- [ ] No hago afirmaciones de rendimiento sin medir.

Continúa con operaciones de conjuntos.
