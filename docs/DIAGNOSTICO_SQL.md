# Diagnóstico SQL

## Sintaxis
¿PostgreSQL acepta la sentencia?

## Datos
¿filas esperadas existen?

## Filtro
¿NULL/AND/OR cambian lógica?

## JOIN
¿cardinalidad multiplica filas?

## Integridad
¿constraint rechaza correctamente?

## Transacción
¿commit/rollback y locks?

## Rendimiento
¿plan, filas estimadas/reales e índice?

## Regla
“La consulta está mala” no es diagnóstico. Identifica si falla sintaxis, lógica, modelo, datos o plan.
