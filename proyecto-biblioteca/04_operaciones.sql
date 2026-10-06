BEGIN;
-- Objetos y referencias plenamente cualificados; pg_temp después de pg_catalog.
CREATE FUNCTION biblioteca.prestar(p_socio bigint,p_ejemplar bigint,p_inicio timestamptz,p_vence timestamptz)
RETURNS bigint LANGUAGE plpgsql SECURITY DEFINER SET search_path=pg_catalog,pg_temp AS $$
DECLARE v_activo boolean; v_id bigint;
BEGIN
 IF p_socio IS NULL OR p_ejemplar IS NULL OR p_inicio IS NULL OR p_vence IS NULL OR p_vence<=p_inicio THEN
  RAISE EXCEPTION 'Socio, ejemplar y fechas válidas son obligatorios' USING ERRCODE='22023';
 END IF;
 SELECT activo INTO v_activo FROM biblioteca.ejemplar WHERE id=p_ejemplar FOR UPDATE;
 IF NOT FOUND THEN RAISE EXCEPTION 'Ejemplar inexistente' USING ERRCODE='22023'; END IF;
 IF NOT v_activo THEN RAISE EXCEPTION 'Ejemplar inactivo' USING ERRCODE='22023'; END IF;
 IF EXISTS(SELECT 1 FROM biblioteca.prestamo WHERE ejemplar_id=p_ejemplar AND (devuelto_en IS NULL OR devuelto_en>p_inicio)) THEN
  RAISE EXCEPTION 'Ejemplar ocupado o inicio anterior al cierre de su historial' USING ERRCODE='22023';
 END IF;
 INSERT INTO biblioteca.prestamo(socio_id,ejemplar_id,inicio,vence_en)
 VALUES(p_socio,p_ejemplar,p_inicio,p_vence) RETURNING id INTO v_id;
 RETURN v_id;
END $$;
CREATE FUNCTION biblioteca.devolver(p_prestamo bigint,p_fecha timestamptz)
RETURNS timestamptz LANGUAGE plpgsql SECURITY DEFINER SET search_path=pg_catalog,pg_temp AS $$
DECLARE v_ejemplar bigint; v_inicio timestamptz; v_devuelto timestamptz;
BEGIN
 IF p_prestamo IS NULL OR p_fecha IS NULL THEN RAISE EXCEPTION 'Préstamo y fecha obligatorios' USING ERRCODE='22023'; END IF;
 SELECT ejemplar_id INTO v_ejemplar FROM biblioteca.prestamo WHERE id=p_prestamo;
 IF NOT FOUND THEN RAISE EXCEPTION 'Préstamo inexistente' USING ERRCODE='22023'; END IF;
 -- Mismo primer bloqueo que prestar: ejemplar, luego préstamo.
 PERFORM id FROM biblioteca.ejemplar WHERE id=v_ejemplar FOR UPDATE;
 SELECT inicio,devuelto_en INTO v_inicio,v_devuelto FROM biblioteca.prestamo WHERE id=p_prestamo FOR UPDATE;
 IF p_fecha<v_inicio THEN RAISE EXCEPTION 'La devolución precede al préstamo' USING ERRCODE='22023'; END IF;
 IF v_devuelto IS NOT NULL THEN
  IF v_devuelto=p_fecha THEN RETURN v_devuelto; END IF;
  RAISE EXCEPTION 'Ya devuelto con otra fecha' USING ERRCODE='22023';
 END IF;
 UPDATE biblioteca.prestamo SET devuelto_en=p_fecha WHERE id=p_prestamo;
 RETURN p_fecha;
END $$;
CREATE VIEW biblioteca.prestamos_abiertos AS
SELECT p.id AS prestamo_id,e.codigo,l.titulo,s.nombre AS socio,p.inicio,p.vence_en
FROM biblioteca.prestamo p JOIN biblioteca.ejemplar e ON e.id=p.ejemplar_id
JOIN biblioteca.libro l ON l.id=e.libro_id JOIN biblioteca.socio s ON s.id=p.socio_id
WHERE p.devuelto_en IS NULL;
REVOKE ALL ON FUNCTION biblioteca.prestar(bigint,bigint,timestamptz,timestamptz) FROM PUBLIC;
REVOKE ALL ON FUNCTION biblioteca.devolver(bigint,timestamptz) FROM PUBLIC;
REVOKE CREATE ON SCHEMA biblioteca FROM PUBLIC;
COMMIT;
