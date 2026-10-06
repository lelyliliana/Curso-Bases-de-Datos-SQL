-- Una solución a la práctica adicional de Unidad 23.
BEGIN;
SET LOCAL search_path = tienda, public;
SET LOCAL TIME ZONE 'UTC';
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
ROLLBACK;
