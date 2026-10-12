# Unidad 26: EXPLAIN y planes de ejecución

[Volver al índice del curso](../README.md) · [Ver el curso en Aprende con Leli](https://lelyliliana.github.io/aprende-con-leli/cursos/bases-datos-sql/)

## Qué aprenderás
Leer un plan básico, distinguir estimaciones de mediciones y utilizar EXPLAIN para comprobar hipótesis.

## Cómo usar los ejemplos de esta unidad

Los ejemplos breves ilustran una idea y pueden usar un conjunto reducido de filas o una tabla independiente. Para ejecutarlos juntos sin conflictos, utiliza el laboratorio y la práctica de esta unidad sobre la [tienda de referencia](../docs/CASO_TIENDA.md). Sus scripts declaran la preparación, resultados y rollback. No vuelvas a crear las tablas de tienda ni repitas su carga para seguir un fragmento ilustrativo.

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


---

## Laboratorio completo y lectura del resultado

**Caso:** ¿Cómo distinguir estimación, ejecución real y costo sin inventar conclusiones?

cost son unidades del optimizador, no milisegundos. Actual Rows y tiempos se muestran por ejecución del nodo; observa loops antes de interpretar trabajo total. BUFFERS distingue bloques encontrados en caché y leídos, no mide únicamente disco físico. Ejecutar dos veces favorece caché; repite y registra condiciones antes de atribuir toda la diferencia al índice.

### Paso a paso

1. Comprueba que estás en la base de práctica y que la [tienda](../docs/CASO_TIENDA.md) conserva sus datos iniciales.
2. Abre [LABORATORIO.sql](LABORATORIO.sql). Lee el script antes de enviarlo al servidor.
3. Predice el resultado de cada sentencia. Anota qué representa una fila y qué operaciones pueden cambiar datos.
4. Desde la raíz, ejecuta:

```text
psql -X -h localhost -U estudiante -d curso_sql -v ON_ERROR_STOP=1 -f unidad26-explain/LABORATORIO.sql
```

La contraseña se solicita en la terminal; no la escribas en el repositorio.

5. Compara con la referencia: **100 filas reales. Registra Node Type, Plan Rows, Actual Rows, Actual Loops, buffers y tiempo de ejecución en ambos planes.**
6. Termina con la [práctica](PRACTICA.md), luego contrasta tus decisiones con las [soluciones razonadas](SOLUCIONES.md).

### Transferir la idea a otro problema

Obtén un plan de agregación por estado en la tienda. Explica por qué cinco filas no permiten demostrar una mejora de rendimiento.

Explica cómo cambiarían los datos si aparece una fila adicional, una referencia ausente o un empate. Distingue una garantía del esquema de una suposición que solo cumple esta muestra. El objetivo es construir una respuesta justificable, no copiar una consulta sin entender su población.

## Continuar el curso

- **Unidad anterior:** [Unidad 25: Índices](../unidad25-indices/README.md)
- **Volver al índice:** [Todas las unidades](../README.md)
- **Siguiente unidad:** [Unidad 27: Usuarios, roles y privilegios](../unidad27-seguridad/README.md)

---

### ¿Necesitas apoyo con este tema?

Si te bloqueaste con la práctica, necesitas revisar tu entorno o adaptar lo aprendido a tu proyecto, podemos trabajarlo en una sesión personalizada.

[**Solicitar asesoría para este tema por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20Unidad%2026%20%E2%80%94%20EXPLAIN%20y%20planes%20de%20ejecuci%C3%B3n%20del%20curso%20Bases%20de%20Datos%20y%20SQL%20desde%20cero%20%28https%3A%2F%2Fgithub.com%2Flelyliliana%2FCurso-Bases-de-Datos-SQL%2Ftree%2Fmain%2Funidad26-explain%29%20y%20necesito%20una%20asesor%C3%ADa%20personalizada.%20Mi%20duda%20es%E2%80%A6)
