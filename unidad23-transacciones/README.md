# Unidad 23 — Transacciones y ACID

## Qué aprenderás
Agrupar operaciones como una unidad, usar COMMIT/ROLLBACK y comprender las propiedades ACID a través de situaciones concretas.

# 1. Problema: operación parcial

Transferir 100:
```text
Cuenta A: -100
Cuenta B: +100
```

¿Qué ocurre si la primera actualización funciona y la segunda falla?

Necesitamos que ambas formen una unidad.

# 2. BEGIN, COMMIT, ROLLBACK

```sql
BEGIN;

UPDATE cuenta SET saldo=saldo-100 WHERE id=1;
UPDATE cuenta SET saldo=saldo+100 WHERE id=2;

COMMIT;
```

Si detectamos un problema antes del commit:
```sql
ROLLBACK;
```

# 3. Atomicidad

La unidad completa ocurre o se revierte.

No significa que cada sentencia sea “atómica” en cualquier sentido imaginable; aquí hablamos de la propiedad de la transacción.

# 4. Consistencia

La transacción lleva la base de un estado válido a otro respetando reglas definidas.

La base no conoce automáticamente todas las reglas del negocio: debes modelarlas.

# 5. Aislamiento

Transacciones concurrentes deben interactuar bajo reglas controladas. Lo profundizaremos en la siguiente unidad.

# 6. Durabilidad

Tras un commit exitoso, el sistema está diseñado para preservar el resultado conforme a sus garantías de durabilidad/configuración.

# 7. Práctica guiada

Usa PRODUCTO:

```sql
BEGIN;
UPDATE producto SET precio=precio*1.10 WHERE categoria_id=1;
SELECT id,nombre,precio FROM producto WHERE categoria_id=1;
ROLLBACK;
SELECT id,nombre,precio FROM producto WHERE categoria_id=1;
```

Observa dentro y después.

# 8. Error dentro de una transacción

En PostgreSQL, ciertos errores dejan la transacción en estado abortado hasta ROLLBACK (o manejo mediante savepoints).

Aprende a leer:
```text
current transaction is aborted
```

No sigas enviando sentencias esperando que “se arregle”.

# 9. SAVEPOINT

Permite puntos parciales:
```sql
SAVEPOINT paso1;
...
ROLLBACK TO SAVEPOINT paso1;
```

Útil en flujos que justifican recuperación parcial.

# 10. Errores frecuentes
- Mantener transacciones abiertas mientras el usuario se va a almorzar.
- Creer que BEGIN hace segura cualquier lógica.
- Olvidar COMMIT/ROLLBACK.
- Mezclar interacción lenta externa dentro de transacciones sin analizar locks.

# 11. Ejercicios
- UPDATE + rollback;
- pedido + detalles;
- provoca constraint violation;
- utiliza savepoint;
- verifica antes/después.

# 12. Reto
Diseña una operación de tres sentencias que deba ser todo-o-nada y explica qué inconsistencia aparecería si queda parcial.

# 13. Autoevaluación
1. ¿Qué hace COMMIT?
2. ¿ROLLBACK?
3. ¿Qué significa atomicidad?
4. ¿Qué ocurre tras ciertos errores en PostgreSQL?
5. ¿Para qué sirve SAVEPOINT?

# 14. Checklist
- [ ] Uso BEGIN/COMMIT/ROLLBACK.
- [ ] Comprendo ACID conceptualmente.
- [ ] Reconozco transacción abortada.
- [ ] Sé cuándo una operación debe agruparse.

Continúa con concurrencia.
