# Práctica — Acciones referenciales

Compara:
```sql
REFERENCES pedido(id) ON DELETE CASCADE
```
para detalle_pedido, con la relación cliente→pedido.

Borrar un pedido puede justificar borrar sus detalles. Borrar un cliente con historial puede requerir otra política.

## Reto
Para cinco FK decide CASCADE, RESTRICT/NO ACTION o SET NULL y justifica semánticamente.
