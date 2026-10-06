# Soluciones razonadas: Unidad 30

Intenta primero [PRACTICA.md](PRACTICA.md). Una consulta puede tener varias soluciones correctas si responde a la misma población, conserva cardinalidad y maneja los mismos límites.

## A. Laboratorio

**Resultado de referencia:** 4 filas; 2 sin nombre; 1 precio no numérico. Reglas por id: ACEPTADO, PRECIO_NO_POSITIVO, NOMBRE_VACIO, NOMBRE_VACIO.

**Interpretación:** La clasificación registra una primera causa por fila; el perfil puede registrar varias incidencias y su suma superar el número de rechazadas. pg_input_is_valid verifica conversión del tipo, no todas las reglas del dominio. numeric admite valores especiales como NaN; una política real puede requerir rechazarlos explícitamente. No sobrescribas raw ni inventes un nombre para pasar NOT NULL.

El script termina en `ROLLBACK`. Los cambios de tablas u objetos del laboratorio se revierten. Los valores de secuencia consumidos pueden dejar huecos; no uses una lista consecutiva de IDs como prueba de recuperación.

## B. Práctica adicional

**Enunciado:** Calcula porcentaje de filas con nombre vacío y explica si el denominador son filas o valores no nulos.

```sql
CREATE TEMP TABLE porcentaje_lab(nombre text); INSERT INTO porcentaje_lab VALUES ('Ana'),(''),(NULL),('Luis'); SELECT round(100.0*COUNT(*) FILTER(WHERE nombre IS NULL OR btrim(nombre)='')/NULLIF(COUNT(*),0),2) FROM porcentaje_lab;
```

**Resultado o evidencia:** 50.00%, denominador cuatro filas. COUNT(nombre) excluiría NULL y respondería otra pregunta.

La versión ejecutable está en [SOLUCION.sql](SOLUCION.sql). Identifica en ella la fuente de cada columna y las condiciones que limitan su alcance. Si propones otra forma, compara todas las filas y valores; que produzca el mismo conteo no basta para demostrar equivalencia.

## C. Explicar el límite

Vuelve a la decisión central de esta unidad: La clasificación registra una primera causa por fila; el perfil puede registrar varias incidencias y su suma superar el número de rechazadas. pg_input_is_valid verifica conversión del tipo, no todas las reglas del dominio. numeric admite valores especiales como NaN; una política real puede requerir rechazarlos explícitamente. No sobrescribas raw ni inventes un nombre para pasar NOT NULL.

Registra el dato cambiado, predicción, resultado y conclusión. Un resultado distinto es válido cuando cambió deliberadamente la población; uno inesperado exige revisar la consulta y el supuesto.

[Unidad](README.md) · [Caso y resultados de referencia](../docs/CASO_TIENDA.md)
