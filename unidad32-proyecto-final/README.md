# Unidad 32 — Proyecto final

## Propósito

Demostrar que puedes pasar de un problema real a una base de datos reproducible, íntegra, consultable y operable.

No empieces escribiendo tablas. Sigue las etapas.

# Etapa 1 — Problema

Escribe:
- contexto;
- usuarios;
- información que necesitan;
- alcance;
- cinco preguntas que la base deberá responder.

Ejemplos de dominios:
- biblioteca;
- reservas;
- inventario;
- eventos;
- clínica ficticia;
- comercio;
- gestión académica ficticia.

Evita datos personales reales.

# Etapa 2 — Reglas

Documenta al menos diez reglas.

Ejemplo:
> Un pedido pertenece exactamente a un cliente.

> Un detalle tiene cantidad mayor que cero.

# Etapa 3 — DER

Construye modelo conceptual:
- entidades;
- relaciones;
- cardinalidades;
- opcionalidad.

Valídalo contra escenarios.

# Etapa 4 — Modelo relacional

Transforma a relaciones/tablas.

Define:
- PK;
- claves candidatas;
- FK;
- UNIQUE;
- NOT NULL;
- CHECK.

# Etapa 5 — Normalización

Elige al menos una parte del modelo y demuestra:
- tabla/estructura problemática;
- dependencias;
- 1FN/2FN/3FN cuando correspondan;
- resultado.

No escribas solamente “está en 3FN”.

# Etapa 6 — DDL

Crea scripts numerados:

```text
01_schema.sql
02_datos.sql
03_consultas.sql
04_vistas.sql
05_indices.sql
06_roles.sql
```

Otra persona debe poder ejecutarlos en orden.

# Etapa 7 — Datos de prueba

Crea datos que incluyan:
- caso normal;
- fronteras;
- relaciones;
- filas sin relación opcional cuando aplique.

No uses datos personales reales.

# Etapa 8 — Consultas

Incluye al menos:
- filtros;
- JOIN;
- agregaciones;
- GROUP BY/HAVING;
- subconsulta o EXISTS;
- CTE;
- reporte útil.

Cada consulta debe tener una pregunta asociada.

# Etapa 9 — Vista

Crea una vista con propósito claro.

Explica quién la usaría.

# Etapa 10 — Transacción

Implementa/demuestra una operación todo-o-nada.

Prueba COMMIT y ROLLBACK en entorno controlado.

# Etapa 11 — Índices y EXPLAIN

Selecciona consultas que puedan justificar optimización.

Captura:
- plan inicial;
- hipótesis;
- índice/cambio;
- plan posterior;
- conclusión.

No es obligatorio que el índice gane: una conclusión “PostgreSQL prefirió Seq Scan por el tamaño/distribución” puede ser correcta si está sustentada.

# Etapa 12 — Seguridad

Diseña al menos:
- rol de lectura;
- rol de aplicación u operación.

Aplica mínimo privilegio.

No publiques credenciales reales.

# Etapa 13 — Calidad/importación

Incluye una pequeña fuente externa ficticia o generada.

Usa staging y produce un reporte de calidad.

# Etapa 14 — Backup y restauración

Crea respaldo y restáuralo en otra base.

Verifica:
- objetos;
- conteos;
- consultas críticas.

# Etapa 15 — README

Debe permitir a una persona nueva:
1. instalar/reconocer requisitos;
2. crear base;
3. ejecutar scripts;
4. probar consultas;
5. comprender modelo;
6. restaurar backup de práctica cuando corresponda.

# Evidencias finales

Entrega:
- DER;
- diccionario;
- SQL;
- datos ficticios;
- consultas;
- planes;
- reporte de calidad;
- documentación de restauración;
- README.

Consulta `PLANTILLA_PROYECTO.md`, `RUBRICA.md` y `CHECKLIST.md`.

# Autoevaluación

Antes de declarar terminado:
- ¿otra persona puede reconstruirlo?
- ¿las restricciones impiden datos inválidos?
- ¿cada índice tiene una razón?
- ¿puedes explicar cada JOIN?
- ¿probaste restauración?
- ¿hay algún secreto/dato personal en el repositorio?

Si una respuesta es dudosa, el proyecto aún no está terminado.
