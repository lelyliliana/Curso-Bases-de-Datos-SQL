# Soluciones razonadas: Unidad 22

Intenta primero [PRACTICA.md](PRACTICA.md). Una consulta puede tener varias soluciones correctas si responde a la misma población, conserva cardinalidad y maneja los mismos límites.

## A. Laboratorio

**Resultado de referencia:** Vista inicial 320,90,150,0,450. Tras primera actualización: 400. Materializada conserva 400 tras otra actualización, luego REFRESH muestra 480.

**Interpretación:** La vista normal conserva la definición; la materializada almacena resultado y puede quedar desactualizada. Este reporte agrupado no es automáticamente actualizable. Una vista no ordena todas las consultas consumidoras: agrega ORDER BY al leer. Para seguridad hay que revisar permisos y semántica del propietario, no solo ocultar columnas visualmente.

El script termina en `ROLLBACK`. Los cambios de tablas u objetos del laboratorio se revierten. Los valores de secuencia consumidos pueden dejar huecos; no uses una lista consecutiva de IDs como prueba de recuperación.

## B. Práctica adicional

**Enunciado:** Crea una vista de catálogo activo que exponga id, nombre y precio, pero no datos de clientes.

```sql
CREATE VIEW tienda.catalogo_lab AS SELECT id,nombre,precio FROM tienda.producto WHERE activo; SELECT id,nombre,precio FROM tienda.catalogo_lab ORDER BY id;
```

**Resultado o evidencia:** Cuatro filas, ids 1,2,3,4. La vista desaparece al revertir el laboratorio.

La versión ejecutable está en [SOLUCION.sql](SOLUCION.sql). Identifica en ella la fuente de cada columna y las condiciones que limitan su alcance. Si propones otra forma, compara todas las filas y valores; que produzca el mismo conteo no basta para demostrar equivalencia.

## C. Explicar el límite

Vuelve a la decisión central de esta unidad: La vista normal conserva la definición; la materializada almacena resultado y puede quedar desactualizada. Este reporte agrupado no es automáticamente actualizable. Una vista no ordena todas las consultas consumidoras: agrega ORDER BY al leer. Para seguridad hay que revisar permisos y semántica del propietario, no solo ocultar columnas visualmente.

Registra el dato cambiado, predicción, resultado y conclusión. Un resultado distinto es válido cuando cambió deliberadamente la población; uno inesperado exige revisar la consulta y el supuesto.

[Unidad](README.md) · [Caso y resultados de referencia](../docs/CASO_TIENDA.md)
