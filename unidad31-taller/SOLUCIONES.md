# Soluciones razonadas del taller

## Problemas 1–8: consultas

[LABORATORIO.sql](LABORATORIO.sql) contiene las soluciones ejecutables. Referencias:

| Problema | Resultado y decisión |
|---:|---|
| 1 | cuatro productos activos; JOIN obtiene categoría; no aparece Lámpara |
| 2 | Deportes, id 4; NOT EXISTS expresa ausencia |
| 3 | Sara, id 3; no depende de un NULL en una lista externa |
| 4 | pedidos 1..5: 320,90,150,0,450; LEFT JOIN conserva vacío |
| 5 | Ana 470 y los otros cero; se filtra PAGADO antes de sumar |
| 6 | Tecnología, id 2, promedio 105; WHERE filtraría filas, HAVING filtra promedio del grupo |
| 7 | clientes 1,2,4; JOIN requiere DISTINCT porque hay varios pedidos, EXISTS conserva cliente |
| 8 | pedidos 1,3,5 superan 100; el cancelado aparece porque esta pregunta no filtra estado |

No se reemplaza precio histórico por precio actual. No se cuenta una fila de LEFT JOIN como si fuera un producto existente. Un total por cliente no debe multiplicarse al unir simultáneamente varios hechos 1:N: agrega cada población antes de combinarla.

## Problema 9: normalizar

Clave de línea (pedido_id,producto_id) bajo una línea por producto. Dependencias: pedido_id→fecha,cliente_id; cliente_id→nombre,correo; producto_id→nombre,categoria_id; categoria_id→nombre; (pedido_id,producto_id)→cantidad,precio_unitario. Separa CLIENTE, PEDIDO, PRODUCTO, CATEGORIA y DETALLE. Una PK artificial no elimina dependencias parciales de claves alternativas. Precio_unitario pertenece a la línea; el actual a PRODUCTO.

## Problema 10: compras a proveedores

PROVEEDOR(id,nombre), COMPRA(id,proveedor_id,fecha), DETALLE_COMPRA(compra_id,producto_id,cantidad,costo_unitario). Cada compra tiene un proveedor; proveedor puede no tener compras; detalle exige compra y producto. Si un producto tiene varios proveedores, no guardes proveedor_id único en PRODUCTO para representar toda la relación. Una tabla OFERTA(proveedor_id,producto_id,precio,codigo_proveedor) puede registrar las ofertas si el alcance las necesita. Define si se admiten compras vacías y en qué estado.

## Problema 11: FK

Cliente→pedido NO ACTION protege historial; pedido→detalle CASCADE elimina líneas huérfanas cuando se permite borrar el pedido. Producto→detalle NO ACTION conserva referencias históricas. No autoriza borrar pedidos pagados por sí solo. [Unidad 21](../unidad21-integridad/SOLUCIONES.md) demuestra ambas acciones con rollback.

## Problema 12: todo o nada

El laboratorio crea un savepoint, sube dos precios, observa 88/99 y recupera 80/90. [Unidad 23](../unidad23-transacciones/SOLUCIONES.md) explica errores y validaciones. Atomicidad agrupa cambios, pero una operación necesita verificar filas afectadas y reglas; no asumas que UPDATE de un id inexistente lanza error.

## Problema 13: rendimiento

Ejecuta [laboratorio 25](../unidad25-indices/LABORATORIO.sql) y [guía de planes](../unidad26-explain/GUIA_PLAN.md). El filtro cliente=42 selecciona 100 de 100000. Compara filas, nodos, buffers y condiciones de caché. Es aceptable concluir que el motor prefiere Seq Scan para un filtro que devuelve casi toda la tabla; no fuerces un índice para conseguir una captura deseada.

## Problema 14: acceso

[Laboratorio 27](../unidad27-seguridad/LABORATORIO.sql): USAGE de esquema más SELECT de tabla permite leer, no insertar. Se verifica con rol distinto del dueño. [NOTAS.md](../unidad27-seguridad/NOTAS.md) desarrolla objetos futuros y membresía. Los permisos de PUBLIC y otros roles se acumulan.

## Problema 15: CSV

[Laboratorio 28](../unidad28-import-export/LABORATORIO.sql): seis recibidas, dos aceptadas y cuatro rechazadas; dos filas con correo repetido, una sin correo y una sin nombre. Se conserva raw y se rechazan ambas duplicadas. Esa política puede cambiar si existe evidencia de cuál conservar; no escoger arbitrariamente una fila por ordenar ids.

## Problema 16: recuperación

[RESTAURACION.md](../unidad29-backup/RESTAURACION.md) crea un custom dump, restaura en base vacía y comprueba conteos, valores, objetos y FK. Omitir ACL adapta permisos al nuevo dueño; el procedimiento declara que debe reaplicarse y probarse la política de acceso. [Verificación](../docs/VERIFICACION.md) automatiza el ciclo completo en bases temporales propias.

## Criterio antes del proyecto

Puedes explicar cada respuesta, modificar un supuesto y predecir qué cambia. Una salida correcta copiada no demuestra que puedas diseñar, probar y operar tu propia base.

[Unidad](README.md) · [Práctica](PRACTICA.md)
