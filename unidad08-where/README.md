# Unidad 08: WHERE y operadores

[Volver al índice del curso](../README.md) · [Ver el curso en Aprende con Leli](https://lelyliliana.github.io/aprende-con-leli/cursos/bases-datos-sql/)

## Qué aprenderás
Filtrar filas con comparaciones, lógica, rangos, patrones y NULL.

## Cómo usar los ejemplos de esta unidad

Los ejemplos breves ilustran una idea y pueden usar un conjunto reducido de filas o una tabla independiente. Para ejecutarlos juntos sin conflictos, utiliza el laboratorio y la práctica de esta unidad sobre la [tienda de referencia](../docs/CASO_TIENDA.md). Sus scripts declaran la preparación, resultados y rollback. No vuelvas a crear las tablas de tienda ni repitas su carga para seguir un fragmento ilustrativo.

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


---

## Laboratorio completo y lectura del resultado

**Caso:** ¿Por qué no aparece ninguna fila al comparar una columna con NULL mediante igual?

WHERE conserva solo TRUE. UNKNOWN (representado por NULL) no pasa el filtro. BETWEEN incluye extremos. AND tiene precedencia sobre OR; expresa paréntesis para que el negocio sea visible. ILIKE depende de reglas de comparación y no implica que dos textos con y sin tilde sean equivalentes.

### Paso a paso

1. Comprueba que estás en la base de práctica y que la [tienda](../docs/CASO_TIENDA.md) conserva sus datos iniciales.
2. Abre [LABORATORIO.sql](LABORATORIO.sql). Lee el script antes de enviarlo al servidor.
3. Predice el resultado de cada sentencia. Anota qué representa una fila y qué operaciones pueden cambiar datos.
4. Desde la raíz, ejecuta:

```text
psql -X -h localhost -U estudiante -d curso_sql -v ON_ERROR_STOP=1 -f unidad08-where/LABORATORIO.sql
```

La contraseña se solicita en la terminal; no la escribas en el repositorio.

5. Compara con la referencia: **Primer filtro: 1,2,4. Sin descripción: 2,4. Comparaciones: NULL, true, false, true.**
6. Termina con la [práctica](PRACTICA.md), luego contrasta tus decisiones con las [soluciones razonadas](SOLUCIONES.md).

### Transferir la idea a otro problema

Encuentra clientes sin teléfono y productos activos cuyo precio sea menor que 90 o mayor que 110.

Explica cómo cambiarían los datos si aparece una fila adicional, una referencia ausente o un empate. Distingue una garantía del esquema de una suposición que solo cumple esta muestra. El objetivo es construir una respuesta justificable, no copiar una consulta sin entender su población.

## Continuar el curso

- **Unidad anterior:** [Unidad 07: SELECT: consultar datos](../unidad07-select/README.md)
- **Volver al índice:** [Todas las unidades](../README.md)
- **Siguiente unidad:** [Unidad 09: ORDER BY, LIMIT y DISTINCT](../unidad09-order-limit/README.md)

