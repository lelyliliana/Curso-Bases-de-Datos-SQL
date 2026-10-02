# Práctica — Índices con evidencia

## Consulta
Elige una consulta frecuente, por ejemplo:
```sql
SELECT * FROM producto WHERE nombre = 'Teclado';
```

## Antes
Ejecuta EXPLAIN (ANALYZE solo en entorno de práctica cuando sea seguro) y registra plan.

## Crear índice
```sql
CREATE INDEX idx_producto_nombre ON producto(nombre);
```

## Después
Repite.

## Importante
Con tres filas PostgreSQL puede preferir sequential scan porque es más barato. Un índice **no obliga** al optimizador a usarlo.

Para experimentar, genera suficientes datos.

## Costo
El índice ocupa espacio y debe mantenerse en INSERT/UPDATE/DELETE.

## Reto
Compara una consulta que se beneficia y otra donde el índice no aporta.
