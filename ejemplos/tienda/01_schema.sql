-- Ejecutar una sola vez en una base de práctica vacía.
BEGIN;
CREATE SCHEMA tienda;
SET LOCAL search_path = tienda, public;
CREATE TABLE categoria (
 id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
 nombre text NOT NULL UNIQUE CHECK (btrim(nombre) <> '')
);
CREATE TABLE producto (
 id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
 categoria_id bigint NOT NULL REFERENCES categoria(id),
 nombre text NOT NULL CHECK (btrim(nombre) <> ''),
 descripcion text,
 precio numeric(12,2) NOT NULL CHECK (precio > 0 AND precio <> 'NaN'::numeric),
 activo boolean NOT NULL DEFAULT true
);
CREATE TABLE cliente (
 id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
 nombre text NOT NULL CHECK (btrim(nombre) <> ''),
 correo text NOT NULL UNIQUE CHECK (btrim(correo) <> ''),
 telefono text
);
CREATE TABLE pedido (
 id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
 cliente_id bigint NOT NULL REFERENCES cliente(id),
 fecha timestamptz NOT NULL DEFAULT CURRENT_TIMESTAMP,
 estado text NOT NULL CHECK (estado IN ('CREADO','PAGADO','CANCELADO'))
);
CREATE TABLE detalle_pedido (
 pedido_id bigint NOT NULL REFERENCES pedido(id) ON DELETE CASCADE,
 producto_id bigint NOT NULL REFERENCES producto(id),
 cantidad integer NOT NULL CHECK (cantidad > 0),
 precio_unitario numeric(12,2) NOT NULL CHECK (precio_unitario > 0 AND precio_unitario <> 'NaN'::numeric),
 PRIMARY KEY (pedido_id, producto_id)
);
COMMIT;
