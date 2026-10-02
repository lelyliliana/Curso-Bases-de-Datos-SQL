# Unidad 07 — SELECT: consultar datos

## Qué aprenderás
Seleccionar columnas, crear alias y expresiones y comprender que una consulta no modifica datos.

# 1. Consulta
```sql
SELECT id,nombre,precio
FROM producto;
```

# 2. SELECT *
```sql
SELECT * FROM producto;
```
Es útil para exploración. Para reportes/contratos, indicar columnas deja clara la intención y evita traer datos innecesarios.

# 3. Proyección
```sql
SELECT nombre,precio
FROM producto;
```

# 4. Alias
```sql
SELECT nombre AS producto,
       precio AS precio_unitario
FROM producto;
```
El alias cambia el encabezado del resultado, no el esquema.

# 5. Expresiones
```sql
SELECT nombre,
       precio,
       precio * 1.19 AS precio_con_impuesto
FROM producto;
```
El cálculo no actualiza precio.

# 6. Práctica guiada
Datos:

| id | nombre | precio |
|---:|---|---:|
| 1 | Algoritmos | 80 |
| 2 | Bases de Datos | 90 |
| 3 | Teclado | 120 |

Ejecuta:
```sql
SELECT nombre,precio*2 AS precio_dos_unidades
FROM producto;
```

Predice el resultado antes de ejecutarlo.

# 7. SELECT sin FROM
PostgreSQL permite:
```sql
SELECT 2+3 AS resultado;
```

# 8. Errores frecuentes
- Creer que una expresión modifica la tabla.
- Asumir un orden sin ORDER BY.
- Pedir todas las columnas por costumbre.

# 9. Ejercicios
1. Solo nombres.
2. Nombre+precio.
3. Alias.
4. Precio de tres unidades.
5. Descuento calculado sin UPDATE.

# 10. Reto
Diseña consultas distintas para catálogo público, inventario interno y facturación.

# 11. Autoevaluación
1. ¿Qué es proyección?
2. ¿AS modifica la tabla?
3. ¿Una expresión cambia datos?
4. ¿SELECT garantiza orden?
5. ¿Cuándo SELECT * es útil?

# 12. Checklist
- [ ] Selecciono columnas.
- [ ] Uso alias.
- [ ] Creo expresiones.
- [ ] Distingo consultar de modificar.

Continúa con WHERE.
