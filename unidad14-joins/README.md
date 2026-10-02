# Unidad 14 — JOIN
INNER, LEFT, RIGHT/FULL cuando corresponda. Define condición ON conscientemente.
```sql
SELECT p.nombre,c.nombre FROM producto p JOIN categoria c ON c.id=p.categoria_id;
```
Un JOIN puede multiplicar filas por cardinalidad. **Reto:** explica cada fila del resultado antes de agregar DISTINCT.