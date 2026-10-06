-- El índice único parcial ya protege el préstamo abierto.
CREATE INDEX prestamo_socio_inicio_idx ON biblioteca.prestamo(socio_id,inicio DESC,id);
CREATE INDEX ejemplar_libro_idx ON biblioteca.ejemplar(libro_id);
ANALYZE biblioteca.prestamo;
EXPLAIN (ANALYZE,BUFFERS) SELECT id,inicio FROM biblioteca.prestamo WHERE socio_id=1 ORDER BY inicio DESC,id;
