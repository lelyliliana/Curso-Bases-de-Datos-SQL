# Unidad 09 — ORDER BY, LIMIT y DISTINCT
Sin ORDER BY no asumas orden estable.
```sql
ORDER BY precio DESC, id ASC LIMIT 10;
```
DISTINCT elimina duplicados del resultado, no arregla un modelo defectuoso. **Reto:** top-N determinista.