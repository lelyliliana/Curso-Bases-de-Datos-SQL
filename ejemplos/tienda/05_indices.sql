-- Las PK y UNIQUE ya tienen índices. Las FK del lado hijo no los crean.
CREATE INDEX pedido_cliente_fecha_idx ON tienda.pedido(cliente_id,fecha DESC,id);
CREATE INDEX producto_categoria_idx ON tienda.producto(categoria_id);
-- La PK de detalle empieza por pedido_id; este índice cubre búsquedas por producto.
CREATE INDEX detalle_producto_idx ON tienda.detalle_pedido(producto_id);
