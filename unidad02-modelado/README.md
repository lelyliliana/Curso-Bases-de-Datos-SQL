# Unidad 02: Entidades, atributos y relaciones

[Volver al índice del curso](../README.md) · [Ver el curso en Aprende con Leli](https://lelyliliana.github.io/aprende-con-leli/cursos/bases-datos-sql/)

## Qué aprenderás
- identificar entidades;
- distinguir entidad de atributo;
- establecer cardinalidad y opcionalidad;
- transformar un enunciado en un modelo conceptual.

# 1. Caso inicial

“Una biblioteca presta libros a usuarios.”

Parece sencillo, pero aparecen preguntas:

- ¿prestamos un título o una copia física?
- ¿un usuario puede tener varios préstamos?
- ¿un ejemplar puede estar en dos préstamos activos?
- ¿necesitamos autor?
- ¿un libro puede tener varios autores?

Modelar consiste en **hacer explícitas estas reglas**.

# 2. Entidad

Una entidad representa algo del dominio sobre lo que necesitamos conservar información.

Ejemplos:
```text
USUARIO
LIBRO
EJEMPLAR
PRESTAMO
```

No todo sustantivo merece una entidad. “Color” podría ser simplemente atributo dependiendo del problema.

# 3. Atributo

Describe una propiedad.

```text
USUARIO
- id
- nombre
- correo
```

Pregunta: ¿el atributo describe a esa entidad o a otra cosa?

La fecha_devolucion no describe al LIBRO: describe un PRESTAMO concreto.

# 4. Cardinalidad

## Uno a muchos
```text
LIBRO 1 ───── N EJEMPLAR
```

Un libro puede tener varias copias; cada ejemplar corresponde a un libro.

## Muchos a muchos
```text
LIBRO N ───── M AUTOR
```

En el modelo relacional, esta relación suele materializarse mediante una relación intermedia.

# 5. Opcionalidad

¿Toda mascota debe tener propietario?

Si el sistema registra animales rescatados sin propietario, la relación podría ser opcional de un lado.

Cardinalidad y opcionalidad expresan **reglas del negocio**, no preferencias del diseñador.

# 6. Ejemplo resuelto: Tienda

Enunciado:
“Clientes realizan pedidos. Cada pedido contiene productos y registra la cantidad y precio vendido.”

Modelo:

```text
CLIENTE 1 ─── N PEDIDO
PEDIDO  1 ─── N DETALLE_PEDIDO N ─── 1 PRODUCTO
```

¿Por qué DETALLE_PEDIDO?

Porque la relación pedido-producto tiene datos propios:
- cantidad;
- precio_unitario.

# 7. Práctica guiada: Veterinaria

Necesitamos:
- propietario;
- mascota;
- veterinario;
- consulta.

```text
PROPIETARIO 1 ── N MASCOTA
MASCOTA     1 ── N CONSULTA
VETERINARIO 1 ── N CONSULTA
```

Ahora pregunta: ¿puede una consulta tener varios veterinarios? Si la respuesta cambia, cambia el modelo.

# 8. Errores frecuentes

- Crear una tabla por cada palabra del enunciado.
- Poner atributos de una relación en una entidad incorrecta.
- Definir cardinalidades por intuición sin preguntar reglas.
- Diseñar directamente en SQL antes de entender el dominio.

# 9. Ejercicios

Para cada caso identifica entidades y relaciones:
1. colegio: estudiantes, cursos, docentes;
2. hotel: habitaciones, huéspedes, reservas;
3. clínica: pacientes, citas, especialistas;
4. tienda: productos, categorías, proveedores.

# 10. Reto

Modela una plataforma de eventos con:
- organizadores;
- eventos;
- asistentes;
- inscripciones;
- pagos.

Escribe cinco preguntas que necesitarías hacer al responsable del negocio antes de cerrar el modelo.

# 11. Autoevaluación

1. ¿Qué convierte algo en entidad?
2. ¿Qué es cardinalidad?
3. ¿Qué es opcionalidad?
4. ¿Dónde debería vivir un atributo que describe una relación?
5. ¿Por qué el modelo depende de reglas del negocio?

# 12. Antes de continuar
- [ ] Identifico entidades.
- [ ] Asigno atributos con sentido.
- [ ] Expreso 1:1, 1:N y N:M.
- [ ] Pregunto por opcionalidad.
- [ ] No salto directamente a CREATE TABLE.

Continúa con **Unidad 03: Claves y restricciones**.


---

## Caso desarrollado: Cardinalidad, opcionalidad y preguntas al dominio

Una plataforma registra eventos, asistentes e inscripciones. Un evento tiene un organizador, puede no tener inscritos todavía y cada inscripción corresponde a un evento y a un asistente. Modela y anota supuestos.

### Solución explicada

ORGANIZADOR 1 a 0..N EVENTO; EVENTO 1 a 0..N INSCRIPCION; ASISTENTE 1 a 0..N INSCRIPCION. Cada inscripción tiene exactamente un evento y un asistente. Bajo el supuesto de inscripción única por evento: clave candidata (evento_id,asistente_id). Si hay varios intentos o entradas transferibles, distingue inscripción de entrada y vuelve a definir unicidad.

Fecha de inscripción pertenece a INSCRIPCION; capacidad a EVENTO. No pongas fecha de pago en ASISTENTE porque una persona puede pagar varias inscripciones. Si una inscripción admite abonos, PAGO es una entidad hija con importe y fecha. Capacidad no negativa se protege por fila, pero «inscritos no superan capacidad» requiere coordinación entre filas; una FK no resuelve esa regla.

Preguntas que cambian el modelo: ¿organizadores conjuntos?, ¿inscripción cancelada permite volver a inscribirse?, ¿evento gratuito admite pagos?, ¿una persona compra para otras?, ¿cómo se controla el cupo concurrentemente? Distingue reglas confirmadas de dudas. No confundas participación mínima cero con ausencia de una FK obligatoria del otro lado.

### Practicar y comprobar

Resuelve la [práctica](PRACTICA.md) con tus propias reglas. Compara después con las [soluciones razonadas](SOLUCIONES.md). En estas unidades el trabajo es conceptual: instala PostgreSQL al llegar a la Unidad 04, sin adelantar SQL que todavía no necesitas.

## Continuar el curso

- **Unidad anterior:** [Unidad 01: Modelo relacional](../unidad01-modelo-relacional/README.md)
- **Volver al índice:** [Todas las unidades](../README.md)
- **Siguiente unidad:** [Unidad 03: Claves y restricciones](../unidad03-claves/README.md)

