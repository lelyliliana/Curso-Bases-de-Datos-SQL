# Práctica — EXISTS vs IN

## EXISTS
```sql
SELECT c.*
FROM cliente c
WHERE EXISTS (
 SELECT 1 FROM pedido p WHERE p.cliente_id=c.id
);
```

Expresa “existe al menos una fila relacionada”.

## NOT IN y NULL
Investiga el comportamiento cuando la subconsulta puede devolver NULL. NOT EXISTS suele expresar de forma segura una anti-relación.

## Reto
Clientes sin pedidos mediante NOT EXISTS y mediante LEFT JOIN ... IS NULL; compara claridad.
