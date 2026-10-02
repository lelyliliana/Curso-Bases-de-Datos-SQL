# Unidad 01 — Modelo relacional

## Qué aprenderás
- comprender relación, fila, columna y dominio;
- distinguir una tabla visual de la idea matemática de relación;
- reconocer claves candidatas;
- representar información evitando listas dentro de celdas.

## Antes de empezar
Debes comprender qué es una base de datos y un DBMS.

# 1. El problema

Tenemos estudiantes y cursos:

```text
Ana → Bases de Datos, Java
Luis → Java
Sara → Bases de Datos, Java, Redes
```

Podríamos escribir:

| estudiante | cursos |
|---|---|
| Ana | Bases de Datos, Java |

Pero ahora pregunta: “¿cuántos estudiantes cursan Java?”

Tendríamos que interpretar texto dentro de una celda.

El modelo relacional propone representar hechos mediante **relaciones**.

# 2. Relación, tupla y atributo

Una relación puede visualizarse como tabla:

| id | nombre | correo |
|---:|---|---|
| 1 | Ana | ana@example.com |
| 2 | Luis | luis@example.com |

- relación: ESTUDIANTE;
- atributos: id, nombre, correo;
- tupla: cada fila;
- dominio: conjunto/tipo de valores permitidos para un atributo.

La tabla es una representación práctica. En el modelo relacional, el orden de las filas no define significado.

# 3. Separar hechos

```text
ESTUDIANTE
id | nombre

CURSO
id | nombre

MATRICULA
estudiante_id | curso_id
```

Ahora Java no está escondido dentro de una cadena.

```text
ESTUDIANTE 1 ─┐
              ├─ MATRÍCULA ─ CURSO 10
ESTUDIANTE 2 ─┘
```

# 4. Claves candidatas

Necesitamos identificar una fila.

Un correo podría parecer único, pero puede cambiar. Un identificador interno puede ser más estable.

Todavía no existe una única respuesta universal: la elección depende del dominio.

# 5. Ejemplo resuelto

Biblioteca:

```text
LIBRO(id, isbn, titulo)
EJEMPLAR(id, libro_id, codigo_inventario)
```

¿Por qué dos relaciones?

Un libro representa una obra/edición; una biblioteca puede poseer varias copias físicas.

Si "Cien años de soledad" tiene 4 copias, no queremos duplicar título/ISBN cuatro veces como si fueran cuatro libros conceptualmente diferentes.

# 6. Práctica guiada

Representa médicos y pacientes.

Un paciente puede ser atendido por varios médicos y un médico por varios pacientes.

Necesitamos un hecho intermedio:

```text
CONSULTA
id | paciente_id | medico_id | fecha
```

Observa que CONSULTA no es solo “un puente”: posee datos propios, como fecha.

# 7. Errores frecuentes

### Guardar listas en una columna
```text
telefonos = "300...,301..."
```
puede dificultar consulta e integridad cuando cada teléfono es un hecho independiente.

### Creer que las filas tienen un orden natural
Si necesitas orden, la consulta deberá expresarlo.

### Confundir relación con relación entre entidades
En teoría relacional, “relación” tiene un significado formal cercano a la estructura tabular. En modelado ER, “relación” suele usarse para asociación entre entidades. El contexto importa.

# 8. Ejercicios

1. Convierte estudiante+cursos en tres relaciones.
2. Representa autores y libros N:M.
3. Separa película y copia física.
4. Identifica posibles claves candidatas para VEHICULO.

# 9. Reto

Modela conceptualmente:
- personas;
- eventos;
- inscripciones;
- pagos de inscripción.

No uses SQL.

# 10. Autoevaluación

1. ¿Qué es una tupla?
2. ¿Qué es un atributo?
3. ¿Qué es un dominio?
4. ¿Por qué el orden de filas no debe asumirse?
5. ¿Por qué una lista separada por comas puede ser problemática?
6. ¿Qué diferencia existe entre LIBRO y EJEMPLAR?

# 11. Antes de continuar
- [ ] Puedo representar hechos como relaciones.
- [ ] Distingo fila, atributo y dominio.
- [ ] No dependo del orden físico.
- [ ] Puedo detectar valores multivaluados improvisados.

Continúa con **Unidad 02 — Entidades, atributos y relaciones**.
