# Unidad 26 — EXPLAIN y planes de ejecución

## Qué aprenderás
Leer un plan básico, distinguir estimaciones de mediciones y utilizar EXPLAIN para comprobar hipótesis.

# 1. SQL describe qué quieres

```sql
SELECT * FROM producto
WHERE nombre='Teclado';
```

PostgreSQL decide cómo obtenerlo.

El plan muestra esa estrategia.

# 2. EXPLAIN

```sql
EXPLAIN
SELECT * FROM producto
WHERE nombre='Teclado';
```

Puede mostrar:

```text
Seq Scan on producto
  Filter: (nombre = 'Teclado')
```

Significa que planea recorrer secuencialmente la tabla.

# 3. Cost

Verás números como:
```text
cost=0.00..18.10
```

Son unidades internas estimadas para comparar alternativas, no milisegundos directos.

# 4. rows

```text
rows=1
```

Es una estimación de cuántas filas producirá ese nodo.

Las estadísticas ayudan al optimizador a estimar.

# 5. EXPLAIN ANALYZE

```sql
EXPLAIN ANALYZE
SELECT ...;
```

Ejecuta realmente la consulta y añade tiempos/filas observadas.

Ahora puedes comparar:
```text
rows estimadas
vs
actual rows
```

# 6. Cuidado

`EXPLAIN ANALYZE UPDATE/DELETE/INSERT` **ejecuta la modificación**.

En una práctica controlada puedes envolver apropiadamente en transacción y revertir cuando sea válido, pero comprende exactamente qué estás ejecutando.

# 7. Scan comunes

## Seq Scan
Recorrido secuencial.

## Index Scan
Usa índice y accede a filas.

## Index Only Scan
En ciertos casos puede resolver usando índice con requisitos adicionales de visibilidad/datos.

No clasifiques uno como “malo” y otro como “bueno” universalmente.

# 8. Joins

Puedes encontrar Nested Loop, Hash Join o Merge Join.

El optimizador elige según tamaños, condiciones, índices y estimaciones.

El objetivo inicial es reconocerlos, no forzar uno.

# 9. Práctica guiada

1. EXPLAIN búsqueda por nombre.
2. Registra plan.
3. Crea índice.
4. Repite.
5. Aumenta datos.
6. Usa ANALYZE de forma segura.
7. Compara estimaciones/reales.

# 10. Diagnóstico de estimaciones

Si estimaba 10 filas y aparecen 100 000, esa diferencia puede conducir a decisiones de plan poco adecuadas.

Pregunta por estadísticas, distribución y predicados antes de “culpar” al índice.

# 11. Errores frecuentes
- Leer cost como milisegundos.
- Ejecutar ANALYZE sobre DELETE sin saberlo.
- Pensar Seq Scan = error.
- Comparar planes con datasets minúsculos.
- Optimizar sin una consulta/problema real.

# 12. Ejercicios
Analiza:
- búsqueda por PK;
- búsqueda por nombre;
- filtro boolean;
- JOIN;
- agregación.

Para cada uno escribe qué esperas antes de ejecutar.

# 13. Reto
Conserva plan antes/después de una mejora y escribe una conclusión basada en evidencia: filas, estrategia y tiempos observados.

# 14. Autoevaluación
1. ¿EXPLAIN ejecuta SELECT?
2. ¿EXPLAIN ANALYZE?
3. ¿cost son ms?
4. ¿Seq Scan siempre es malo?
5. ¿Qué diferencia hay entre rows y actual rows?
6. ¿Por qué importa el tamaño del dataset?

# 15. Checklist
- [ ] Leo plan básico.
- [ ] Distingo estimado/real.
- [ ] Uso ANALYZE conscientemente.
- [ ] No etiqueto scans sin contexto.
- [ ] Optimizo con evidencia.

Has completado el bloque de diseño y funcionamiento. Continúa con administración básica.
