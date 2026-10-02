-- Ejecuta en una base de práctica.
BEGIN;

UPDATE producto
SET precio = precio * 1.10
WHERE categoria_id = 1;

-- Comprueba dentro de la transacción.
SELECT id,nombre,precio FROM producto WHERE categoria_id=1;

-- Para esta práctica:
ROLLBACK;

-- Verifica que los precios regresaron.
SELECT id,nombre,precio FROM producto WHERE categoria_id=1;
