CREATE INDEX idx_producto_nombre ON producto(nombre);
CREATE INDEX idx_pedido_cliente ON pedido(cliente_id);

EXPLAIN
SELECT * FROM producto WHERE nombre='Teclado';
