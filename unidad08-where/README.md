# Unidad 08 — WHERE y operadores

## Qué aprenderás
Filtrar filas con comparaciones, lógica, rangos, patrones y NULL.

# 1. Filtrar
```sql
SELECT nombre,precio FROM producto
WHERE precio > 80;
```
WHERE decide qué filas participan.

# 2. Comparaciones
`= <> > >= < <=`

```sql
WHERE activo = true
```
En PostgreSQL también: `WHERE activo`.

# 3. AND y OR
```sql
WHERE activo
  AND precio >= 90;
```

# 4. Paréntesis
```sql
WHERE activo
  AND (precio < 90 OR precio > 110);
```
Los paréntesis hacen explícita la lógica.

# 5. BETWEEN e IN
```sql
WHERE precio BETWEEN 80 AND 100;
WHERE id IN (1,3,5);
```
BETWEEN incluye extremos.

# 6. Patrones
```sql
WHERE nombre LIKE 'Base%';
```
PostgreSQL ofrece `ILIKE` para patrones sin distinguir mayúsculas/minúsculas según el entorno.

# 7. NULL
Incorrecto:
```sql
WHERE descripcion = NULL;
```
Correcto:
```sql
WHERE descripcion IS NULL;
```

SQL utiliza lógica de tres valores: TRUE, FALSE y UNKNOWN.

# 8. Práctica guiada
```sql
SELECT id,nombre,precio
FROM producto
WHERE activo
  AND precio BETWEEN 80 AND 100;
```
Cambia AND/OR y explica el resultado antes de ejecutar.

# 9. Error frecuente
`NOT IN` puede sorprender si interviene NULL. Más adelante veremos `NOT EXISTS` para anti-relaciones.

# 10. Ejercicios
1. Precio >=100.
2. Entre 80 y 120.
3. Nombre empieza por B.
4. IDs 1,2,5.
5. NULL.
6. AND/OR con paréntesis.

# 11. Reto
Escribe cinco filtros de negocio y crea datos de frontera.

# 12. Autoevaluación
1. ¿Qué hace WHERE?
2. ¿BETWEEN incluye extremos?
3. ¿Cómo consultas NULL?
4. ¿Por qué paréntesis?
5. ¿LIKE e ILIKE?
6. ¿Qué significa UNKNOWN?

# 13. Checklist
- [ ] Comparo.
- [ ] Combino AND/OR.
- [ ] Uso BETWEEN/IN.
- [ ] Manejo NULL.

Continúa con ORDER BY.
