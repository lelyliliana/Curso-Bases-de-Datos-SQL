# Unidad 03: Claves y restricciones

[Volver al índice del curso](../README.md) · [Ver el curso en Aprende con Leli](https://lelyliliana.github.io/aprende-con-leli/cursos/bases-datos-sql/)

## Qué aprenderás
- comprender claves primarias, candidatas y foráneas;
- usar unicidad, obligatoriedad y reglas de dominio;
- distinguir identificador técnico de regla de negocio;
- entender que la base puede proteger la calidad de los datos.

# 1. Problema inicial

Tenemos:

| nombre | correo |
|---|---|
| Ana Pérez | ana@example.com |
| Ana Pérez | ana2@example.com |

¿El nombre identifica a una persona? No.

Necesitamos decidir qué atributo o conjunto de atributos identifica cada registro.

# 2. Clave candidata

Es un conjunto mínimo de atributos capaz de identificar una tupla.

En PERSONA podrían existir candidatos dependiendo del dominio:
- documento;
- correo institucional.

Pero ambos tienen implicaciones: pueden cambiar, tener excepciones o reglas legales.

# 3. Clave primaria

Elegimos una clave candidata como identificador principal.

En sistemas prácticos es común usar un ID generado:

```text
id = 123
```

Eso no elimina las reglas naturales. Si correo debe ser único, sigue necesitando UNIQUE.

# 4. Clave foránea

Conecta una fila con otra relación.

```text
PEDIDO.cliente_id → CLIENTE.id
```

La FK evita, por ejemplo, crear un pedido para cliente 999 si ese cliente no existe.

# 5. Restricciones

## NOT NULL
El valor es obligatorio.

## UNIQUE
No se permite repetir según la restricción.

## CHECK
```text
precio > 0
cantidad > 0
```

## FOREIGN KEY
Mantiene referencia válida.

# 6. Ejemplo resuelto

Producto:
```text
id              PK
codigo          UNIQUE NOT NULL
nombre          NOT NULL
precio          CHECK > 0
categoria_id    FK
```

Pregunta: ¿por qué id y codigo?

El ID puede ser identificador técnico estable. El código sigue siendo una regla del negocio y debe protegerse con UNIQUE.

# 7. Práctica guiada

MATRICULA:
```text
estudiante_id
curso_id
periodo
```

¿Puede un estudiante matricular el mismo curso dos veces en periodos distintos?

Si sí, una restricción única solo sobre estudiante+curso sería incorrecta.

Podría ser:
```text
UNIQUE(estudiante_id, curso_id, periodo)
```

El dominio define la clave.

# 8. Errores frecuentes

- Creer que tener ID vuelve innecesario UNIQUE.
- Permitir NULL en campos obligatorios “porque la aplicación valida”.
- Crear FK sin entender qué debe ocurrir al borrar el padre.
- Usar texto libre para estados que tienen conjunto cerrado sin ninguna validación.

# 9. Ejercicios

Diseña claves/restricciones para:
1. usuario;
2. producto;
3. matrícula;
4. asiento de vuelo;
5. detalle de pedido.

# 10. Reto

Para un sistema de citas médicas define reglas que la base podría proteger. Separa:
- integridad estructural;
- reglas que requieren lógica más compleja.

# 11. Autoevaluación

1. ¿Qué es clave candidata?
2. ¿PK y UNIQUE son equivalentes conceptualmente?
3. ¿Para qué sirve FK?
4. ¿Qué protege CHECK?
5. ¿Por qué un ID artificial no sustituye reglas de unicidad del negocio?

# 12. Checklist
- [ ] Identifico PK.
- [ ] Identifico claves naturales relevantes.
- [ ] Sé cuándo usar UNIQUE.
- [ ] Comprendo FK.
- [ ] Puedo proponer CHECK.

Continúa con PostgreSQL.


---

## Caso desarrollado: Claves mínimas, NULL e integridad explícita

MATRICULA contiene estudiante_id,curso_id,periodo,fecha y nota. Un estudiante puede repetir un curso en un periodo posterior, pero no duplicarlo en el mismo. Define claves y restricciones sin perder esa posibilidad.

### Solución explicada

Clave candidata (estudiante_id,curso_id,periodo). Es mínima bajo la regla: quitar cualquiera permitiría ambigüedad. Una superclave puede agregar fecha y seguir identificando, pero ya no es mínima. Puedes elegir PK compuesta o id técnico con UNIQUE(estudiante_id,curso_id,periodo) y NOT NULL en sus componentes. Nota puede ser NULL antes de calificar; CHECK(nota BETWEEN 0 AND 5) limita valores presentes, no obliga a calificar.

En PostgreSQL, UNIQUE permite normalmente varios NULL: NULL no se considera igual a otro NULL para esa restricción. UNIQUE NULLS NOT DISTINCT cambia esa política. Una PK combina unicidad con no nulidad, y solo hay una PK por tabla. IDENTITY sin PK o UNIQUE no garantiza unicidad de la tabla.

Un CHECK se satisface con TRUE o UNKNOWN; por ello CHECK(precio>0) debe acompañarse de NOT NULL si el precio es obligatorio. No valida otras filas ni la existencia de un padre: usa FK para eso. Una FK nullable permite ausencia del padre; FK más NOT NULL exige una referencia válida. No evalúa que un padre tenga hijos.

### Practicar y comprobar

Resuelve la [práctica](PRACTICA.md) con tus propias reglas. Compara después con las [soluciones razonadas](SOLUCIONES.md). En estas unidades el trabajo es conceptual: instala PostgreSQL al llegar a la Unidad 04, sin adelantar SQL que todavía no necesitas.

## Continuar el curso

- **Unidad anterior:** [Unidad 02: Entidades, atributos y relaciones](../unidad02-modelado/README.md)
- **Volver al índice:** [Todas las unidades](../README.md)
- **Siguiente unidad:** [Unidad 04: PostgreSQL y entorno](../unidad04-postgresql/README.md)

