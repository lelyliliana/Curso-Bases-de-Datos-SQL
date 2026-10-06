-- Pruebas reproducibles. Los préstamos creados aquí no se conservan.
BEGIN;
DO $$
DECLARE v_id bigint; v_fecha timestamptz; v_antes bigint;
BEGIN
 SELECT COUNT(*) INTO v_antes FROM biblioteca.prestamo;
 v_id:=biblioteca.prestar(1,1,'2026-01-10 10:00+00','2026-01-20 10:00+00');
 IF NOT EXISTS(SELECT 1 FROM biblioteca.prestamo WHERE id=v_id AND devuelto_en IS NULL) THEN RAISE EXCEPTION 'No se creó préstamo'; END IF;
 BEGIN
  PERFORM biblioteca.prestar(2,1,'2026-01-11 10:00+00','2026-01-21 10:00+00');
  RAISE EXCEPTION 'Se permitió doble préstamo';
 EXCEPTION WHEN invalid_parameter_value THEN NULL; END;
 v_fecha:=biblioteca.devolver(v_id,'2026-01-12 10:00+00');
 IF v_fecha<>timestamptz '2026-01-12 10:00+00' THEN RAISE EXCEPTION 'Devolución incorrecta'; END IF;
 PERFORM biblioteca.devolver(v_id,'2026-01-12 10:00+00');
 BEGIN
  PERFORM biblioteca.devolver(v_id,'2026-01-13 10:00+00');
  RAISE EXCEPTION 'Cambió una devolución ya registrada';
 EXCEPTION WHEN invalid_parameter_value THEN NULL; END;
 BEGIN
  PERFORM biblioteca.prestar(1,4,'2026-01-10 10:00+00','2026-01-20 10:00+00');
  RAISE EXCEPTION 'Prestó ejemplar inactivo';
 EXCEPTION WHEN invalid_parameter_value THEN NULL; END;
 BEGIN
  PERFORM biblioteca.prestar(999999,3,'2026-01-10 10:00+00','2026-01-20 10:00+00');
  RAISE EXCEPTION 'Prestó a socio inexistente';
 EXCEPTION WHEN foreign_key_violation THEN NULL; END;
 BEGIN
  PERFORM biblioteca.prestar(1,3,'2026-01-10 10:00+00','2026-01-09 10:00+00');
  RAISE EXCEPTION 'Aceptó fechas invertidas';
 EXCEPTION WHEN invalid_parameter_value THEN NULL; END;
 IF (SELECT COUNT(*) FROM biblioteca.prestamo)<>v_antes+1 THEN RAISE EXCEPTION 'Cantidad incorrecta tras pruebas'; END IF;
 RAISE NOTICE 'Préstamo, devolución, idempotencia y rechazos comprobados';
END $$;
ROLLBACK;
