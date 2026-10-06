-- Requiere el esquema recién creado por 01_schema.sql.
BEGIN;
SET LOCAL search_path = tienda, public;
INSERT INTO categoria(nombre) VALUES ('Libros'),('Tecnología'),('Hogar'),('Deportes');
INSERT INTO producto(categoria_id,nombre,descripcion,precio,activo) VALUES
 (1,'Algoritmos','Libro de algoritmos',80,true),
 (1,'Bases de datos',NULL,90,true),
 (2,'Teclado','Teclado USB',120,true),
 (2,'Mouse',NULL,90,true),
 (3,'Lámpara','Lámpara de escritorio',50,false);
INSERT INTO cliente(nombre,correo,telefono) VALUES
 ('Ana','ana@example.com','3000000001'),
 ('Luis','luis@example.com',NULL),
 ('Sara','sara@example.com',NULL),
 ('Tomás','tomas@example.com','3000000004');
INSERT INTO pedido(cliente_id,fecha,estado) VALUES
 (1,'2026-01-01 10:00:00+00','PAGADO'),
 (2,'2026-01-02 10:00:00+00','CREADO'),
 (1,'2026-01-03 10:00:00+00','PAGADO'),
 (2,'2026-01-04 10:00:00+00','CREADO'),
 (4,'2026-01-05 10:00:00+00','CANCELADO');
INSERT INTO detalle_pedido(pedido_id,producto_id,cantidad,precio_unitario) VALUES
 (1,1,1,80),(1,3,2,120),(2,2,1,90),(3,1,2,75),(5,4,5,90);
COMMIT;
