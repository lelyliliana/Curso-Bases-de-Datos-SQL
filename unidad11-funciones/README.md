# Unidad 11 — Funciones y expresiones
CASE, COALESCE, funciones de texto, fecha y numéricas.
```sql
SELECT nombre, COALESCE(descripcion,'Sin descripción') FROM producto;
```
Distingue funciones estándar de específicas del motor. **Reto:** reporte con columnas calculadas.