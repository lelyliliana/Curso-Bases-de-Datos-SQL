BEGIN;
INSERT INTO biblioteca.socio(nombre,correo) VALUES('Ana','ana@biblioteca.example'),('Luis','luis@biblioteca.example'),('Sara','sara@biblioteca.example');
INSERT INTO biblioteca.libro(isbn,titulo) VALUES('9780000000001','Algoritmos'),('9780000000002','Bases de datos'),('9780000000003','Redes');
INSERT INTO biblioteca.ejemplar(libro_id,codigo,activo) VALUES(1,'A-01',true),(1,'A-02',true),(2,'B-01',true),(2,'B-02',false);
INSERT INTO biblioteca.prestamo(socio_id,ejemplar_id,inicio,vence_en,devuelto_en) VALUES
(1,1,'2026-01-01 10:00+00','2026-01-15 10:00+00','2026-01-07 10:00+00'),
(2,2,'2026-01-03 10:00+00','2026-01-20 10:00+00',NULL),
(1,3,'2026-01-05 10:00+00','2026-01-25 10:00+00','2026-01-09 10:00+00');
COMMIT;
