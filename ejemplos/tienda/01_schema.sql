CREATE TABLE categoria (
 id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
 nombre text NOT NULL UNIQUE
);
CREATE TABLE producto (
 id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
 categoria_id bigint NOT NULL REFERENCES categoria(id),
 nombre text NOT NULL,
 precio numeric(12,2) NOT NULL CHECK (precio > 0),
 activo boolean NOT NULL DEFAULT true
);
CREATE TABLE cliente (
 id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
 nombre text NOT NULL,
 correo text NOT NULL UNIQUE
);
CREATE TABLE pedido (
 id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
 cliente_id bigint NOT NULL REFERENCES cliente(id),
 fecha timestamptz NOT NULL DEFAULT now(),
 estado text NOT NULL CHECK (estado IN ('CREADO','PAGADO','CANCELADO'))
);
CREATE TABLE detalle_pedido (
 pedido_id bigint NOT NULL REFERENCES pedido(id) ON DELETE CASCADE,
 producto_id bigint NOT NULL REFERENCES producto(id),
 cantidad integer NOT NULL CHECK (cantidad > 0),
 precio_unitario numeric(12,2) NOT NULL CHECK (precio_unitario > 0),
 PRIMARY KEY (pedido_id, producto_id)
);
