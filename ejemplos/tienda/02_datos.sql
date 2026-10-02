INSERT INTO categoria(nombre) VALUES ('Libros'),('Tecnología');
INSERT INTO producto(categoria_id,nombre,precio) VALUES
(1,'Algoritmos',80.00),(1,'Bases de datos',90.00),(2,'Teclado',120.00);
INSERT INTO cliente(nombre,correo) VALUES ('Ana','ana@example.com'),('Luis','luis@example.com');
INSERT INTO pedido(cliente_id,estado) VALUES (1,'PAGADO'),(2,'CREADO');
INSERT INTO detalle_pedido VALUES (1,1,1,80.00),(1,3,2,120.00),(2,2,1,90.00);
