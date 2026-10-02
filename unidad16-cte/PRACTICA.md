# Práctica — CTE para explicar una consulta

```sql
WITH total_pedido AS (
 SELECT pedido_id,SUM(cantidad*precio_unitario) total
 FROM detalle_pedido
 GROUP BY pedido_id
)
SELECT p.id,t.total
FROM pedido p
JOIN total_pedido t ON t.pedido_id=p.id;
```

## Objetivo
Nombrar un paso lógico y facilitar lectura.

## Reto
Descompón un reporte de tres etapas usando CTE y después compara con subconsulta equivalente.
