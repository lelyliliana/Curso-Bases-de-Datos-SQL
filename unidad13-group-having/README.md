# Unidad 13 — GROUP BY y HAVING
WHERE filtra filas antes de agrupar; HAVING filtra grupos.
```sql
SELECT categoria_id, COUNT(*) FROM producto GROUP BY categoria_id HAVING COUNT(*)>=5;
```
**Reto:** ventas por categoría con umbral.