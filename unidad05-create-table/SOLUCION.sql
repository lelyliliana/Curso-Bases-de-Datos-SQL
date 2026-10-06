-- Una solución a la práctica adicional de Unidad 05.
BEGIN;
SET LOCAL search_path = tienda, public;
SET LOCAL TIME ZONE 'UTC';
CREATE TEMP TABLE reserva_lab (id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,inicio date NOT NULL,fin date NOT NULL,CHECK(fin>inicio)); INSERT INTO reserva_lab(inicio,fin) VALUES ('2026-02-01','2026-02-03'); SELECT fin-inicio AS noches FROM reserva_lab;
ROLLBACK;
