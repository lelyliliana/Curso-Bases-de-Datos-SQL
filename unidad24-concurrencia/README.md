# Unidad 24: Concurrencia y aislamiento

[Volver al índice del curso](../README.md) · [Ver el curso en Aprende con Leli](https://lelyliliana.github.io/aprende-con-leli/cursos/bases-datos-sql/)

## Qué aprenderás
Comprender qué ocurre cuando varias transacciones trabajan al mismo tiempo, observar bloqueos y reconocer el propósito de los niveles de aislamiento.

## Cómo usar los ejemplos de esta unidad

Los ejemplos breves ilustran una idea y pueden usar un conjunto reducido de filas o una tabla independiente. Para ejecutarlos juntos sin conflictos, utiliza el laboratorio y la práctica de esta unidad sobre la [tienda de referencia](../docs/CASO_TIENDA.md). Sus scripts declaran la preparación, resultados y rollback. No vuelvas a crear las tablas de tienda ni repitas su carga para seguir un fragmento ilustrativo.

# 1. Dos usuarios, el mismo dato

Sesión A:
```sql
BEGIN;
UPDATE producto SET precio=150 WHERE id=1;
```

Antes de COMMIT, sesión B intenta:
```sql
UPDATE producto SET precio=160 WHERE id=1;
```

B puede quedar esperando porque A mantiene un lock relevante.

Esto es concurrencia real.

# 2. ¿Por qué necesitamos aislamiento?

Sin coordinación, operaciones simultáneas podrían observar/interferir de formas no deseadas.

Los sistemas definen niveles de aislamiento y mecanismos como MVCC/locks para controlar esas interacciones.

# 3. MVCC en PostgreSQL

PostgreSQL utiliza control de concurrencia multiversión (MVCC): distintas transacciones pueden trabajar con visiones de datos según sus snapshots y nivel de aislamiento.

Esto permite muchas lecturas concurrentes sin bloquearse mutuamente como ocurriría en modelos más simples.

# 4. READ COMMITTED

Es el nivel predeterminado habitual de PostgreSQL. Cada sentencia ve un snapshot apropiado al inicio de esa sentencia.

Dos SELECT dentro de la misma transacción pueden observar datos distintos si otra transacción confirma cambios entre ambos.

# 5. REPEATABLE READ

Mantiene una visión más estable durante la transacción según semántica de PostgreSQL y puede abortar operaciones ante ciertos conflictos de serialización.

# 6. SERIALIZABLE

Busca comportamiento equivalente a alguna ejecución serial válida, pero puede producir errores de serialización que la aplicación debe estar preparada para reintentar.

No significa “todo bloqueado uno detrás de otro”.

# 7. Bloqueo vs error

Una sesión esperando un lock no necesariamente está fallando.

Aprende a distinguir:
- espera;
- deadlock;
- serialization failure;
- constraint error.

# 8. Práctica guiada

Abre dos sesiones.

A:
```sql
BEGIN;
UPDATE producto SET precio=150 WHERE id=1;
```

B:
```sql
UPDATE producto SET precio=160 WHERE id=1;
```

Observa. Luego COMMIT/ROLLBACK en A y mira qué ocurre en B.

# 9. Transacciones largas

Mantener una transacción abierta demasiado tiempo puede:
- retener locks;
- aumentar conflictos;
- afectar mantenimiento/visibilidad de versiones.

Hazlas tan cortas como permita la operación coherente.

# 10. Errores frecuentes
- Confundir espera con caída.
- Pensar que SERIALIZABLE evita necesidad de manejar errores.
- Mantener transacciones abiertas durante interacción humana larga.
- Cambiar aislamiento sin entender el problema.

# 11. Ejercicios
1. Dos updates a la misma fila.
2. Lecturas en dos sesiones.
3. Compara READ COMMITTED y REPEATABLE READ en entorno de práctica.
4. Documenta una espera.

# 12. Reto
Diseña un experimento de dos sesiones y registra línea temporal: sentencia, estado, commit y resultado.

# 13. Autoevaluación
1. ¿Qué problema resuelve aislamiento?
2. ¿Qué es MVCC a nivel conceptual?
3. ¿READ COMMITTED mantiene necesariamente el mismo snapshot para toda la transacción?
4. ¿SERIALIZABLE puede requerir reintentos?
5. ¿Bloqueo y error son lo mismo?

# 14. Checklist
- [ ] Comprendo concurrencia.
- [ ] Puedo observar un lock.
- [ ] Reconozco niveles principales.
- [ ] Evito transacciones innecesariamente largas.

Continúa con índices.


---

## Laboratorio completo y lectura del resultado

**Caso:** ¿Qué lecturas se permiten mientras otra transacción conserva un bloqueo de fila?

MVCC permite que un SELECT normal lea la versión confirmada mientras otra sesión modifica la fila. SELECT FOR UPDATE y UPDATE pueden esperar. La práctica de dos sesiones muestra esa diferencia y utiliza lock_timeout para evitar esperas indefinidas. En PostgreSQL READ UNCOMMITTED se comporta como READ COMMITTED; no hay lecturas sucias.

### Paso a paso

1. Comprueba que estás en la base de práctica y que la [tienda](../docs/CASO_TIENDA.md) conserva sus datos iniciales.
2. Abre [LABORATORIO.sql](LABORATORIO.sql). Lee el script antes de enviarlo al servidor.
3. Predice el resultado de cada sentencia. Anota qué representa una fila y qué operaciones pueden cambiar datos.
4. Desde la raíz, ejecuta:

```text
psql -X -h localhost -U estudiante -d curso_sql -v ON_ERROR_STOP=1 -f unidad24-concurrencia/LABORATORIO.sql
```

La contraseña se solicita en la terminal; no la escribas en el repositorio.

5. Compara con la referencia: **El aislamiento predeterminado es read committed. Esta ejecución toma y libera un bloqueo al hacer rollback.**
6. Termina con la [práctica](PRACTICA.md), luego contrasta tus decisiones con las [soluciones razonadas](SOLUCIONES.md).

### Transferir la idea a otro problema

Reproduce una espera de bloqueo y compara snapshots READ COMMITTED y REPEATABLE READ con dos sesiones.

Explica cómo cambiarían los datos si aparece una fila adicional, una referencia ausente o un empate. Distingue una garantía del esquema de una suposición que solo cumple esta muestra. El objetivo es construir una respuesta justificable, no copiar una consulta sin entender su población.

### Ampliación y experimentos

[Experimentos completos con dos sesiones](DOS_SESIONES.md).

## Continuar el curso

- **Unidad anterior:** [Unidad 23: Transacciones y ACID](../unidad23-transacciones/README.md)
- **Volver al índice:** [Todas las unidades](../README.md)
- **Siguiente unidad:** [Unidad 25: Índices](../unidad25-indices/README.md)

