# Práctica — Perfilado de calidad

Antes de limpiar, mide.

## NULL
```sql
SELECT COUNT(*) FILTER (WHERE correo IS NULL) AS sin_correo FROM cliente;
```

## Duplicados
```sql
SELECT correo,COUNT(*) FROM cliente GROUP BY correo HAVING COUNT(*)>1;
```

## Rangos
Busca precios <= 0, cantidades imposibles o fechas fuera del dominio esperado.

## Staging
Importa datos externos a una tabla staging cuando necesites validar/transformar antes de integrarlos al modelo principal.

## Trazabilidad
Conserva:
- regla;
- cantidad afectada;
- transformación;
- resultado.

## Reto
Produce un reporte de calidad antes y después de la limpieza.
