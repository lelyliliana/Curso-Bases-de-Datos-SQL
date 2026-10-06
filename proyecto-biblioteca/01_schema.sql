BEGIN;
CREATE SCHEMA biblioteca;
SET LOCAL search_path=pg_catalog,biblioteca;
CREATE TABLE biblioteca.socio(
 id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
 nombre text NOT NULL CHECK(btrim(nombre)<>''),
 correo text NOT NULL UNIQUE CHECK(btrim(correo)<>'')
);
CREATE TABLE biblioteca.libro(
 id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
 isbn text NOT NULL UNIQUE CHECK(btrim(isbn)<>''),
 titulo text NOT NULL CHECK(btrim(titulo)<>'')
);
CREATE TABLE biblioteca.ejemplar(
 id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
 libro_id bigint NOT NULL REFERENCES biblioteca.libro(id),
 codigo text NOT NULL UNIQUE CHECK(btrim(codigo)<>''),
 activo boolean NOT NULL DEFAULT true
);
CREATE TABLE biblioteca.prestamo(
 id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
 socio_id bigint NOT NULL REFERENCES biblioteca.socio(id),
 ejemplar_id bigint NOT NULL REFERENCES biblioteca.ejemplar(id),
 inicio timestamptz NOT NULL,
 vence_en timestamptz NOT NULL,
 devuelto_en timestamptz,
 CHECK(vence_en>inicio),
 CHECK(devuelto_en IS NULL OR devuelto_en>=inicio)
);
CREATE UNIQUE INDEX prestamo_abierto_unico ON biblioteca.prestamo(ejemplar_id) WHERE devuelto_en IS NULL;
COMMIT;
