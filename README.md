# Bases de Datos y SQL desde cero

## Empezar y comprobar

Curso público para aprender desde fundamentos hasta diseñar, consultar y operar una base relacional. Conserva 33 unidades en su orden original. La referencia es PostgreSQL 18 y el SQL se comprueba también con 17.

1. Comienza por Unidad 00 y resuelve las prácticas conceptuales 00–03.
2. En Unidad 04 configura [Ubuntu, Windows o macOS](docs/ENTORNO.md) y carga la [tienda reproducible](docs/CASO_TIENDA.md).
3. En cada unidad lee, predice, ejecuta el laboratorio, resuelve PRACTICA.md y contrasta SOLUCIONES.md. Los scripts de laboratorio terminan con rollback; la carga inicial se ejecuta una vez.
4. Integra conocimientos en el taller 31 y construye el proyecto 32. Estudia la [biblioteca completa](proyecto-biblioteca/README.md) como referencia después de diseñar tu solución.
5. Consulta [diagnóstico](docs/DIAGNOSTICO_SQL.md), [referencias oficiales](docs/REFERENCIAS.md) y [verificación automática](docs/VERIFICACION.md) cuando necesites comprobar un resultado.

El proyecto de referencia incluye operaciones transaccionales, restricciones, permisos y pruebas de dos solicitudes al mismo ejemplar. Los datos son ficticios y las instrucciones incluyen Ubuntu, Windows y macOS.


**[Comenzar el curso: Unidad 00: Datos, información y bases de datos](unidad00-fundamentos/README.md)**

Puedes leer las lecciones aquí sin conocer GitHub. Al terminar cada unidad, usa **Siguiente unidad** para avanzar; **Unidad anterior** y **Volver al índice** te permiten regresar.

[Ver el curso en Aprende con Leli](https://lelyliliana.github.io/aprende-con-leli/cursos/bases-datos-sql/)

**Versión 2.0**

Curso abierto para aprender **bases de datos relacionales y SQL**, desde el modelado de información hasta consultas, integridad, transacciones, índices y optimización.

**Motor de referencia:** PostgreSQL.

## Objetivo

Al finalizar podrás modelar entidades y relaciones, diseñar tablas y restricciones, escribir consultas SQL, combinar información, normalizar esquemas, trabajar con transacciones e índices, interpretar planes de ejecución básicos y construir una base de datos completa.

## Ruta

### Nivel 1: Fundamentos
- [Unidad 00: Datos, información y bases de datos](unidad00-fundamentos/)
- [Unidad 01: Modelo relacional](unidad01-modelo-relacional/)
- [Unidad 02: Entidades, atributos y relaciones](unidad02-modelado/)
- [Unidad 03: Claves y restricciones](unidad03-claves/)
- [Unidad 04: PostgreSQL y entorno](unidad04-postgresql/)

### Nivel 2: SQL esencial
- [Unidad 05: CREATE TABLE y tipos](unidad05-create-table/)
- [Unidad 06: INSERT](unidad06-insert/)
- [Unidad 07: SELECT](unidad07-select/)
- [Unidad 08: WHERE y operadores](unidad08-where/)
- [Unidad 09: ORDER BY, LIMIT y DISTINCT](unidad09-order-limit/)
- [Unidad 10: UPDATE y DELETE](unidad10-update-delete/)

### Nivel 3: Consultas
- [Unidad 11: Funciones y expresiones](unidad11-funciones/)
- [Unidad 12: Agregaciones](unidad12-agregaciones/)
- [Unidad 13: GROUP BY y HAVING](unidad13-group-having/)
- [Unidad 14: JOIN](unidad14-joins/)
- [Unidad 15: Subconsultas](unidad15-subconsultas/)
- [Unidad 16: CTE](unidad16-cte/)
- [Unidad 17: Operaciones de conjuntos](unidad17-conjuntos/)

### Nivel 4: Diseño
- [Unidad 18: Diagrama entidad-relación](unidad18-der/)
- [Unidad 19: Dependencias y anomalías](unidad19-anomalias/)
- [Unidad 20: Normalización 1FN, 2FN y 3FN](unidad20-normalizacion/)
- [Unidad 21: Integridad referencial](unidad21-integridad/)

### Nivel 5: Uso en aplicaciones
- [Unidad 22: Vistas](unidad22-vistas/)
- [Unidad 23: Transacciones ACID](unidad23-transacciones/)
- [Unidad 24: Concurrencia y aislamiento](unidad24-concurrencia/)
- [Unidad 25: Índices](unidad25-indices/)
- [Unidad 26: EXPLAIN y planes de ejecución](unidad26-explain/)

### Nivel 6: Administración básica
- [Unidad 27: Usuarios, roles y privilegios](unidad27-seguridad/)
- [Unidad 28: Importación y exportación](unidad28-import-export/)
- [Unidad 29: Backup y restauración](unidad29-backup/)
- [Unidad 30: Calidad y limpieza de datos](unidad30-calidad/)

### Nivel 7: Integración
- [Unidad 31: Taller SQL](unidad31-taller/)
- [Unidad 32: Proyecto final](unidad32-proyecto-final/)

## Metodología

Modelo → SQL → resultado → interpretación → errores → ejercicios → reto.

## Alcance

Los conceptos relacionales se distinguen de las particularidades de PostgreSQL. El curso no depende de Java, Spring Boot ni otro lenguaje de programación.

## Principio

> Una base de datos no es una colección de tablas: es un modelo de información con reglas de integridad, operaciones y decisiones de diseño que deben justificarse.

## Autora

**Leli Liliana Díaz Izquierdo**

Ingeniera de Sistemas · Docente investigadora · Tecnología, educación e investigación.
