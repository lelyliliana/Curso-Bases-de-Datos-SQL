# Unidad 26 — EXPLAIN y planes de ejecución
```sql
EXPLAIN SELECT ...;
EXPLAIN ANALYZE SELECT ...;
```
ANALYZE ejecuta la consulta: cuidado con operaciones modificadoras.
Observa scan, join, estimaciones y filas reales.
**Reto:** compara consulta antes/después de índice con datos suficientes.