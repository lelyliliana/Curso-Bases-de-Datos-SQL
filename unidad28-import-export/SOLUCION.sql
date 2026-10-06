-- Una solución a la práctica adicional de Unidad 28.
BEGIN;
SET LOCAL search_path = tienda, public;
SET LOCAL TIME ZONE 'UTC';
CREATE TEMP TABLE exportar_lab(nombre text,correo text);
INSERT INTO exportar_lab VALUES ('Ana','ana@example.com'),('Luis','luis@example.com');
-- En psql, reemplaza la ruta por una carpeta existente de tu elección:
-- \copy exportar_lab TO 'clientes_aceptados.csv' WITH (FORMAT csv,HEADER true,ENCODING 'UTF8')
SELECT COUNT(*) FROM exportar_lab;
ROLLBACK;
