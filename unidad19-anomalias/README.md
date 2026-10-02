# Unidad 19 — Dependencias y anomalías

## Qué aprenderás
Detectar cuándo una tabla mezcla hechos distintos y comprender dependencias funcionales como base para normalizar.

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
