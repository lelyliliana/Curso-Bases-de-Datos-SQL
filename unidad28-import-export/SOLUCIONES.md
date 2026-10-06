# Soluciones razonadas: Unidad 28

Intenta primero [PRACTICA.md](PRACTICA.md). Una consulta puede tener varias soluciones correctas si responde a la misma población, conserva cardinalidad y maneja los mismos límites.

## A. Laboratorio

**Resultado de referencia:** 6 recibidas: 2 aceptadas, 2 correo repetido, 1 correo vacío, 1 nombre vacío. Destino Ana y Luis.

**Interpretación:** \copy lee desde el cliente y las rutas relativas parten de la carpeta de ejecución. La fila raw se conserva; la normalización del correo es una regla explícita de este lote ficticio, no una garantía universal. Se rechazan ambas filas duplicadas porque no sabemos cuál es correcta. HEADER omite el primer registro, no verifica que sus nombres coincidan con columnas. Esta clasificación usa ventanas, ampliadas en la unidad 16.

El script termina en `ROLLBACK`. Los cambios de tablas u objetos del laboratorio se revierten. Los valores de secuencia consumidos pueden dejar huecos; no uses una lista consecutiva de IDs como prueba de recuperación.

## B. Práctica adicional

**Enunciado:** Exporta las aceptadas a un archivo CSV y vuelve a importarlas en otra tabla temporal para comprobar el conteo.

```sql
CREATE TEMP TABLE exportar_lab(nombre text,correo text);
INSERT INTO exportar_lab VALUES ('Ana','ana@example.com'),('Luis','luis@example.com');
-- En psql, reemplaza la ruta por una carpeta existente de tu elección:
-- \copy exportar_lab TO 'clientes_aceptados.csv' WITH (FORMAT csv,HEADER true,ENCODING 'UTF8')
SELECT COUNT(*) FROM exportar_lab;
```

**Resultado o evidencia:** 2 filas. El verificador realiza exportación e importación reales en una carpeta temporal.

La versión ejecutable está en [SOLUCION.sql](SOLUCION.sql). Identifica en ella la fuente de cada columna y las condiciones que limitan su alcance. Si propones otra forma, compara todas las filas y valores; que produzca el mismo conteo no basta para demostrar equivalencia.

## C. Explicar el límite

Vuelve a la decisión central de esta unidad: \copy lee desde el cliente y las rutas relativas parten de la carpeta de ejecución. La fila raw se conserva; la normalización del correo es una regla explícita de este lote ficticio, no una garantía universal. Se rechazan ambas filas duplicadas porque no sabemos cuál es correcta. HEADER omite el primer registro, no verifica que sus nombres coincidan con columnas. Esta clasificación usa ventanas, ampliadas en la unidad 16.

Registra el dato cambiado, predicción, resultado y conclusión. Un resultado distinto es válido cuando cambió deliberadamente la población; uno inesperado exige revisar la consulta y el supuesto.

[Unidad](README.md) · [Caso y resultados de referencia](../docs/CASO_TIENDA.md)
