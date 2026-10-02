# Práctica — Agregaciones y NULL

Compara:
```sql
SELECT COUNT(*) FROM cliente;
SELECT COUNT(correo) FROM cliente;
```

COUNT(columna) ignora NULL; COUNT(*) cuenta filas.

## Promedio ponderado
Para ventas:
```sql
SELECT SUM(cantidad*precio_unitario)/SUM(cantidad)
FROM detalle_pedido;
```

No confundas promedio de precios de líneas con precio promedio por unidad.

## Reto
Diseña cinco métricas y define exactamente qué representa cada denominador.
