# Unidad 15 — Subconsultas y EXISTS

## Qué aprenderás
Usar una consulta dentro de otra y elegir entre valor escalar, IN y EXISTS según la pregunta.

# 1. Subconsulta escalar

Queremos productos por encima del promedio:

```sql
SELECT nombre,precio
FROM producto
WHERE precio > (
  SELECT AVG(precio) FROM producto
);
```

La consulta interna devuelve un valor; la externa lo utiliza.

# 2. Comprender por etapas

Primero ejecuta:
```sql
SELECT AVG(precio) FROM producto;
```

Supón 96.67.

Después imagina:
```sql
WHERE precio > 96.67
```

Cuando una consulta te confunda, ejecuta sus partes.

# 3. IN

```sql
SELECT *
FROM producto
WHERE categoria_id IN (
  SELECT id FROM categoria WHERE nombre IN ('Libros','Tecnología')
);
```

La subconsulta produce un conjunto de valores.

# 4. EXISTS

Pregunta:
> ¿qué clientes tienen al menos un pedido?

```sql
SELECT c.id,c.nombre
FROM cliente c
WHERE EXISTS (
  SELECT 1
  FROM pedido p
  WHERE p.cliente_id=c.id
);
```

Para cada cliente preguntamos si existe al menos una fila relacionada.

# 5. Correlación

La subconsulta anterior usa `c.id` de la consulta externa. Por eso está correlacionada.

# 6. NOT EXISTS

Clientes sin pedidos:

```sql
SELECT c.id,c.nombre
FROM cliente c
WHERE NOT EXISTS (
  SELECT 1 FROM pedido p
  WHERE p.cliente_id=c.id
);
```

Expresa directamente “no existe relación”.

# 7. NOT IN y NULL

Si el conjunto de NOT IN contiene NULL, la lógica de tres valores puede producir resultados sorprendentes. No memorices una “receta”; comprende si NULL puede aparecer y considera NOT EXISTS cuando expresa mejor la intención.

# 8. Subconsulta vs JOIN

Muchas preguntas pueden escribirse de varias formas.

“Clientes con pedidos” puede resolverse con EXISTS o JOIN. Evalúa:
- qué pregunta expresas;
- duplicación;
- legibilidad;
- plan de ejecución.

# 9. Práctica guiada

Resuelve por etapas:
1. promedio de precios;
2. productos superiores;
3. clientes con pedidos;
4. clientes sin pedidos.

Ejecuta primero cada subconsulta aislada cuando sea posible.

# 10. Ejercicios

- producto más caro mediante subconsulta;
- categorías con productos;
- clientes sin pedidos;
- pedidos con total superior a promedio;
- EXISTS vs JOIN.

# 11. Reto

Resuelve “clientes que compraron al menos un producto de categoría Libros” con EXISTS y con JOIN. Compara resultados y legibilidad.

# 12. Autoevaluación

1. ¿Qué es subconsulta escalar?
2. ¿Qué pregunta expresa EXISTS?
3. ¿Qué significa correlacionada?
4. ¿Por qué NOT IN merece cuidado con NULL?
5. ¿Subconsulta siempre es mejor/peor que JOIN?

# 13. Checklist

- [ ] Uso subconsulta escalar.
- [ ] Uso IN.
- [ ] Uso EXISTS/NOT EXISTS.
- [ ] Ejecuto partes para diagnosticar.
- [ ] Comparo alternativas.

Continúa con CTE.
