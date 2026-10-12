# Unidad 18: Diagrama entidad-relación

[Volver al índice del curso](../README.md) · [Ver el curso en Aprende con Leli](https://lelyliliana.github.io/aprende-con-leli/cursos/bases-datos-sql/)

## Qué aprenderás
Pasar de un problema real a un modelo conceptual con entidades, relaciones, cardinalidad y opcionalidad.

## Cómo usar los ejemplos de esta unidad

Los ejemplos breves ilustran una idea y pueden usar un conjunto reducido de filas o una tabla independiente. Para ejecutarlos juntos sin conflictos, utiliza el laboratorio y la práctica de esta unidad sobre la [tienda de referencia](../docs/CASO_TIENDA.md). Sus scripts declaran la preparación, resultados y rollback. No vuelvas a crear las tablas de tienda ni repitas su carga para seguir un fragmento ilustrativo.

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

# 6. Ejemplo resuelto: biblioteca

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


---

## Laboratorio completo y lectura del resultado

**Caso:** ¿Cómo verificar que el diagrama corresponde a las FK reales?

Un diagrama necesita mínimos y máximos. NOT NULL más FK exige un padre para cada hijo; no exige hijos para cada padre. Detalle representa la asociación N:M entre pedido y producto con cantidad y precio propios. La consulta de catálogo inspecciona lo implementado, no descubre automáticamente todas las reglas del negocio.

### Paso a paso

1. Comprueba que estás en la base de práctica y que la [tienda](../docs/CASO_TIENDA.md) conserva sus datos iniciales.
2. Abre [LABORATORIO.sql](LABORATORIO.sql). Lee el script antes de enviarlo al servidor.
3. Predice el resultado de cada sentencia. Anota qué representa una fila y qué operaciones pueden cambiar datos.
4. Desde la raíz, ejecuta:

```text
psql -X -h localhost -U estudiante -d curso_sql -v ON_ERROR_STOP=1 -f unidad18-der/LABORATORIO.sql
```

La contraseña se solicita en la terminal; no la escribas en el repositorio.

5. Compara con la referencia: **Cuatro FK: producto→categoría, pedido→cliente, detalle→pedido y detalle→producto.**
6. Termina con la [práctica](PRACTICA.md), luego contrasta tus decisiones con las [soluciones razonadas](SOLUCIONES.md).

### Transferir la idea a otro problema

Dibuja el modelo tienda y señala una regla que el DER expresa pero una FK sola no garantiza.

Explica cómo cambiarían los datos si aparece una fila adicional, una referencia ausente o un empate. Distingue una garantía del esquema de una suposición que solo cumple esta muestra. El objetivo es construir una respuesta justificable, no copiar una consulta sin entender su población.

## Continuar el curso

- **Unidad anterior:** [Unidad 17: Operaciones de conjuntos](../unidad17-conjuntos/README.md)
- **Volver al índice:** [Todas las unidades](../README.md)
- **Siguiente unidad:** [Unidad 19: Dependencias y anomalías](../unidad19-anomalias/README.md)

---

### ¿Necesitas apoyo con este tema?

Si te bloqueaste con la práctica, necesitas revisar tu entorno o adaptar lo aprendido a tu proyecto, podemos trabajarlo en una sesión personalizada.

[**Solicitar asesoría para este tema por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20Unidad%2018%20%E2%80%94%20Diagrama%20entidad-relaci%C3%B3n%20del%20curso%20Bases%20de%20Datos%20y%20SQL%20desde%20cero%20%28https%3A%2F%2Fgithub.com%2Flelyliliana%2FCurso-Bases-de-Datos-SQL%2Ftree%2Fmain%2Funidad18-der%29%20y%20necesito%20una%20asesor%C3%ADa%20personalizada.%20Mi%20duda%20es%E2%80%A6)
