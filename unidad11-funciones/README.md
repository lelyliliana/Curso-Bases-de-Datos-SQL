# Unidad 11 — Funciones y expresiones

## Qué aprenderás
Construir columnas calculadas, clasificar valores con CASE, tratar NULL con COALESCE y utilizar funciones de texto, números y fechas.

## Antes de empezar
Debes dominar SELECT y WHERE.

# 1. Transformar sin modificar

```sql
SELECT nombre, precio, precio * 1.19 AS precio_con_impuesto
FROM producto;
```

La tabla conserva el precio original. La expresión existe en el resultado.

# 2. CASE

```sql
SELECT nombre, precio,
       CASE
         WHEN precio < 90 THEN 'Económico'
         WHEN precio <= 120 THEN 'Medio'
         ELSE 'Alto'
       END AS rango
FROM producto;
```

CASE se evalúa de arriba hacia abajo. El orden de condiciones importa.

# 3. COALESCE

```sql
SELECT nombre,
       COALESCE(descripcion,'Sin descripción') AS descripcion
FROM producto;
```

Devuelve el primer valor no NULL. No modifica el dato almacenado.

# 4. Texto

```sql
SELECT upper(nombre), lower(nombre), length(nombre)
FROM producto;
```

# 5. Números

```sql
SELECT nombre, round(precio * 0.90, 2) AS precio_descuento
FROM producto;
```

# 6. Fechas

```sql
SELECT id, fecha, extract(year FROM fecha) AS anio
FROM pedido;
```

Trabajar con fechas como tipos temporales permite ordenar, comparar y extraer componentes.

# 7. Práctica guiada

Construye un reporte con:
- producto;
- precio;
- rango mediante CASE;
- descripción con COALESCE.

Escribe primero las reglas en lenguaje natural.

# 8. Errores frecuentes

- Confundir una expresión con UPDATE.
- Usar COALESCE para ocultar problemas sin analizarlos.
- Ordenar mal condiciones CASE solapadas.
- Convertir todo a texto demasiado pronto.

# 9. Ejercicios

1. Clasifica precios.
2. Sustituye NULL solo en salida.
3. Convierte nombres a mayúsculas.
4. Calcula subtotal.
5. Extrae año y mes.
6. Crea una etiqueta calculada.

# 10. Reto

Genera un reporte legible de pedidos con columnas calculadas sin modificar las tablas.

# 11. Autoevaluación

1. ¿CASE modifica datos?
2. ¿Qué devuelve COALESCE?
3. ¿Por qué importa el orden de WHEN?
4. ¿Qué ventaja tiene conservar fechas como tipos temporales?
5. ¿Cuándo una expresión pertenece al reporte?

# 12. Checklist

- [ ] Uso CASE.
- [ ] Manejo NULL con COALESCE.
- [ ] Utilizo funciones de texto, número y fecha.
- [ ] Distingo transformación de modificación.

Continúa con agregaciones.
