# Práctica — De tabla plana a 3FN

Tabla inicial:
```text
pedido_id | fecha | cliente_id | cliente_nombre | cliente_correo |
producto_id | producto_nombre | categoria_nombre | cantidad | precio
```

## Anomalías
- cambiar correo obliga a modificar varias filas;
- no puedes registrar fácilmente una categoría sin producto;
- borrar el último pedido puede eliminar información que querías conservar.

## 1FN
Define atributos atómicos según el modelo y elimina grupos repetidos.

## 2FN
En una relación con clave compuesta pedido_id+producto_id, datos que dependen solo de pedido_id o producto_id deben separarse.

## 3FN
Si producto determina categoría y categoría determina nombre_categoria, evita almacenar el nombre de categoría como hecho repetido del producto cuando corresponde modelarlo aparte.

## Resultado
cliente, pedido, producto, categoria, detalle_pedido.

## Reto
Explica qué dependencia funcional justifica cada separación. No normalices solo porque “así se ve mejor”.
