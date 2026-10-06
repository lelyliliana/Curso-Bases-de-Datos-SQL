-- Una solución a la práctica adicional de Unidad 06.
BEGIN;
SET LOCAL search_path = tienda, public;
SET LOCAL TIME ZONE 'UTC';
INSERT INTO cliente(nombre,correo) VALUES ('Nora','nora.lab@example.com') RETURNING nombre,correo,telefono;
ROLLBACK;
