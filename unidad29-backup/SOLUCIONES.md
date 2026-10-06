# Soluciones razonadas: Unidad 29

Intenta primero [PRACTICA.md](PRACTICA.md). Una consulta puede tener varias soluciones correctas si responde a la misma población, conserva cardinalidad y maneja los mismos límites.

## A. Laboratorio

**Resultado de referencia:** categoria 4, cliente 4, detalle 5, pedido 5, producto 5; cuatro FK.

**Interpretación:** Un SELECT de conteos prepara evidencia, no crea un backup. pg_dump y pg_restore son ejecutables de terminal, no SQL. El formato custom se restaura con pg_restore; un archivo SQL de formato plain se ejecuta con psql. pg_dump respalda una base pero no los roles globales ni toda la configuración del servidor. Restaurar en otra base evita sobrescribir el origen.

El script termina en `ROLLBACK`. Los cambios de tablas u objetos del laboratorio se revierten. Los valores de secuencia consumidos pueden dejar huecos; no uses una lista consecutiva de IDs como prueba de recuperación.

## B. Práctica adicional

**Enunciado:** Realiza el ciclo custom en otra base vacía y compara objetos, valores y un rechazo de FK.

```sql
SELECT SUM(d.cantidad*d.precio_unitario) AS venta_pagada FROM pedido p JOIN detalle_pedido d ON d.pedido_id=p.id WHERE p.estado='PAGADO';
```

**Resultado o evidencia:** 470.00 también en la base restaurada. Sigue RESTAURACION.md para ejecutar las herramientas.

La versión ejecutable está en [SOLUCION.sql](SOLUCION.sql). Identifica en ella la fuente de cada columna y las condiciones que limitan su alcance. Si propones otra forma, compara todas las filas y valores; que produzca el mismo conteo no basta para demostrar equivalencia.

## C. Explicar el límite

Vuelve a la decisión central de esta unidad: Un SELECT de conteos prepara evidencia, no crea un backup. pg_dump y pg_restore son ejecutables de terminal, no SQL. El formato custom se restaura con pg_restore; un archivo SQL de formato plain se ejecuta con psql. pg_dump respalda una base pero no los roles globales ni toda la configuración del servidor. Restaurar en otra base evita sobrescribir el origen.

Registra el dato cambiado, predicción, resultado y conclusión. Un resultado distinto es válido cuando cambió deliberadamente la población; uno inesperado exige revisar la consulta y el supuesto.

[Unidad](README.md) · [Caso y resultados de referencia](../docs/CASO_TIENDA.md)
