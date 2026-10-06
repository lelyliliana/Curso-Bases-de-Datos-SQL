# Soluciones razonadas: Unidad 04

Intenta primero [PRACTICA.md](PRACTICA.md). Una consulta puede tener varias soluciones correctas si responde a la misma población, conserva cardinalidad y maneja los mismos límites.

## A. Laboratorio

**Resultado de referencia:** La base es la elegida en la conexión. Aparecen categoria, cliente, detalle_pedido, pedido y producto (cinco tablas).

**Interpretación:** El servidor ejecuta SQL, psql lo envía y muestra la respuesta. Cambiar de carpeta no cambia de base. El esquema organiza objetos dentro de una base. No confundas la versión del cliente con la del servidor.

El script termina en `ROLLBACK`. Los cambios de tablas u objetos del laboratorio se revierten. Los valores de secuencia consumidos pueden dejar huecos; no uses una lista consecutiva de IDs como prueba de recuperación.

## B. Práctica adicional

**Enunciado:** Lista las columnas y tipos de tienda.producto en su orden de definición.

```sql
SELECT column_name,data_type FROM information_schema.columns WHERE table_schema='tienda' AND table_name='producto' ORDER BY ordinal_position;
```

**Resultado o evidencia:** id bigint; categoria_id bigint; nombre text; descripcion text; precio numeric; activo boolean.

La versión ejecutable está en [SOLUCION.sql](SOLUCION.sql). Identifica en ella la fuente de cada columna y las condiciones que limitan su alcance. Si propones otra forma, compara todas las filas y valores; que produzca el mismo conteo no basta para demostrar equivalencia.

## C. Explicar el límite

Vuelve a la decisión central de esta unidad: El servidor ejecuta SQL, psql lo envía y muestra la respuesta. Cambiar de carpeta no cambia de base. El esquema organiza objetos dentro de una base. No confundas la versión del cliente con la del servidor.

Registra el dato cambiado, predicción, resultado y conclusión. Un resultado distinto es válido cuando cambió deliberadamente la población; uno inesperado exige revisar la consulta y el supuesto.

[Unidad](README.md) · [Caso y resultados de referencia](../docs/CASO_TIENDA.md)
