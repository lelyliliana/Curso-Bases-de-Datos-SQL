# Práctica de la Unidad 03: Claves mínimas, NULL e integridad explícita

No necesitas instalar PostgreSQL para esta práctica conceptual. Escribe el modelo y las reglas antes de revisar soluciones.

## Caso guiado

MATRICULA contiene estudiante_id,curso_id,periodo,fecha y nota. Un estudiante puede repetir un curso en un periodo posterior, pero no duplicarlo en el mismo. Define claves y restricciones sin perder esa posibilidad.

1. Lista los hechos que necesitas conservar y el significado de cada dato.
2. Escribe los supuestos que estás utilizando.
3. Representa relaciones, atributos y claves si la unidad ya las introdujo.
4. Inventa un caso que el modelo acepte y otro que deba rechazar.
5. Identifica una regla que la tecnología no pueda deducir sin que alguien la explique.

## Aplicación independiente

Diseña ASIENTO_RESERVADO para un vuelo concreto. Decide la clave de negocio, la acción FK y qué ocurre al cancelar.

Entrega un esquema legible y justifica al menos tres decisiones. No se evalúa el dibujo por su estética: se evalúa que puedas explicar qué representa cada hecho y cómo cambian las reglas ante otra situación.

## Antes de avanzar

- [ ] Distingo datos observados de reglas del dominio.
- [ ] Puedo explicar mis supuestos con un ejemplo y un contraejemplo.
- [ ] No asigno una clave solo porque no se repite en una muestra pequeña.
- [ ] Sé qué pregunta debo hacer cuando el enunciado no define una regla.

[Soluciones](SOLUCIONES.md) · [Unidad](README.md)
