# Unidad 05 — CREATE TABLE y tipos de datos

## Qué aprenderás
Crear tablas, elegir tipos y proteger reglas con restricciones.

## Antes de empezar
Debes comprender entidades, claves y poder conectarte a PostgreSQL.

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
