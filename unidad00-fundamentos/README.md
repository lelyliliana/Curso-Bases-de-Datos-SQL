# Unidad 00: Datos, información y bases de datos

[Volver al índice del curso](../README.md) · [Ver el curso en Aprende con Leli](https://lelyliliana.github.io/aprende-con-leli/cursos/bases-datos-sql/)

## Qué aprenderás

Al terminar podrás:
- diferenciar dato e información;
- explicar qué es una base de datos;
- explicar para qué sirve un DBMS/SGBD;
- reconocer problemas de almacenar información en archivos aislados;
- identificar situaciones donde una base de datos aporta valor.

## Antes de empezar

No necesitas conocimientos de programación ni SQL.

---

# 1. Empecemos con un problema

Imagina una pequeña tienda que guarda información así:

```text
clientes.xlsx
ventas_enero.xlsx
ventas_febrero.xlsx
productos.xlsx
productos_copia.xlsx
```

En `clientes.xlsx` aparece:

| documento | nombre | correo |
|---|---|---|
| 1001 | Ana Pérez | ana@email.com |

Pero en `ventas_febrero.xlsx`:

| cliente | correo |
|---|---|
| Ana Pérez | anaperez@email.com |

¿Cuál correo es correcto?

Ahora imagina 50 archivos y 20 000 clientes.

El problema ya no es simplemente “guardar datos”. Necesitamos mantenerlos **organizados, relacionados y consistentes**.

---

# 2. Dato e información

Un **dato** es una representación de un hecho.

```text
25
```

Por sí solo no sabemos qué significa.

Con contexto:

```text
Temperatura = 25 °C
```

ya podemos interpretarlo.

La **información** aparece cuando los datos tienen contexto y pueden utilizarse para comprender algo o tomar una decisión.

---

# 3. ¿Qué es una base de datos?

Una base de datos es una colección organizada de datos relacionados, diseñada para que puedan almacenarse, consultarse y mantenerse de forma controlada.

Ejemplo conceptual:

```text
CLIENTES
   │
   └── realizan ──→ PEDIDOS
                        │
                        └── contienen ──→ PRODUCTOS
```

No estamos guardando archivos independientes: estamos representando relaciones entre hechos.

---

# 4. ¿Qué es un DBMS o SGBD?

El **Sistema Gestor de Bases de Datos** es el software que administra la base.

Ejemplos:
- PostgreSQL;
- MySQL;
- MariaDB;
- SQL Server;
- Oracle Database;
- SQLite, con una arquitectura diferente de servidor tradicional.

En este curso utilizaremos **PostgreSQL**.

El gestor ayuda a:
- almacenar;
- consultar;
- modificar;
- controlar acceso;
- aplicar restricciones;
- manejar transacciones;
- recuperar información.

---

# 5. ¿Por qué no utilizar simplemente Excel?

Excel es excelente para muchos trabajos. El problema aparece cuando necesitamos características propias de un sistema de datos compartido.

Ejemplo:

```text
Cliente 1001
    ↓
Pedido 501
    ↓
Detalle
 ├── Producto 20
 └── Producto 35
```

Una base relacional puede garantizar que un pedido no haga referencia a un cliente inexistente.

Una hoja de cálculo no ofrece necesariamente las mismas garantías de integridad, concurrencia y transacciones.

La pregunta correcta no es “¿Excel es malo?”, sino:

> ¿qué herramienta corresponde a los requisitos del problema?

---

# 6. Problemas frecuentes con datos dispersos

## Duplicación
El mismo cliente aparece en varios archivos.

## Inconsistencia
Un archivo dice un correo y otro dice otro.

## Dificultad para relacionar
Responder “¿qué productos compró cada cliente?” requiere combinar archivos manualmente.

## Concurrencia
Varias personas modificando copias pueden generar conflictos.

## Integridad
Nada impide escribir una venta para un producto inexistente.

---

# 7. Ejemplo resuelto

Necesitamos almacenar estudiantes y cursos.

Una primera idea:

```text
estudiantes.xlsx
cursos.xlsx
matriculas.xlsx
```

Conceptualmente ya tenemos tres tipos de hechos:

1. quién es el estudiante;
2. qué curso existe;
3. qué estudiante está matriculado en qué curso.

Una base relacional puede representar:

```text
ESTUDIANTE
CURSO
MATRICULA
```

MATRICULA conecta los otros dos.

Todavía no necesitamos SQL. Primero necesitamos entender **qué información existe y cómo se relaciona**.

---

# 8. Práctica guiada

Una veterinaria necesita registrar:
- mascotas;
- propietarios;
- veterinarios;
- consultas.

### Paso 1
Identifica los tipos principales de información.

Respuesta esperada:

```text
PROPIETARIO
MASCOTA
VETERINARIO
CONSULTA
```

### Paso 2
Pregunta cómo se relacionan.

```text
PROPIETARIO → tiene → MASCOTA
MASCOTA → recibe → CONSULTA
VETERINARIO → atiende → CONSULTA
```

### Paso 3
Piensa qué problema surgiría guardando todo en una sola hoja.

El nombre y teléfono del propietario se repetirían por cada consulta de cada mascota.

Eso será importante cuando estudiemos normalización.

---

# 9. Errores frecuentes

### “Una base de datos es Excel pero más grande”
No. El tamaño es solo una dimensión. Integridad, relaciones, concurrencia y transacciones son diferencias fundamentales.

### “SQL es la base de datos”
SQL es un lenguaje utilizado para trabajar con muchos sistemas relacionales. PostgreSQL es el gestor.

### “Todo debe ir en una base de datos”
No. La tecnología debe responder al problema.

---

# 10. Ejercicios

## Básico
Clasifica como dato o información contextualizada:
1. `42`
2. `42 estudiantes aprobaron`
3. `2026-10-02`

## Intermedio
Identifica cuatro problemas potenciales de llevar inventario en archivos duplicados.

## Aplicación
Describe un proceso de tu entorno que utilice datos. Identifica:
- qué se registra;
- quién lo modifica;
- qué relaciones existen;
- qué inconsistencias podrían aparecer.

---

# 11. Reto

Una institución lleva estudiantes, cursos, notas y asistencia en archivos separados.

Describe:
1. tipos de datos;
2. relaciones;
3. tres riesgos de inconsistencia;
4. qué ventajas aportaría un DBMS.

No diseñes tablas todavía.

---

# 12. Autoevaluación

Intenta responder sin mirar arriba:

1. ¿Qué diferencia existe entre dato e información?
2. ¿Qué es una base de datos?
3. ¿Qué es un DBMS?
4. ¿PostgreSQL es un lenguaje o un gestor?
5. ¿SQL y PostgreSQL son lo mismo?
6. Menciona tres problemas de los datos dispersos.
7. ¿Por qué una hoja de cálculo puede seguir siendo apropiada en ciertos escenarios?

Si no puedes explicar las respuestas con tus palabras, repasa antes de continuar.

---

# 13. Antes de pasar a la Unidad 01

Debes poder marcar:

- [ ] Distingo dato e información.
- [ ] Puedo explicar qué es una base de datos sin memorizar una frase.
- [ ] Sé qué papel cumple PostgreSQL.
- [ ] Entiendo por qué relacionar datos es diferente de guardarlos.
- [ ] Puedo identificar problemas de duplicación e inconsistencia.

Continúa con **Unidad 01: Modelo relacional**.


---

## Caso desarrollado: Datos con contexto, calidad y elección del gestor

Una veterinaria recibe una hoja con propietario, teléfono, mascota, fecha y diagnóstico. El mismo propietario aparece por cada consulta y sus teléfonos discrepan. Define qué hechos existen, qué contexto necesitan las fechas y tres controles que aportarían valor.

### Solución explicada

La fecha debe indicar si corresponde a atención, registro o modificación. El diagnóstico describe una consulta, no una mascota para siempre. Identifica PROPIETARIO, MASCOTA, VETERINARIO y CONSULTA. Suponiendo un responsable actual por mascota, cada mascota pertenece a uno; cada consulta corresponde a una mascota y a un veterinario. Cambiar ese supuesto (custodia compartida o varios veterinarios) cambia las asociaciones. No inventes una única regla universal.

Tres controles: referencias a mascotas existentes, validación de fechas/tipos y una actualización coherente del teléfono actual del propietario. Una transacción agrupa cambios, los permisos limitan quién modifica y un respaldo probado permite recuperar. Ninguno descubre por sí solo un teléfono que está equivocado pero tiene un formato válido. Una hoja pequeña de uso individual puede ser apropiada; un proceso compartido con historial y reglas requiere otras garantías.

### Practicar y comprobar

Resuelve la [práctica](PRACTICA.md) con tus propias reglas. Compara después con las [soluciones razonadas](SOLUCIONES.md). En estas unidades el trabajo es conceptual: instala PostgreSQL al llegar a la Unidad 04, sin adelantar SQL que todavía no necesitas.

## Continuar el curso

- **Volver al índice:** [Todas las unidades](../README.md)
- **Siguiente unidad:** [Unidad 01: Modelo relacional](../unidad01-modelo-relacional/README.md)

---

### ¿Necesitas apoyo con este tema?

Si te bloqueaste con la práctica, necesitas revisar tu entorno o adaptar lo aprendido a tu proyecto, podemos trabajarlo en una sesión personalizada.

[**Solicitar asesoría para este tema por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20Unidad%2000%20%E2%80%94%20Datos%2C%20informaci%C3%B3n%20y%20bases%20de%20datos%20del%20curso%20Bases%20de%20Datos%20y%20SQL%20desde%20cero%20%28https%3A%2F%2Fgithub.com%2Flelyliliana%2FCurso-Bases-de-Datos-SQL%2Ftree%2Fmain%2Funidad00-fundamentos%29%20y%20necesito%20una%20asesor%C3%ADa%20personalizada.%20Mi%20duda%20es%E2%80%A6)
