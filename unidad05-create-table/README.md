# Unidad 05: CREATE TABLE y tipos de datos

[Volver al índice del curso](../README.md) · [Ver el curso en Aprende con Leli](https://lelyliliana.github.io/aprende-con-leli/cursos/bases-datos-sql/)

## Qué aprenderás
Crear tablas, elegir tipos y proteger reglas con restricciones.

## Antes de empezar
Debes comprender entidades, claves y poder conectarte a PostgreSQL.

## Cómo usar los ejemplos de esta unidad

Los ejemplos breves ilustran una idea y pueden usar un conjunto reducido de filas o una tabla independiente. Para ejecutarlos juntos sin conflictos, utiliza el laboratorio y la práctica de esta unidad sobre la [tienda de referencia](../docs/CASO_TIENDA.md). Sus scripts declaran la preparación, resultados y rollback. No vuelvas a crear las tablas de tienda ni repitas su carga para seguir un fragmento ilustrativo.

# 1. Del modelo a una tabla
```sql
CREATE TABLE producto (
 id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
 nombre text NOT NULL,
 precio numeric(12,2) NOT NULL CHECK (precio > 0),
 activo boolean NOT NULL DEFAULT true
);
```

# 2. Leer la definición
| columna | tipo | regla |
|---|---|---|
| id | bigint | identidad + PK |
| nombre | text | obligatorio |
| precio | numeric(12,2) | > 0 |
| activo | boolean | true por defecto |

# 3. Tipos
**text:** texto variable.  
**integer/bigint:** enteros.  
**numeric(p,s):** decimal exacto controlado.  
**boolean:** verdadero/falso.  
**date/time/timestamp/timestamptz:** valores temporales.

No guardes fechas o números como texto solo por comodidad si luego necesitas operaciones propias de esos dominios.

# 4. Identity
```sql
id bigint GENERATED ALWAYS AS IDENTITY
```
PostgreSQL genera el identificador. No calcules manualmente “el siguiente”.

# 5. Restricciones
```sql
nombre text NOT NULL
precio numeric(12,2) CHECK (precio > 0)
```
La base protege estas reglas aunque el cliente falle.

# 6. Práctica guiada
```sql
CREATE TABLE categoria (
 id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
 nombre text NOT NULL UNIQUE
);
```

En psql:
```text
\d categoria
```

Identifica columnas, tipos, PK y UNIQUE.

# 7. Comprueba la restricción
```sql
INSERT INTO categoria(nombre) VALUES ('Libros');
INSERT INTO categoria(nombre) VALUES ('Libros');
```
La segunda debe fallar. Ese error demuestra que la regla funciona.

# 8. Prueba PRODUCTO
Intenta:
1. precio 100;
2. precio 0;
3. nombre NULL.

Predice qué ocurrirá antes de ejecutar.

# 9. Errores frecuentes
- Elegir text para todo.
- Confundir DEFAULT con obligatoriedad.
- Crear restricciones sin comprender el dominio.
- Creer que un error de constraint “dañó” la base.

# 10. Ejercicios
Diseña tablas para cliente, estudiante, libro y habitación. Incluye PK, NOT NULL y otra restricción pertinente.

# 11. Reto
Diseña categoria, producto y cliente para una tienda y justifica cada tipo.

# 12. Autoevaluación
1. ¿Qué hace CREATE TABLE?
2. ¿Por qué numeric puede ser apropiado para dinero?
3. ¿DEFAULT y NOT NULL son lo mismo?
4. ¿Qué protege CHECK?
5. ¿Qué hace IDENTITY?

# 13. Checklist
- [ ] Creo tablas.
- [ ] Elijo tipos básicos.
- [ ] Uso PK, NOT NULL, UNIQUE y CHECK.
- [ ] Interpreto errores de restricciones.

Continúa con INSERT.


---

## Laboratorio completo y lectura del resultado

**Caso:** ¿Cómo evolucionar una tabla sin confundir tipos, valores por defecto y restricciones?

DEFAULT actúa cuando se omite la columna o se usa DEFAULT; no reemplaza un NULL explícito. CHECK admite TRUE o UNKNOWN, de modo que precio necesita también NOT NULL. IDENTITY genera valores, pero no reemplaza una PK. ALTER TABLE puede bloquear y validar filas existentes; aquí se practica en una tabla temporal.

### Paso a paso

1. Comprueba que estás en la base de práctica y que la [tienda](../docs/CASO_TIENDA.md) conserva sus datos iniciales.
2. Abre [LABORATORIO.sql](LABORATORIO.sql). Lee el script antes de enviarlo al servidor.
3. Predice el resultado de cada sentencia. Anota qué representa una fila y qué operaciones pueden cambiar datos.
4. Desde la raíz, ejecuta:

```text
psql -X -h localhost -U estudiante -d curso_sql -v ON_ERROR_STOP=1 -f unidad05-create-table/LABORATORIO.sql
```

La contraseña se solicita en la terminal; no la escribas en el repositorio.

5. Compara con la referencia: **Cuaderno, 12.35, true, CU-01. numeric(12,2) redondea al almacenar dos decimales.**
6. Termina con la [práctica](PRACTICA.md), luego contrasta tus decisiones con las [soluciones razonadas](SOLUCIONES.md).

### Transferir la idea a otro problema

Crea una tabla temporal de reservas con inicio y fin date obligatorios, CHECK(fin > inicio), y carga una reserva de dos noches.

Explica cómo cambiarían los datos si aparece una fila adicional, una referencia ausente o un empate. Distingue una garantía del esquema de una suposición que solo cumple esta muestra. El objetivo es construir una respuesta justificable, no copiar una consulta sin entender su población.

## Continuar el curso

- **Unidad anterior:** [Unidad 04: PostgreSQL y entorno](../unidad04-postgresql/README.md)
- **Volver al índice:** [Todas las unidades](../README.md)
- **Siguiente unidad:** [Unidad 06: INSERT: agregar datos](../unidad06-insert/README.md)

