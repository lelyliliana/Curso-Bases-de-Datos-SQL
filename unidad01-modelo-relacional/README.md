# Unidad 01: Modelo relacional

[Volver al índice del curso](../README.md) · [Ver el curso en Aprende con Leli](https://lelyliliana.github.io/aprende-con-leli/cursos/bases-datos-sql/)

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

Continúa con **Unidad 02: Entidades, atributos y relaciones**.


---

## Caso desarrollado: Modelo relacional, conjuntos y multiplicidad en SQL

Ana cursa Java y Bases de datos; Luis cursa Java. Una fila persona incluye cursos='Java,Bases de datos'. Separa los hechos, define dominios y explica cómo encontrar quienes cursan Java.

### Solución explicada

PERSONA(id,nombre), CURSO(id,nombre), INSCRIPCION(persona_id,curso_id). PERSONA contiene Ana=1 y Luis=2, CURSO Java=10 y Bases de datos=20, INSCRIPCION contiene (1,10),(1,20),(2,10). La clave compuesta evita repetir una inscripción en este supuesto. Si existen periodos, se agrega periodo a la regla.

En teoría una relación es un conjunto de tuplas y no admite duplicados; SQL permite tablas sin claves y consultas que conservan duplicados (semántica de multiconjunto). Por eso una consulta no elimina automáticamente dos nombres iguales. Relación matemática tampoco tiene orden de filas: SQL requiere ORDER BY para pedirlo. Dominio significa valores válidos y semántica, no solo el tipo físico; un entero puede representar edad o cantidad, con límites diferentes.

LIBRO representa una edición y EJEMPLAR una copia física; un ISBN identifica normalmente una edición/formato, no toda obra abstracta. Si el negocio necesita agrupar traducciones y ediciones, introduce OBRA y EDICION antes de EJEMPLAR. Un título no es una clave candidata por parecer único en tres filas.

### Practicar y comprobar

Resuelve la [práctica](PRACTICA.md) con tus propias reglas. Compara después con las [soluciones razonadas](SOLUCIONES.md). En estas unidades el trabajo es conceptual: instala PostgreSQL al llegar a la Unidad 04, sin adelantar SQL que todavía no necesitas.

## Continuar el curso

- **Unidad anterior:** [Unidad 00: Datos, información y bases de datos](../unidad00-fundamentos/README.md)
- **Volver al índice:** [Todas las unidades](../README.md)
- **Siguiente unidad:** [Unidad 02: Entidades, atributos y relaciones](../unidad02-modelado/README.md)

---

### ¿Necesitas apoyo con este tema?

Si te bloqueaste con la práctica, necesitas revisar tu entorno o adaptar lo aprendido a tu proyecto, podemos trabajarlo en una sesión personalizada.

[**Solicitar asesoría para este tema por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20Unidad%2001%20%E2%80%94%20Modelo%20relacional%20del%20curso%20Bases%20de%20Datos%20y%20SQL%20desde%20cero%20%28https%3A%2F%2Fgithub.com%2Flelyliliana%2FCurso-Bases-de-Datos-SQL%2Ftree%2Fmain%2Funidad01-modelo-relacional%29%20y%20necesito%20una%20asesor%C3%ADa%20personalizada.%20Mi%20duda%20es%E2%80%A6)
