# Unidad 17: Operaciones de conjuntos

[Volver al índice del curso](../README.md) · [Ver el curso en Aprende con Leli](https://lelyliliana.github.io/aprende-con-leli/cursos/bases-datos-sql/)

## Qué aprenderás
Combinar resultados con UNION, UNION ALL, INTERSECT y EXCEPT.

## Cómo usar los ejemplos de esta unidad

Los ejemplos breves ilustran una idea y pueden usar un conjunto reducido de filas o una tabla independiente. Para ejecutarlos juntos sin conflictos, utiliza el laboratorio y la práctica de esta unidad sobre la [tienda de referencia](../docs/CASO_TIENDA.md). Sus scripts declaran la preparación, resultados y rollback. No vuelvas a crear las tablas de tienda ni repitas su carga para seguir un fragmento ilustrativo.

# 1. Dos conjuntos compatibles

Supón:
```text
clientes_actuales
clientes_historicos
```

Ambas consultas producen:
```text
correo
```

Podemos combinarlas.

# 2. UNION

```sql
SELECT correo FROM clientes_actuales
UNION
SELECT correo FROM clientes_historicos;
```

UNION elimina filas duplicadas del resultado combinado.

# 3. UNION ALL

```sql
SELECT correo FROM clientes_actuales
UNION ALL
SELECT correo FROM clientes_historicos;
```

Conserva todas las filas.

Si una persona aparece en ambas fuentes, aparecerá dos veces.

# 4. ¿Cuál elegir?

Pregunta qué representa el resultado.

Si quieres “correos únicos”, UNION puede expresar la intención.

Si quieres conservar cada registro/procedencia, UNION ALL puede ser correcto.

No elijas UNION solo para “quitar duplicados”.

# 5. Compatibilidad

Las consultas deben devolver el mismo número de columnas y tipos compatibles por posición.

Los nombres finales suelen derivarse de la primera consulta.

# 6. INTERSECT

```sql
SELECT correo FROM lista_a
INTERSECT
SELECT correo FROM lista_b;
```

Devuelve filas presentes en ambos resultados.

# 7. EXCEPT

```sql
SELECT correo FROM lista_a
EXCEPT
SELECT correo FROM lista_b;
```

Devuelve filas de A que no están en B.

# 8. Diferencia con JOIN

JOIN combina columnas de filas relacionadas.

Las operaciones de conjuntos combinan/comparan **resultados con estructura compatible**.

```text
JOIN → más columnas
UNION → más filas compatibles
```

Es una simplificación útil, aunque el resultado real depende de cada consulta.

# 9. Práctica guiada

Crea dos consultas literales:

```sql
SELECT 'ana@example.com' AS correo
UNION
SELECT 'ana@example.com';
```

Observa una fila.

Cambia a UNION ALL y observa dos.

# 10. Ejercicios

1. UNION.
2. UNION ALL.
3. INTERSECT.
4. EXCEPT.
5. Históricos+actuales.
6. Conserva columna `fuente` para trazabilidad.

# 11. Reto

Integra dos fuentes de clientes conservando procedencia. Decide si necesitas UNION o UNION ALL y justifica.

# 12. Autoevaluación

1. ¿UNION elimina duplicados?
2. ¿UNION ALL?
3. ¿Qué exige compatibilidad?
4. ¿Qué hace INTERSECT?
5. ¿Qué hace EXCEPT?
6. ¿Diferencia conceptual JOIN/UNION?

# 13. Checklist

- [ ] Uso UNION/ALL.
- [ ] Uso INTERSECT/EXCEPT.
- [ ] Verifico compatibilidad.
- [ ] Elijo según significado del resultado.

Has completado el bloque de consultas. Continúa con diseño y normalización.


---

## Laboratorio completo y lectura del resultado

**Caso:** ¿Qué cambia entre combinar filas y combinar conjuntos sin duplicados?

Los tipos se alinean por posición, no por nombre. INTERSECT/EXCEPT sin ALL eliminan duplicados. Para estas operaciones dos NULL se tratan como no distintos, a diferencia de una comparación NULL=NULL. ORDER BY al final ordena el resultado combinado. Si agregas fuente, dos filas con el mismo correo pero distinta fuente ya no son duplicadas de toda la proyección.

### Paso a paso

1. Comprueba que estás en la base de práctica y que la [tienda](../docs/CASO_TIENDA.md) conserva sus datos iniciales.
2. Abre [LABORATORIO.sql](LABORATORIO.sql). Lee el script antes de enviarlo al servidor.
3. Predice el resultado de cada sentencia. Anota qué representa una fila y qué operaciones pueden cambiar datos.
4. Desde la raíz, ejecuta:

```text
psql -X -h localhost -U estudiante -d curso_sql -v ON_ERROR_STOP=1 -f unidad17-conjuntos/LABORATORIO.sql
```

La contraseña se solicita en la terminal; no la escribas en el repositorio.

5. Compara con la referencia: **UNION: 1,2,3. UNION ALL: 1,1,2,2,3. INTERSECT: 2. EXCEPT: 1.**
6. Termina con la [práctica](PRACTICA.md), luego contrasta tus decisiones con las [soluciones razonadas](SOLUCIONES.md).

### Transferir la idea a otro problema

Combina dos fuentes con el mismo correo conservando la procedencia. Explica por qué UNION no eliminaría esas dos filas si fuente es distinta.

Explica cómo cambiarían los datos si aparece una fila adicional, una referencia ausente o un empate. Distingue una garantía del esquema de una suposición que solo cumple esta muestra. El objetivo es construir una respuesta justificable, no copiar una consulta sin entender su población.

## Continuar el curso

- **Unidad anterior:** [Unidad 16: CTE: nombrar etapas de una consulta](../unidad16-cte/README.md)
- **Volver al índice:** [Todas las unidades](../README.md)
- **Siguiente unidad:** [Unidad 18: Diagrama entidad-relación](../unidad18-der/README.md)

