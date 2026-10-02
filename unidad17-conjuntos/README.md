# Unidad 17 — Operaciones de conjuntos

## Qué aprenderás
Combinar resultados con UNION, UNION ALL, INTERSECT y EXCEPT.

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
