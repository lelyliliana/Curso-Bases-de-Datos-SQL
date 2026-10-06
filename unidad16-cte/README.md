# Unidad 16: CTE: nombrar etapas de una consulta

[Volver al índice del curso](../README.md) · [Ver el curso en Aprende con Leli](https://lelyliliana.github.io/aprende-con-leli/cursos/bases-datos-sql/)

## Qué aprenderás
Usar WITH para dividir consultas complejas en pasos legibles y comprender que una CTE no implica automáticamente mejor rendimiento.

## Cómo usar los ejemplos de esta unidad

Los ejemplos breves ilustran una idea y pueden usar un conjunto reducido de filas o una tabla independiente. Para ejecutarlos juntos sin conflictos, utiliza el laboratorio y la práctica de esta unidad sobre la [tienda de referencia](../docs/CASO_TIENDA.md). Sus scripts declaran la preparación, resultados y rollback. No vuelvas a crear las tablas de tienda ni repitas su carga para seguir un fragmento ilustrativo.

# 1. Problema

Queremos calcular total de cada pedido y después mostrar solo los mayores a 100.

Podríamos anidar consultas, pero podemos nombrar el paso.

# 2. CTE

```sql
WITH total_pedido AS (
  SELECT pedido_id,
         SUM(cantidad*precio_unitario) AS total
  FROM detalle_pedido
  GROUP BY pedido_id
)
SELECT pedido_id,total
FROM total_pedido
WHERE total > 100;
```

# 3. Léelo como una historia

```text
Paso 1: total_pedido
        ↓
Paso 2: filtrar total > 100
```

La CTE crea un nombre para un resultado intermedio dentro de la sentencia.

# 4. Varias CTE

```sql
WITH
total_pedido AS (...),
pedidos_altos AS (
  SELECT * FROM total_pedido WHERE total > 100
)
SELECT * FROM pedidos_altos;
```

Úsalo cuando cada etapa tenga significado. No fragmentes una consulta sencilla solo por usar WITH.

# 5. CTE vs vista

Una CTE vive dentro de una sentencia. Una vista es un objeto persistente del esquema que estudiaremos después.

# 6. Rendimiento

No afirmes “CTE es más rápida”. El optimizador de PostgreSQL puede tratar CTE de distintas formas según versión, consulta y opciones. Usa EXPLAIN cuando rendimiento importe.

# 7. CTE recursiva

PostgreSQL soporta `WITH RECURSIVE` para problemas jerárquicos/grafos. Aquí solo reconocemos el concepto; requiere un caso donde la recursión tenga sentido.

# 8. Práctica guiada

Crea:
1. CTE con total por pedido.
2. Únela a PEDIDO.
3. Añade CLIENTE.
4. Filtra totales.

En cada etapa ejecuta y observa columnas.

# 9. Errores frecuentes

- Usar CTE como almacenamiento permanente.
- Suponer mejora de rendimiento.
- Crear nombres sin significado.
- Construir demasiadas etapas para una consulta trivial.

# 10. Ejercicios

- total por pedido;
- ventas por cliente;
- categorías con métricas;
- dos etapas de filtrado;
- reescribe una subconsulta como CTE.

# 11. Reto

Construye un reporte de clientes con total pagado usando al menos dos etapas claramente justificadas.

# 12. Autoevaluación

1. ¿Qué hace WITH?
2. ¿Cuánto vive una CTE?
3. ¿CTE y vista son iguales?
4. ¿CTE garantiza mejor rendimiento?
5. ¿Qué ventaja pedagógica/estructural ofrece?

# 13. Checklist

- [ ] Creo CTE.
- [ ] Nombro etapas con sentido.
- [ ] Distingo CTE/vista.
- [ ] No hago afirmaciones de rendimiento sin medir.

Continúa con operaciones de conjuntos.


---

## Laboratorio completo y lectura del resultado

**Caso:** ¿Cómo separar población, cálculo y presentación en un reporte de ventas?

La primera CTE fija una fila por pedido; la segunda suma solo pagados por cliente y la consulta exterior conserva todos los clientes. Una CTE no persiste después de la sentencia. PostgreSQL puede integrarla al plan o materializarla según sus características: legibilidad y rendimiento se evalúan por separado.

### Paso a paso

1. Comprueba que estás en la base de práctica y que la [tienda](../docs/CASO_TIENDA.md) conserva sus datos iniciales.
2. Abre [LABORATORIO.sql](LABORATORIO.sql). Lee el script antes de enviarlo al servidor.
3. Predice el resultado de cada sentencia. Anota qué representa una fila y qué operaciones pueden cambiar datos.
4. Desde la raíz, ejecuta:

```text
psql -X -h localhost -U estudiante -d curso_sql -v ON_ERROR_STOP=1 -f unidad16-cte/LABORATORIO.sql
```

La contraseña se solicita en la terminal; no la escribas en el repositorio.

5. Compara con la referencia: **Ana 470.00; Luis, Sara y Tomás 0. Las cuatro personas aparecen.**
6. Termina con la [práctica](PRACTICA.md), luego contrasta tus decisiones con las [soluciones razonadas](SOLUCIONES.md).

### Transferir la idea a otro problema

Calcula total por pedido, conserva todos, y filtra los que superan 100 mediante una CTE.

Explica cómo cambiarían los datos si aparece una fila adicional, una referencia ausente o un empate. Distingue una garantía del esquema de una suposición que solo cumple esta muestra. El objetivo es construir una respuesta justificable, no copiar una consulta sin entender su población.

### Ampliación y experimentos

[Recursión y funciones de ventana](AMPLIACION.md), con [SQL ejecutable](AMPLIACION.sql).

## Continuar el curso

- **Unidad anterior:** [Unidad 15: Subconsultas y EXISTS](../unidad15-subconsultas/README.md)
- **Volver al índice:** [Todas las unidades](../README.md)
- **Siguiente unidad:** [Unidad 17: Operaciones de conjuntos](../unidad17-conjuntos/README.md)

