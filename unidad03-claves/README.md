# Unidad 03 — Claves y restricciones

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
