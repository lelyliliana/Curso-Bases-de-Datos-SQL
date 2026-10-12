# Unidad 11: Funciones y expresiones

[Volver al índice del curso](../README.md) · [Ver el curso en Aprende con Leli](https://lelyliliana.github.io/aprende-con-leli/cursos/bases-datos-sql/)

## Qué aprenderás
Construir columnas calculadas, clasificar valores con CASE, tratar NULL con COALESCE y utilizar funciones de texto, números y fechas.

## Antes de empezar
Debes dominar SELECT y WHERE.

## Cómo usar los ejemplos de esta unidad

Los ejemplos breves ilustran una idea y pueden usar un conjunto reducido de filas o una tabla independiente. Para ejecutarlos juntos sin conflictos, utiliza el laboratorio y la práctica de esta unidad sobre la [tienda de referencia](../docs/CASO_TIENDA.md). Sus scripts declaran la preparación, resultados y rollback. No vuelvas a crear las tablas de tienda ni repitas su carga para seguir un fragmento ilustrativo.

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


---

## Laboratorio completo y lectura del resultado

**Caso:** ¿Cómo producir etiquetas y manejar ausencias sin reescribir los datos originales?

CASE usa la primera condición verdadera. COALESCE conserva el tipo compatible y no altera NULL en la tabla. AT TIME ZONE hace explícito el calendario del reporte. Una división entre enteros trunca; convierte antes de dividir si necesitas fracciones. CURRENT_TIMESTAMP es estable dentro de una transacción, no un reloj que avance en cada llamada.

### Paso a paso

1. Comprueba que estás en la base de práctica y que la [tienda](../docs/CASO_TIENDA.md) conserva sus datos iniciales.
2. Abre [LABORATORIO.sql](LABORATORIO.sql). Lee el script antes de enviarlo al servidor.
3. Predice el resultado de cada sentencia. Anota qué representa una fila y qué operaciones pueden cambiar datos.
4. Desde la raíz, ejecuta:

```text
psql -X -h localhost -U estudiante -d curso_sql -v ON_ERROR_STOP=1 -f unidad11-funciones/LABORATORIO.sql
```

La contraseña se solicita en la terminal; no la escribas en el repositorio.

5. Compara con la referencia: **Rangos: Económico, Medio, Medio, Medio, Económico. Mes 1 para los cinco pedidos. División entera 2, decimal 2.5.**
6. Termina con la [práctica](PRACTICA.md), luego contrasta tus decisiones con las [soluciones razonadas](SOLUCIONES.md).

### Transferir la idea a otro problema

Calcula porcentaje de productos activos usando decimales y protege una división si no hay filas.

Explica cómo cambiarían los datos si aparece una fila adicional, una referencia ausente o un empate. Distingue una garantía del esquema de una suposición que solo cumple esta muestra. El objetivo es construir una respuesta justificable, no copiar una consulta sin entender su población.

## Continuar el curso

- **Unidad anterior:** [Unidad 10: UPDATE y DELETE](../unidad10-update-delete/README.md)
- **Volver al índice:** [Todas las unidades](../README.md)
- **Siguiente unidad:** [Unidad 12: Agregaciones](../unidad12-agregaciones/README.md)

---

### ¿Necesitas apoyo con este tema?

Si te bloqueaste con la práctica, necesitas revisar tu entorno o adaptar lo aprendido a tu proyecto, podemos trabajarlo en una sesión personalizada.

[**Solicitar asesoría para este tema por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20Unidad%2011%20%E2%80%94%20Funciones%20y%20expresiones%20del%20curso%20Bases%20de%20Datos%20y%20SQL%20desde%20cero%20%28https%3A%2F%2Fgithub.com%2Flelyliliana%2FCurso-Bases-de-Datos-SQL%2Ftree%2Fmain%2Funidad11-funciones%29%20y%20necesito%20una%20asesor%C3%ADa%20personalizada.%20Mi%20duda%20es%E2%80%A6)
