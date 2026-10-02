# Unidad 10 — UPDATE y DELETE
```sql
UPDATE producto SET precio=130 WHERE id=1;
DELETE FROM producto WHERE id=1;
```
Antes de modificar masivamente, verifica el WHERE con SELECT. Usa transacciones cuando corresponda. **Reto:** actualización controlada y rollback.