# Soluciones razonadas: Unidad 01

## Caso guiado

PERSONA(id,nombre), CURSO(id,nombre), INSCRIPCION(persona_id,curso_id). PERSONA contiene Ana=1 y Luis=2, CURSO Java=10 y Bases de datos=20, INSCRIPCION contiene (1,10),(1,20),(2,10). La clave compuesta evita repetir una inscripción en este supuesto. Si existen periodos, se agrega periodo a la regla.

En teoría una relación es un conjunto de tuplas y no admite duplicados; SQL permite tablas sin claves y consultas que conservan duplicados (semántica de multiconjunto). Por eso una consulta no elimina automáticamente dos nombres iguales. Relación matemática tampoco tiene orden de filas: SQL requiere ORDER BY para pedirlo. Dominio significa valores válidos y semántica, no solo el tipo físico; un entero puede representar edad o cantidad, con límites diferentes.

LIBRO representa una edición y EJEMPLAR una copia física; un ISBN identifica normalmente una edición/formato, no toda obra abstracta. Si el negocio necesita agrupar traducciones y ediciones, introduce OBRA y EDICION antes de EJEMPLAR. Un título no es una clave candidata por parecer único en tres filas.

## Aplicación independiente

AUTOR(id,nombre), LIBRO(id,isbn,titulo), AUTORIA(autor_id,libro_id), PK de AUTORIA=(autor_id,libro_id). Cada fila representa participación, no una lista de nombres. Si importa orden de autores, agrega posicion con UNIQUE(libro_id,posicion); documenta la regla.

## Comprobar el razonamiento

Cambiar un supuesto puede producir otra solución válida. Explica el supuesto, prueba dos escenarios y revisa que el modelo no acepte un caso prohibido ni rechace uno permitido. Los datos de prueba ayudan a encontrar contradicciones; no sustituyen reglas del dominio.

[Práctica](PRACTICA.md) · [Unidad](README.md)
