# Dos sesiones: bloqueos y snapshots

Abre dos ventanas de psql conectadas a **la misma base de práctica**. En ambas ejecuta `SET search_path=tienda,public;`. A y B son conexiones diferentes; dos pestañas de un editor pueden reutilizar una conexión, verifica sus PID con `SELECT pg_backend_pid();`.

## Preparar una tabla aislada

En A, sin una transacción abierta:

```sql
CREATE TABLE tienda.concurrencia_demo(id integer PRIMARY KEY,valor integer NOT NULL);
INSERT INTO tienda.concurrencia_demo VALUES(1,80);
```

Si ya existe, revisa que sea la tabla de este ejercicio antes de reutilizarla. No experimentes con productos de una tienda real.

## Experimento 1: lectura normal y espera de escritura

Ejecuta en el orden de la tabla:

| Paso | A | B | Qué observar |
|---:|---|---|---|
| 1 | `BEGIN;` | | A inicia |
| 2 | `UPDATE tienda.concurrencia_demo SET valor=81 WHERE id=1;` | | A conserva el bloqueo |
| 3 | | `SELECT valor FROM tienda.concurrencia_demo WHERE id=1;` | B lee 80 confirmado, no 81 sin confirmar |
| 4 | | `BEGIN; SET LOCAL lock_timeout='500ms';` | límite de espera local a la transacción |
| 5 | | `UPDATE tienda.concurrencia_demo SET valor=82 WHERE id=1;` | B espera y falla con 55P03 al superar el límite |
| 6 | | `ROLLBACK;` | B sale del estado abortado |
| 7 | `ROLLBACK;` | | A descarta 81 y libera bloqueo |
| 8 | | `SELECT valor FROM tienda.concurrencia_demo WHERE id=1;` | permanece 80 |

Sin lock_timeout, B esperaría hasta que A termine. No cierres una ventana sin comprender qué transacción queda abierta. Un SELECT normal usa MVCC; SELECT FOR UPDATE solicita un bloqueo y también puede esperar.

## Experimento 2: READ COMMITTED

1. A: `BEGIN ISOLATION LEVEL READ COMMITTED;`
2. A: `SELECT valor FROM tienda.concurrencia_demo WHERE id=1;` (80).
3. B, en autocommit: `UPDATE tienda.concurrencia_demo SET valor=81 WHERE id=1;`.
4. A repite SELECT (81). Cada sentencia adquiere un snapshot nuevo.
5. A: `ROLLBACK;`.
6. B restablece 80 con UPDATE fuera de una transacción abierta.

## Experimento 3: REPEATABLE READ

1. A: `BEGIN ISOLATION LEVEL REPEATABLE READ;` y SELECT (80). El snapshot se establece con la primera operación relevante, no solo por escribir BEGIN.
2. B, en autocommit: actualiza a 82.
3. A repite SELECT: sigue viendo 80.
4. A intenta UPDATE de esa fila: puede fallar con **40001**, porque se modificó desde su snapshot. En este experimento el conflicto está preparado explícitamente.
5. A: ROLLBACK. Una nueva transacción puede ver 82. B restablece 80 para repetir.

PostgreSQL REPEATABLE READ evita también lecturas fantasma bajo su implementación, pero puede permitir anomalías de serialización como write skew. No confundir la tabla de mínimos del estándar con todas las garantías concretas de PostgreSQL.

## Experimento 4: SERIALIZABLE y una regla entre filas

Prepara en A, en autocommit:

```sql
CREATE TABLE tienda.turno_demo(id integer PRIMARY KEY,disponible boolean NOT NULL);
INSERT INTO tienda.turno_demo VALUES(1,true),(2,true);
```

Regla: siempre debe permanecer al menos una persona disponible. Este ejemplo muestra una regla que un CHECK por fila no protege.

1. A y B: `BEGIN ISOLATION LEVEL SERIALIZABLE;`.
2. Ambas leen `SELECT COUNT(*) FROM tienda.turno_demo WHERE disponible;` antes de escribir: ven 2.
3. A: `UPDATE tienda.turno_demo SET disponible=false WHERE id=1;`.
4. B: `UPDATE tienda.turno_demo SET disponible=false WHERE id=2;`.
5. A: COMMIT; después B: COMMIT. Una transacción debe abortarse por conflicto de serialización (puede detectarse antes del commit según el orden).
6. Comprueba que permanece una disponible. La operación abortada debe iniciar una **nueva transacción completa**, releer y decidir si sigue siendo válida; no basta con repetir el COMMIT.

Repite con REPEATABLE READ: ambas pueden confirmar y dejar cero disponibles, aunque cada lectura individual fue coherente con su snapshot. Luego restaura los datos de práctica.

## Deadlock y reintentos

Si A bloquea fila 1 y necesita 2 mientras B bloquea 2 y necesita 1, hay un ciclo. PostgreSQL detecta y aborta una participante con **40P01**. Adquiere bloqueos en un orden consistente, mantén transacciones breves y utiliza reintentos limitados para errores recuperables. Un 23505 de unicidad no se arregla repitiendo indefinidamente la misma entrada.

## Cerrar el ejercicio

Termina todas las transacciones. En la base de práctica elimina únicamente estas tablas de demostración cuando ya no las necesites:

```sql
DROP TABLE tienda.turno_demo;
DROP TABLE tienda.concurrencia_demo;
```

Entrega tabla temporal de acciones, valores observados y SQLSTATE. El [verificador](../docs/VERIFICACION.md) reproduce bloqueos, ambos snapshots y write skew con conexiones reales y comprueba resultados.

[Unidad](README.md) · [Práctica](PRACTICA.md)
