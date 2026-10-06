# Soluciones razonadas: Unidad 23

Intenta primero [PRACTICA.md](PRACTICA.md). Una consulta puede tener varias soluciones correctas si responde a la misma población, conserva cardinalidad y maneja los mismos límites.

## A. Laboratorio

**Resultado de referencia:** Inicial 80; después de recuperar el savepoint queda 85 dentro de la transacción; tras rollback final vuelve a 80.

**Interpretación:** ROLLBACK TO no finaliza la transacción; elimina cambios posteriores al punto. Un error de sentencia suele dejarla abortada hasta rollback, salvo manejo explícito. ACID no valida reglas que nunca se modelaron, y atomicidad no verifica por sí sola que UPDATE haya afectado una fila. Las secuencias y efectos externos de funciones no son necesariamente reversibles.

El script termina en `ROLLBACK`. Los cambios de tablas u objetos del laboratorio se revierten. Los valores de secuencia consumidos pueden dejar huecos; no uses una lista consecutiva de IDs como prueba de recuperación.

## B. Práctica adicional

**Enunciado:** Diseña una transferencia de dos cuentas temporales. Bloquea y valida existencia y saldo; demuestra que la suma se conserva al confirmar y al revertir.

```sql
CREATE TEMP TABLE cuenta_lab(id integer PRIMARY KEY,saldo numeric(12,2) NOT NULL CHECK(saldo>=0));
INSERT INTO cuenta_lab VALUES(1,200),(2,50);
SELECT id FROM cuenta_lab WHERE id IN(1,2) ORDER BY id FOR UPDATE;
DO $$ DECLARE afectadas integer; BEGIN
 IF (SELECT COUNT(*) FROM cuenta_lab WHERE id IN(1,2))<>2 THEN RAISE EXCEPTION 'Cuenta ausente'; END IF;
 UPDATE cuenta_lab SET saldo=saldo-100 WHERE id=1 AND saldo>=100;
 GET DIAGNOSTICS afectadas=ROW_COUNT;
 IF afectadas<>1 THEN RAISE EXCEPTION 'Saldo insuficiente'; END IF;
 UPDATE cuenta_lab SET saldo=saldo+100 WHERE id=2;
END $$;
SELECT id,saldo FROM cuenta_lab ORDER BY id;
SELECT SUM(saldo) AS total FROM cuenta_lab;
```

**Resultado o evidencia:** 100 y 150, total 250. El ejemplo temporal es de una sesión; SOLUCIONES.md explica las validaciones para concurrencia.

La versión ejecutable está en [SOLUCION.sql](SOLUCION.sql). Identifica en ella la fuente de cada columna y las condiciones que limitan su alcance. Si propones otra forma, compara todas las filas y valores; que produzca el mismo conteo no basta para demostrar equivalencia.

## C. Explicar el límite

Vuelve a la decisión central de esta unidad: ROLLBACK TO no finaliza la transacción; elimina cambios posteriores al punto. Un error de sentencia suele dejarla abortada hasta rollback, salvo manejo explícito. ACID no valida reglas que nunca se modelaron, y atomicidad no verifica por sí sola que UPDATE haya afectado una fila. Las secuencias y efectos externos de funciones no son necesariamente reversibles.

Registra el dato cambiado, predicción, resultado y conclusión. Un resultado distinto es válido cuando cambió deliberadamente la población; uno inesperado exige revisar la consulta y el supuesto.

[Unidad](README.md) · [Caso y resultados de referencia](../docs/CASO_TIENDA.md)

## Transferencia y filas afectadas

La versión temporal muestra la aritmética con ambas cuentas presentes. Para dinero real, valida cuentas distintas, moneda, importe positivo, existencia de ambos destinos y saldo suficiente; bloquea las dos filas en un orden estable (por id), verifica que se actualizaron exactamente las filas esperadas y confirma ambas en una sola transacción. Un UPDATE que afecta cero filas no falla automáticamente. La cuenta receptora ausente podría dejar un débito sin abono si no se detecta ese caso.

El bloqueo impide decisiones sobre saldos que otra sesión modifica entre lectura y actualización. Ante 40001 o deadlock se revierte y reintenta la transacción completa con un límite y nueva lectura. No conviertas el ejemplo de una sesión en una garantía de transferencias concurrentes sin esas validaciones.
