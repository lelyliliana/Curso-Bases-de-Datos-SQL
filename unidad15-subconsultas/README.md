# Unidad 15: Subconsultas y EXISTS

[Volver al índice del curso](../README.md) · [Ver el curso en Aprende con Leli](https://lelyliliana.github.io/aprende-con-leli/cursos/bases-datos-sql/)

## Qué aprenderás
Usar una consulta dentro de otra y elegir entre valor escalar, IN y EXISTS según la pregunta.

## Cómo usar los ejemplos de esta unidad

Los ejemplos breves ilustran una idea y pueden usar un conjunto reducido de filas o una tabla independiente. Para ejecutarlos juntos sin conflictos, utiliza el laboratorio y la práctica de esta unidad sobre la [tienda de referencia](../docs/CASO_TIENDA.md). Sus scripts declaran la preparación, resultados y rollback. No vuelvas a crear las tablas de tienda ni repitas su carga para seguir un fragmento ilustrativo.

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


---

## Laboratorio completo y lectura del resultado

**Caso:** ¿Cómo consultar existencia sin multiplicar clientes por sus pedidos?

EXISTS evalúa presencia de alguna fila y conserva una por cliente. No presupongas que ejecuta físicamente la subconsulta una vez por cada fila: el optimizador puede transformarla. Una subconsulta escalar vacía produce NULL; con más de una fila falla. Una FK NOT NULL en pedido.cliente_id evita NULL allí, pero otras fuentes sí pueden tenerlo.

### Paso a paso

1. Comprueba que estás en la base de práctica y que la [tienda](../docs/CASO_TIENDA.md) conserva sus datos iniciales.
2. Abre [LABORATORIO.sql](LABORATORIO.sql). Lee el script antes de enviarlo al servidor.
3. Predice el resultado de cada sentencia. Anota qué representa una fila y qué operaciones pueden cambiar datos.
4. Desde la raíz, ejecuta:

```text
psql -X -h localhost -U estudiante -d curso_sql -v ON_ERROR_STOP=1 -f unidad15-subconsultas/LABORATORIO.sql
```

La contraseña se solicita en la terminal; no la escribas en el repositorio.

5. Compara con la referencia: **Con pedidos: 1,2,4; sin pedidos: Sara (3). NOT IN produce NULL. Por encima de promedio 86: 2,3,4.**
6. Termina con la [práctica](PRACTICA.md), luego contrasta tus decisiones con las [soluciones razonadas](SOLUCIONES.md).

### Transferir la idea a otro problema

Busca clientes que compraron Libros en pedidos PAGADO con EXISTS. No cuentes un pedido creado como venta.

Explica cómo cambiarían los datos si aparece una fila adicional, una referencia ausente o un empate. Distingue una garantía del esquema de una suposición que solo cumple esta muestra. El objetivo es construir una respuesta justificable, no copiar una consulta sin entender su población.

## Continuar el curso

- **Unidad anterior:** [Unidad 14: JOIN: combinar tablas](../unidad14-joins/README.md)
- **Volver al índice:** [Todas las unidades](../README.md)
- **Siguiente unidad:** [Unidad 16: CTE: nombrar etapas de una consulta](../unidad16-cte/README.md)

---

### ¿Necesitas apoyo con este tema?

Si te bloqueaste con la práctica, necesitas revisar tu entorno o adaptar lo aprendido a tu proyecto, podemos trabajarlo en una sesión personalizada.

[**Solicitar asesoría para este tema por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20Unidad%2015%20%E2%80%94%20Subconsultas%20del%20curso%20Bases%20de%20Datos%20y%20SQL%20desde%20cero%20%28https%3A%2F%2Fgithub.com%2Flelyliliana%2FCurso-Bases-de-Datos-SQL%2Ftree%2Fmain%2Funidad15-subconsultas%29%20y%20necesito%20una%20asesor%C3%ADa%20personalizada.%20Mi%20duda%20es%E2%80%A6)
