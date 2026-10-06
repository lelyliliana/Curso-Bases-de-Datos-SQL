# Soluciones razonadas: Unidad 19

Intenta primero [PRACTICA.md](PRACTICA.md). Una consulta puede tener varias soluciones correctas si responde a la misma población, conserva cardinalidad y maneja los mismos límites.

## A. Laboratorio

**Resultado de referencia:** Cliente 7 tiene dos correos distintos para una regla de correo actual único por cliente.

**Interpretación:** La dependencia cliente→correo proviene del dominio. Los datos pueden refutarla, pero una muestra sin contradicciones no la demuestra. Un correo histórico por venta sería otro atributo y otra regla; no normalices hasta distinguirlo. Las anomalías de actualización, inserción y borrado nacen de mezclar hechos con dependencias diferentes.

El script termina en `ROLLBACK`. Los cambios de tablas u objetos del laboratorio se revierten. Los valores de secuencia consumidos pueden dejar huecos; no uses una lista consecutiva de IDs como prueba de recuperación.

## B. Práctica adicional

**Enunciado:** Escribe las dependencias de pedido, producto y detalle. Decide dónde guardar precio vendido y precio actual.

```sql
SELECT d.pedido_id,d.producto_id,d.precio_unitario AS historico,p.precio AS actual FROM detalle_pedido d JOIN producto p ON p.id=d.producto_id WHERE d.precio_unitario<>p.precio ORDER BY d.pedido_id,d.producto_id;
```

**Resultado o evidencia:** Pedido 3, producto 1: histórico 75 y actual 80. Ambos son correctos y representan hechos distintos.

La versión ejecutable está en [SOLUCION.sql](SOLUCION.sql). Identifica en ella la fuente de cada columna y las condiciones que limitan su alcance. Si propones otra forma, compara todas las filas y valores; que produzca el mismo conteo no basta para demostrar equivalencia.

## C. Explicar el límite

Vuelve a la decisión central de esta unidad: La dependencia cliente→correo proviene del dominio. Los datos pueden refutarla, pero una muestra sin contradicciones no la demuestra. Un correo histórico por venta sería otro atributo y otra regla; no normalices hasta distinguirlo. Las anomalías de actualización, inserción y borrado nacen de mezclar hechos con dependencias diferentes.

Registra el dato cambiado, predicción, resultado y conclusión. Un resultado distinto es válido cuando cambió deliberadamente la población; uno inesperado exige revisar la consulta y el supuesto.

[Unidad](README.md) · [Caso y resultados de referencia](../docs/CASO_TIENDA.md)
