# Práctica — Dos sesiones

Abre dos conexiones a PostgreSQL.

## Sesión A
```sql
BEGIN;
UPDATE producto SET precio=150 WHERE id=1;
```

No hagas COMMIT todavía.

## Sesión B
Intenta actualizar la misma fila y observa bloqueo/espera según operación.

## Luego
COMMIT o ROLLBACK en A y observa B.

## Objetivo
Ver que concurrencia no es teoría: transacciones compiten por recursos.

## Reto
Documenta qué observaste y diferencia bloqueo de error.
