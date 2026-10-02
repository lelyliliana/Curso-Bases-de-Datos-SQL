# Unidad 13 — GROUP BY y HAVING

## Qué aprenderás
Crear grupos, calcular métricas por grupo y distinguir WHERE de HAVING.

# 1. El salto conceptual

```sql
SELECT COUNT(*) FROM producto;
```

produce una medida global.

Ahora queremos: ¿cuántos productos hay **por categoría**?

# 2. GROUP BY

Datos:

| categoria_id | producto |
|---:|---|
| 1 | Algoritmos |
| 1 | Bases de Datos |
| 2 | Teclado |

```sql
SELECT categoria_id, COUNT(*) AS productos
FROM producto
GROUP BY categoria_id;
```

Resultado:

| categoria_id | productos |
|---:|---:|
| 1 | 2 |
| 2 | 1 |

# 3. Columnas seleccionadas

En una consulta agrupada, una columna seleccionada normalmente debe estar en GROUP BY o dentro de una agregación, salvo dependencias funcionales que el motor pueda reconocer.

Pregunta: si el grupo contiene dos productos, ¿qué único `nombre` de producto representaría al grupo? Esa pregunta ayuda a detectar errores.

# 4. WHERE antes de agrupar

```sql
SELECT categoria_id,COUNT(*)
FROM producto
WHERE activo
GROUP BY categoria_id;
```

Primero excluimos filas inactivas; después agrupamos.

# 5. HAVING filtra grupos

```sql
SELECT categoria_id,COUNT(*) cantidad
FROM producto
WHERE activo
GROUP BY categoria_id
HAVING COUNT(*) >= 2;
```

# 6. Orden lógico conceptual

```text
FROM → WHERE → GROUP BY → HAVING → SELECT → ORDER BY
```

Es un modelo mental para comprender la consulta, no necesariamente el algoritmo físico de ejecución.

# 7. Práctica guiada

Construye:
- productos por categoría;
- solo productos activos;
- muestra únicamente categorías con al menos dos.

Explica qué elimina WHERE y qué elimina HAVING.

# 8. Errores frecuentes

- Usar HAVING para filtros simples de filas.
- Seleccionar columnas que no representan al grupo.
- Agrupar por demasiadas columnas.
- No saber qué representa una fila del resultado.

# 9. Ejercicios

Productos por categoría, pedidos por cliente, total por pedido, categorías con umbral y meses con más de N pedidos.

# 10. Reto

Escribe una consulta donde WHERE y HAVING sean ambos necesarios y explica cada etapa.

# 11. Autoevaluación

1. ¿Qué hace GROUP BY?
2. ¿WHERE actúa conceptualmente antes del grupo?
3. ¿Qué filtra HAVING?
4. ¿Por qué no puedes seleccionar cualquier columna?
5. ¿Qué representa cada fila agrupada?

# 12. Checklist

- [ ] Agrupo conscientemente.
- [ ] Agrego por grupo.
- [ ] Distingo WHERE/HAVING.
- [ ] Explico cada fila resultante.

Continúa con JOIN.
