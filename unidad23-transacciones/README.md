# Unidad 23: Transacciones y ACID

[Volver al índice del curso](../README.md) · [Ver el curso en Aprende con Leli](https://lelyliliana.github.io/aprende-con-leli/cursos/bases-datos-sql/)

## Qué aprenderás
Agrupar operaciones como una unidad, usar COMMIT/ROLLBACK y comprender las propiedades ACID a través de situaciones concretas.

## Cómo usar los ejemplos de esta unidad

Los ejemplos breves ilustran una idea y pueden usar un conjunto reducido de filas o una tabla independiente. Para ejecutarlos juntos sin conflictos, utiliza el laboratorio y la práctica de esta unidad sobre la [tienda de referencia](../docs/CASO_TIENDA.md). Sus scripts declaran la preparación, resultados y rollback. No vuelvas a crear las tablas de tienda ni repitas su carga para seguir un fragmento ilustrativo.

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
-- Caso ficticio autocontenido, una moneda y dos cuentas.
CREATE TEMP TABLE cuenta (
 id integer PRIMARY KEY,
 saldo numeric(12,2) NOT NULL CHECK(saldo>=0 AND saldo<>'NaN'::numeric)
);
INSERT INTO cuenta VALUES(1,200),(2,50);
BEGIN;
-- Orden de bloqueo compartido por todas las transferencias de este modelo.
SELECT id,saldo FROM cuenta WHERE id IN(1,2) ORDER BY id FOR UPDATE;
DO $$
DECLARE afectadas integer;
BEGIN
 IF (SELECT COUNT(*) FROM cuenta WHERE id IN(1,2))<>2 THEN
  RAISE EXCEPTION 'Deben existir ambas cuentas';
 END IF;
 UPDATE cuenta SET saldo=saldo-100 WHERE id=1 AND saldo>=100;
 GET DIAGNOSTICS afectadas=ROW_COUNT;
 IF afectadas<>1 THEN RAISE EXCEPTION 'Saldo insuficiente'; END IF;
 UPDATE cuenta SET saldo=saldo+100 WHERE id=2;
END $$;
COMMIT;
SELECT id,saldo FROM cuenta ORDER BY id;
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


---

## Laboratorio completo y lectura del resultado

**Caso:** ¿Cómo recuperar una parte fallida sin confirmar una operación incompleta?

ROLLBACK TO no finaliza la transacción; elimina cambios posteriores al punto. Un error de sentencia suele dejarla abortada hasta rollback, salvo manejo explícito. ACID no valida reglas que nunca se modelaron, y atomicidad no verifica por sí sola que UPDATE haya afectado una fila. Las secuencias y efectos externos de funciones no son necesariamente reversibles.

### Paso a paso

1. Comprueba que estás en la base de práctica y que la [tienda](../docs/CASO_TIENDA.md) conserva sus datos iniciales.
2. Abre [LABORATORIO.sql](LABORATORIO.sql). Lee el script antes de enviarlo al servidor.
3. Predice el resultado de cada sentencia. Anota qué representa una fila y qué operaciones pueden cambiar datos.
4. Desde la raíz, ejecuta:

```text
psql -X -h localhost -U estudiante -d curso_sql -v ON_ERROR_STOP=1 -f unidad23-transacciones/LABORATORIO.sql
```

La contraseña se solicita en la terminal; no la escribas en el repositorio.

5. Compara con la referencia: **Inicial 80; después de recuperar el savepoint queda 85 dentro de la transacción; tras rollback final vuelve a 80.**
6. Termina con la [práctica](PRACTICA.md), luego contrasta tus decisiones con las [soluciones razonadas](SOLUCIONES.md).

### Transferir la idea a otro problema

Diseña una transferencia de dos cuentas temporales. Bloquea y valida existencia y saldo; demuestra que la suma se conserva al confirmar y al revertir.

Explica cómo cambiarían los datos si aparece una fila adicional, una referencia ausente o un empate. Distingue una garantía del esquema de una suposición que solo cumple esta muestra. El objetivo es construir una respuesta justificable, no copiar una consulta sin entender su población.

## Continuar el curso

- **Unidad anterior:** [Unidad 22: Vistas](../unidad22-vistas/README.md)
- **Volver al índice:** [Todas las unidades](../README.md)
- **Siguiente unidad:** [Unidad 24: Concurrencia y aislamiento](../unidad24-concurrencia/README.md)

