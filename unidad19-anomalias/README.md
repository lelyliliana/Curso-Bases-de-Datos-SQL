# Unidad 19: Dependencias y anomalías

[Volver al índice del curso](../README.md) · [Ver el curso en Aprende con Leli](https://lelyliliana.github.io/aprende-con-leli/cursos/bases-datos-sql/)

## Qué aprenderás
Detectar cuándo una tabla mezcla hechos distintos y comprender dependencias funcionales como base para normalizar.

## Cómo usar los ejemplos de esta unidad

Los ejemplos breves ilustran una idea y pueden usar un conjunto reducido de filas o una tabla independiente. Para ejecutarlos juntos sin conflictos, utiliza el laboratorio y la práctica de esta unidad sobre la [tienda de referencia](../docs/CASO_TIENDA.md). Sus scripts declaran la preparación, resultados y rollback. No vuelvas a crear las tablas de tienda ni repitas su carga para seguir un fragmento ilustrativo.

# 1. Tabla plana

| pedido | fecha | cliente_id | cliente_nombre | correo | producto_id | producto | categoria | cantidad |
|---|---|---:|---|---|---:|---|---|---:|
| 1 | 01/10 | 10 | Ana | ana@x.com | 100 | Libro A | Libros | 1 |
| 1 | 01/10 | 10 | Ana | ana@x.com | 200 | Teclado | Tecnología | 2 |

Parece cómoda porque “todo está junto”.

Pero repite hechos.

# 2. Anomalía de actualización

Ana cambia correo.

Si aparece en 50 pedidos, debemos cambiar 50 filas.

Si olvidamos una:

```text
ana@nueva.com
ana@vieja.com
```

¿cuál es correcto?

# 3. Anomalía de inserción

Queremos registrar una nueva categoría antes de tener productos.

¿Podemos hacerlo en la tabla plana sin inventar pedido/producto?

# 4. Anomalía de eliminación

Si eliminamos la última fila donde aparece una categoría, podríamos perder también el único registro de que la categoría existe.

# 5. Dependencia funcional

Escribimos:

```text
cliente_id → cliente_nombre, correo
producto_id → producto, categoria
pedido → fecha, cliente_id
(pedido, producto_id) → cantidad
```

Lee:
> dado cliente_id, queda determinado su correo según este modelo.

No significa causalidad. Expresa una regla de determinación dentro del esquema.

# 6. ¿Por qué importa?

La tabla mezcla:
- hechos del cliente;
- hechos del producto;
- hechos del pedido;
- hechos de la línea de pedido.

Las anomalías son síntomas de esa mezcla.

# 7. Práctica guiada

Marca cada columna de la tabla plana con el “hecho” al que pertenece.

Después agrupa:
```text
CLIENTE
PRODUCTO
PEDIDO
DETALLE
CATEGORIA
```

Todavía no normalices mecánicamente: explica qué dependencia te lleva a cada separación.

# 8. Errores frecuentes
- Pensar que duplicación visual siempre es mala.
- Dividir tablas sin identificar dependencias.
- Confundir dependencia funcional con FK.
- Normalizar sin comprender la clave.

# 9. Ejercicios
Detecta anomalías en:
- matrícula;
- factura;
- préstamo de biblioteca;
- citas médicas.

# 10. Reto
Toma una hoja plana real o ficticia y escribe dependencias funcionales candidatas. Señala qué reglas necesitas confirmar con el dueño del proceso.

# 11. Autoevaluación
1. ¿Qué es anomalía de actualización?
2. ¿Inserción?
3. ¿Eliminación?
4. ¿Qué expresa X→Y?
5. ¿Por qué una dependencia no es una FK?

# 12. Checklist
- [ ] Detecto anomalías.
- [ ] Identifico hechos mezclados.
- [ ] Escribo dependencias funcionales.
- [ ] No separo tablas arbitrariamente.

Continúa con normalización.


---

## Laboratorio completo y lectura del resultado

**Caso:** ¿Cómo detectar una contradicción en una hoja que repite los datos de cliente?

La dependencia cliente→correo proviene del dominio. Los datos pueden refutarla, pero una muestra sin contradicciones no la demuestra. Un correo histórico por venta sería otro atributo y otra regla; no normalices hasta distinguirlo. Las anomalías de actualización, inserción y borrado nacen de mezclar hechos con dependencias diferentes.

### Paso a paso

1. Comprueba que estás en la base de práctica y que la [tienda](../docs/CASO_TIENDA.md) conserva sus datos iniciales.
2. Abre [LABORATORIO.sql](LABORATORIO.sql). Lee el script antes de enviarlo al servidor.
3. Predice el resultado de cada sentencia. Anota qué representa una fila y qué operaciones pueden cambiar datos.
4. Desde la raíz, ejecuta:

```text
psql -X -h localhost -U estudiante -d curso_sql -v ON_ERROR_STOP=1 -f unidad19-anomalias/LABORATORIO.sql
```

La contraseña se solicita en la terminal; no la escribas en el repositorio.

5. Compara con la referencia: **Cliente 7 tiene dos correos distintos para una regla de correo actual único por cliente.**
6. Termina con la [práctica](PRACTICA.md), luego contrasta tus decisiones con las [soluciones razonadas](SOLUCIONES.md).

### Transferir la idea a otro problema

Escribe las dependencias de pedido, producto y detalle. Decide dónde guardar precio vendido y precio actual.

Explica cómo cambiarían los datos si aparece una fila adicional, una referencia ausente o un empate. Distingue una garantía del esquema de una suposición que solo cumple esta muestra. El objetivo es construir una respuesta justificable, no copiar una consulta sin entender su población.

## Continuar el curso

- **Unidad anterior:** [Unidad 18: Diagrama entidad-relación](../unidad18-der/README.md)
- **Volver al índice:** [Todas las unidades](../README.md)
- **Siguiente unidad:** [Unidad 20: Normalización: 1FN, 2FN y 3FN](../unidad20-normalizacion/README.md)

