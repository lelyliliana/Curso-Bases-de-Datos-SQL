# Unidad 24 — Concurrencia y aislamiento

## Qué aprenderás
Comprender qué ocurre cuando varias transacciones trabajan al mismo tiempo, observar bloqueos y reconocer el propósito de los niveles de aislamiento.

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
