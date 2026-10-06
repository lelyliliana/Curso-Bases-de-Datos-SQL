# Unidad 13: GROUP BY y HAVING

[Volver al índice del curso](../README.md) · [Ver el curso en Aprende con Leli](https://lelyliliana.github.io/aprende-con-leli/cursos/bases-datos-sql/)

## Qué aprenderás
Crear grupos, calcular métricas por grupo y distinguir WHERE de HAVING.

## Cómo usar los ejemplos de esta unidad

Los ejemplos breves ilustran una idea y pueden usar un conjunto reducido de filas o una tabla independiente. Para ejecutarlos juntos sin conflictos, utiliza el laboratorio y la práctica de esta unidad sobre la [tienda de referencia](../docs/CASO_TIENDA.md). Sus scripts declaran la preparación, resultados y rollback. No vuelvas a crear las tablas de tienda ni repitas su carga para seguir un fragmento ilustrativo.

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


---

## Laboratorio completo y lectura del resultado

**Caso:** ¿Qué elimina WHERE y qué elimina HAVING en un reporte por categoría?

WHERE elimina la Lámpara antes del grupo; HAVING elimina grupos pequeños. Sara no aparece en el segundo reporte porque la población es pedido. GROUP BY no genera categorías o clientes ausentes; la unidad siguiente incorpora LEFT JOIN. PostgreSQL puede reconocer dependencias de la PK, pero agrupar explícitamente los atributos del reporte facilita leerlo.

### Paso a paso

1. Comprueba que estás en la base de práctica y que la [tienda](../docs/CASO_TIENDA.md) conserva sus datos iniciales.
2. Abre [LABORATORIO.sql](LABORATORIO.sql). Lee el script antes de enviarlo al servidor.
3. Predice el resultado de cada sentencia. Anota qué representa una fila y qué operaciones pueden cambiar datos.
4. Desde la raíz, ejecuta:

```text
psql -X -h localhost -U estudiante -d curso_sql -v ON_ERROR_STOP=1 -f unidad13-group-having/LABORATORIO.sql
```

La contraseña se solicita en la terminal; no la escribas en el repositorio.

5. Compara con la referencia: **Categorías 1 y 2: dos activos cada una, promedios 85 y 105. Pedidos por cliente: 1→2, 2→2, 4→1.**
6. Termina con la [práctica](PRACTICA.md), luego contrasta tus decisiones con las [soluciones razonadas](SOLUCIONES.md).

### Transferir la idea a otro problema

Encuentra clientes con más de un pedido PAGADO. Define qué representa cada fila.

Explica cómo cambiarían los datos si aparece una fila adicional, una referencia ausente o un empate. Distingue una garantía del esquema de una suposición que solo cumple esta muestra. El objetivo es construir una respuesta justificable, no copiar una consulta sin entender su población.

## Continuar el curso

- **Unidad anterior:** [Unidad 12: Agregaciones](../unidad12-agregaciones/README.md)
- **Volver al índice:** [Todas las unidades](../README.md)
- **Siguiente unidad:** [Unidad 14: JOIN: combinar tablas](../unidad14-joins/README.md)

