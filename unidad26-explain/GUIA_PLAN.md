# Leer un plan de ejecución

Observa:
- Seq Scan / Index Scan;
- costo estimado;
- rows estimadas;
- actual time y actual rows con ANALYZE;
- loops;
- tipo de join.

## Estimación vs realidad
Una diferencia grande entre filas estimadas y reales puede afectar decisiones del plan.

## EXPLAIN ANALYZE
Ejecuta la consulta. Para UPDATE/DELETE/INSERT puede modificar datos si no controlas la transacción.

## Reto
Conserva dos planes antes/después de un cambio y explica evidencia, no solo “ahora es más rápido”.
