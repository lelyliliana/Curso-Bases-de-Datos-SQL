# Unidad 20 — Normalización: 1FN, 2FN y 3FN

## Qué aprenderás
Normalizar un modelo paso a paso y, sobre todo, justificar cada separación.

# 1. Punto de partida

```text
pedido_id | fecha | cliente_id | cliente_nombre | correo |
producto_id | producto_nombre | categoria_id | categoria_nombre |
cantidad | precio_unitario
```

Clave candidata de una línea:
```text
(pedido_id, producto_id)
```
para este ejemplo simplificado.

# 2. Primera Forma Normal — 1FN

Una relación debe manejar valores atómicos respecto del modelo, sin grupos repetidos del tipo:

```text
productos = "A,B,C"
```

No significa que “una coma esté prohibida”; significa que si esos valores representan hechos independientes que necesitas consultar/relacionar, no deberían esconderse como lista improvisada.

# 3. Segunda Forma Normal — 2FN

Con clave compuesta `(pedido_id, producto_id)`:

```text
pedido_id → fecha, cliente_id
producto_id → producto_nombre, categoria_id
```

Esos atributos dependen solo de una parte de la clave compuesta.

Separamos:

```text
PEDIDO(pedido_id, fecha, cliente_id)
PRODUCTO(producto_id, producto_nombre, categoria_id)
DETALLE(pedido_id, producto_id, cantidad, precio_unitario)
```

# 4. Tercera Forma Normal — 3FN

En PRODUCTO:

```text
producto_id → categoria_id
categoria_id → categoria_nombre
```

categoria_nombre depende transitivamente de producto_id mediante categoria_id.

Separamos:

```text
CATEGORIA(categoria_id,categoria_nombre)
PRODUCTO(producto_id,producto_nombre,categoria_id)
```

CLIENTE también separa sus datos del pedido.

# 5. Resultado

```text
CLIENTE
CATEGORIA
PRODUCTO
PEDIDO
DETALLE_PEDIDO
```

Observa que coincide con el esquema de tienda del curso.

# 6. ¿Normalizar siempre al máximo?

La normalización es una herramienta de diseño. Sistemas analíticos, rendimiento u otros requisitos pueden justificar estructuras distintas o desnormalización deliberada.

Pero primero debes entender qué redundancia introduces y por qué.

# 7. Práctica guiada

Toma:

```text
matricula(estudiante_id, estudiante_nombre, programa_id, programa_nombre,
curso_id, curso_nombre, docente_id, docente_nombre, nota)
```

Identifica:
- clave;
- dependencias;
- separaciones hacia 2FN/3FN.

# 8. Errores frecuentes
- Memorizar “1FN=no comas” sin entender hechos.
- Aplicar 2FN sin clave compuesta.
- Dividir cada atributo en tabla.
- Desnormalizar antes de medir una necesidad.

# 9. Ejercicios
Normaliza:
1. factura plana;
2. matrículas;
3. préstamos;
4. reservas.

# 10. Reto
Documenta una normalización completa mostrando antes, dependencias, después y anomalías eliminadas.

# 11. Autoevaluación
1. ¿Qué problema aborda 1FN?
2. ¿Qué es dependencia parcial?
3. ¿Qué es dependencia transitiva?
4. ¿Por qué importa conocer la clave?
5. ¿Desnormalizar siempre está mal?

# 12. Checklist
- [ ] Comprendo 1FN.
- [ ] Identifico dependencias parciales.
- [ ] Identifico transitivas.
- [ ] Justifico separaciones.
- [ ] Relaciono normalización con anomalías.

Continúa con integridad referencial.
