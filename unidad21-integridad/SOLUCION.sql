-- Una solución a la práctica adicional de Unidad 21.
BEGIN;
SET LOCAL search_path = tienda, public;
SET LOCAL TIME ZONE 'UTC';
DO $$ BEGIN BEGIN INSERT INTO pedido(cliente_id,estado) VALUES (999999,'CREADO'); RAISE EXCEPTION 'Faltó validar FK'; EXCEPTION WHEN foreign_key_violation THEN RAISE NOTICE '23503 esperado'; END; END $$;
ROLLBACK;
