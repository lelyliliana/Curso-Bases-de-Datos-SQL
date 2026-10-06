# Unidad 20: Normalización: 1FN, 2FN y 3FN

[Volver al índice del curso](../README.md) · [Ver el curso en Aprende con Leli](https://lelyliliana.github.io/aprende-con-leli/cursos/bases-datos-sql/)

## Qué aprenderás
Normalizar un modelo paso a paso y, sobre todo, justificar cada separación.

## Cómo usar los ejemplos de esta unidad

Los ejemplos breves ilustran una idea y pueden usar un conjunto reducido de filas o una tabla independiente. Para ejecutarlos juntos sin conflictos, utiliza el laboratorio y la práctica de esta unidad sobre la [tienda de referencia](../docs/CASO_TIENDA.md). Sus scripts declaran la preparación, resultados y rollback. No vuelvas a crear las tablas de tienda ni repitas su carga para seguir un fragmento ilustrativo.

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

# 2. Primera Forma Normal: 1FN

Una relación debe manejar valores atómicos respecto del modelo, sin grupos repetidos del tipo:

```text
productos = "A,B,C"
```

No significa que “una coma esté prohibida”; significa que si esos valores representan hechos independientes que necesitas consultar/relacionar, no deberían esconderse como lista improvisada.

# 3. Segunda Forma Normal: 2FN

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

# 4. Tercera Forma Normal: 3FN

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
- Revisar solo la PK y olvidar otras claves candidatas compuestas.
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


---

## Laboratorio completo y lectura del resultado

**Caso:** ¿Separar tablas preserva los hechos al reconstruir una venta?

2FN exige 1FN y ausencia de dependencias parciales de atributos no primos respecto de cualquier clave candidata. Una PK artificial de una columna no arregla otra clave candidata compuesta con dependencias parciales. 3FN formal: para cada dependencia no trivial X→A, X es superclave o A es primo. La regla de eliminar transitivas es una guía para los casos simples del curso, no toda la definición.

### Paso a paso

1. Comprueba que estás en la base de práctica y que la [tienda](../docs/CASO_TIENDA.md) conserva sus datos iniciales.
2. Abre [LABORATORIO.sql](LABORATORIO.sql). Lee el script antes de enviarlo al servidor.
3. Predice el resultado de cada sentencia. Anota qué representa una fila y qué operaciones pueden cambiar datos.
4. Desde la raíz, ejecuta:

```text
psql -X -h localhost -U estudiante -d curso_sql -v ON_ERROR_STOP=1 -f unidad20-normalizacion/LABORATORIO.sql
```

La contraseña se solicita en la terminal; no la escribas en el repositorio.

5. Compara con la referencia: **Cinco filas de detalle, sin pérdida ni multiplicación accidental. Los precios de venta son 80,120,90,75,90.**
6. Termina con la [práctica](PRACTICA.md), luego contrasta tus decisiones con las [soluciones razonadas](SOLUCIONES.md).

### Transferir la idea a otro problema

Normaliza inscripción(persona_id,evento_id,persona_nombre,evento_nombre,organizador_id,organizador_nombre,fecha_inscripcion), suponiendo una inscripción por persona y evento.

Explica cómo cambiarían los datos si aparece una fila adicional, una referencia ausente o un empate. Distingue una garantía del esquema de una suposición que solo cumple esta muestra. El objetivo es construir una respuesta justificable, no copiar una consulta sin entender su población.

## Continuar el curso

- **Unidad anterior:** [Unidad 19: Dependencias y anomalías](../unidad19-anomalias/README.md)
- **Volver al índice:** [Todas las unidades](../README.md)
- **Siguiente unidad:** [Unidad 21: Integridad referencial](../unidad21-integridad/README.md)

