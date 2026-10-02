# Práctica — Modificar con seguridad

Antes:
```sql
SELECT * FROM producto WHERE categoria_id = 1;
```

Después:
```sql
BEGIN;
UPDATE producto SET activo=false WHERE categoria_id=1;
SELECT * FROM producto WHERE categoria_id=1;
ROLLBACK;
```

## Regla
Primero demuestra qué filas selecciona tu WHERE.

## Reto
Diseña eliminación lógica y compárala con DELETE físico según requisitos.
