# Unidad 18 — Diagrama entidad-relación

## Qué aprenderás
Pasar de un problema real a un modelo conceptual con entidades, relaciones, cardinalidad y opcionalidad.

# 1. Antes de las tablas

Enunciado:
> Una tienda vende productos a clientes mediante pedidos.

No empieces con CREATE TABLE. Primero pregunta qué hechos existen.

```text
CLIENTE
PRODUCTO
PEDIDO
```

Pero un pedido contiene varios productos y un producto puede aparecer en muchos pedidos.

Necesitamos representar esa relación.

# 2. Modelo conceptual

```text
CLIENTE 1 ───── N PEDIDO
PEDIDO  1 ───── N DETALLE_PEDIDO N ───── 1 PRODUCTO
```

DETALLE_PEDIDO puede contener cantidad y precio_unitario.

# 3. Cardinalidad

`1:N` significa que una instancia de un lado puede relacionarse con muchas del otro.

Pregunta siempre ambas direcciones:
- ¿cuántos pedidos puede tener un cliente?
- ¿a cuántos clientes pertenece un pedido?

# 4. Opcionalidad

¿Un cliente puede existir sin pedidos? Probablemente sí.

¿Un pedido puede existir sin cliente? Depende de las reglas.

No inventes opcionalidad por comodidad técnica.

# 5. Entidad asociativa

Una relación N:M suele transformarse en una entidad/relación intermedia.

```text
PEDIDO N ── M PRODUCTO
```

se materializa conceptualmente:

```text
PEDIDO 1 ─ N DETALLE_PEDIDO N ─ 1 PRODUCTO
```

Además DETALLE tiene atributos propios.

# 6. Ejemplo resuelto — biblioteca

```text
AUTOR N ─ M LIBRO
LIBRO 1 ─ N EJEMPLAR
USUARIO 1 ─ N PRESTAMO N ─ 1 EJEMPLAR
```

¿Por qué EJEMPLAR?
Porque prestamos una copia física, no el concepto abstracto de libro.

# 7. Práctica guiada

Sistema de hotel:
- huésped;
- habitación;
- reserva.

Preguntas:
1. ¿una reserva puede incluir varias habitaciones?
2. ¿una habitación puede aparecer en muchas reservas a lo largo del tiempo?
3. ¿qué ocurre con fechas?

La respuesta puede requerir una entidad RESERVA_HABITACION.

# 8. Errores frecuentes
- Empezar por tablas.
- Crear entidad por cada sustantivo.
- No preguntar cardinalidad en ambas direcciones.
- Confundir atributo con entidad.
- Omitir reglas pendientes.

# 9. Ejercicios
Modela:
1. colegio;
2. clínica;
3. biblioteca;
4. eventos;
5. comercio electrónico.

# 10. Reto
Construye DER conceptual de un sistema de reservas y escribe diez reglas/supuestos.

# 11. Autoevaluación
1. ¿Qué representa una entidad?
2. ¿Qué es cardinalidad?
3. ¿Qué es opcionalidad?
4. ¿Cómo se resuelve conceptualmente N:M?
5. ¿Por qué modelar antes de SQL?

# 12. Checklist
- [ ] Identifico entidades.
- [ ] Expreso relaciones.
- [ ] Defino cardinalidad/opcionalidad.
- [ ] Registro supuestos.
- [ ] Puedo justificar una entidad asociativa.

Continúa con anomalías y dependencias.
