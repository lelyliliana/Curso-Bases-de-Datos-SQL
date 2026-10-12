# Unidad 10: UPDATE y DELETE

[Volver al índice del curso](../README.md) · [Ver el curso en Aprende con Leli](https://lelyliliana.github.io/aprende-con-leli/cursos/bases-datos-sql/)

## Qué aprenderás
Modificar y eliminar datos de forma controlada, comprobar el alcance de WHERE y utilizar transacciones para practicar con seguridad.

## Cómo usar los ejemplos de esta unidad

Los ejemplos breves ilustran una idea y pueden usar un conjunto reducido de filas o una tabla independiente. Para ejecutarlos juntos sin conflictos, utiliza el laboratorio y la práctica de esta unidad sobre la [tienda de referencia](../docs/CASO_TIENDA.md). Sus scripts declaran la preparación, resultados y rollback. No vuelvas a crear las tablas de tienda ni repitas su carga para seguir un fragmento ilustrativo.

# 1. UPDATE
```sql
UPDATE producto
SET precio = 130
WHERE id = 3;
```

Sin WHERE:
```sql
UPDATE producto SET precio=130;
```
afectaría todas las filas.

# 2. Antes de modificar
Ejecuta primero:
```sql
SELECT *
FROM producto
WHERE id=3;
```

Si SELECT selecciona exactamente lo que esperas, reutiliza el criterio.

# 3. Varias columnas
```sql
UPDATE producto
SET precio=125,
    activo=false
WHERE id=3;
```

# 4. DELETE
```sql
DELETE FROM producto
WHERE id=3;
```

Las FK pueden impedir una eliminación si otras filas dependen del producto. Eso protege integridad.

# 5. Práctica segura
```sql
BEGIN;

UPDATE producto
SET precio=precio*1.10
WHERE categoria_id=1;

SELECT id,nombre,precio
FROM producto
WHERE categoria_id=1;

ROLLBACK;
```

Después del ROLLBACK, verifica que los valores regresaron.

# 6. Eliminación lógica
En algunos dominios:
```sql
UPDATE producto SET activo=false WHERE id=3;
```
puede ser preferible a DELETE si necesitamos conservar historial.

No es universal: depende del requisito.

# 7. RETURNING
PostgreSQL permite:
```sql
UPDATE producto
SET precio=100
WHERE id=1
RETURNING id,nombre,precio;
```

# 8. Errores frecuentes
- UPDATE/DELETE sin WHERE accidental.
- Borrar datos históricos sin política.
- Desactivar FK para “hacer funcionar” DELETE.
- No comprobar cuántas filas fueron afectadas.

# 9. Ejercicios
1. Actualiza un precio.
2. Desactiva categoría de productos.
3. Usa RETURNING.
4. Practica dentro de BEGIN/ROLLBACK.
5. Intenta borrar una fila referenciada e interpreta el error.

# 10. Reto
Diseña una operación de mantenimiento que cambie varias filas. Primero escribe SELECT equivalente, luego ejecútala dentro de transacción y revierte.

# 11. Autoevaluación
1. ¿Qué riesgo tiene UPDATE sin WHERE?
2. ¿Por qué ejecutar SELECT primero?
3. ¿Qué hace ROLLBACK?
4. ¿Cuándo puede servir eliminación lógica?
5. ¿Qué papel cumplen las FK al borrar?

# 12. Checklist
- [ ] Actualizo con criterio.
- [ ] Elimino conscientemente.
- [ ] Verifico WHERE antes.
- [ ] Practico con transacciones.
- [ ] Interpreto errores de FK.

Ya dominas el SQL esencial. Continúa con funciones y consultas agregadas.


---

## Laboratorio completo y lectura del resultado

**Caso:** ¿Cómo comprobar el alcance de una modificación y revertirla?

Comprueba primero SELECT con el criterio, luego RETURNING y número de filas. Esta inspección no bloquea por sí sola cambios concurrentes. En una operación real que dependa de una lectura previa, se necesita aislamiento o bloqueo adecuado. DELETE de Teclado fallaría porque está referenciado; no desactives la FK para resolverlo.

### Paso a paso

1. Comprueba que estás en la base de práctica y que la [tienda](../docs/CASO_TIENDA.md) conserva sus datos iniciales.
2. Abre [LABORATORIO.sql](LABORATORIO.sql). Lee el script antes de enviarlo al servidor.
3. Predice el resultado de cada sentencia. Anota qué representa una fila y qué operaciones pueden cambiar datos.
4. Desde la raíz, ejecuta:

```text
psql -X -h localhost -U estudiante -d curso_sql -v ON_ERROR_STOP=1 -f unidad10-update-delete/LABORATORIO.sql
```

La contraseña se solicita en la terminal; no la escribas en el repositorio.

5. Compara con la referencia: **Precios iniciales 80/90, después 88/99. Se elimina temporalmente Lámpara y quedan cuatro productos. Después de ROLLBACK hay cinco y los precios originales.**
6. Termina con la [práctica](PRACTICA.md), luego contrasta tus decisiones con las [soluciones razonadas](SOLUCIONES.md).

### Transferir la idea a otro problema

Desactiva los productos de Tecnología sin borrar su historia y comprueba cuáles cambian.

Explica cómo cambiarían los datos si aparece una fila adicional, una referencia ausente o un empate. Distingue una garantía del esquema de una suposición que solo cumple esta muestra. El objetivo es construir una respuesta justificable, no copiar una consulta sin entender su población.

## Continuar el curso

- **Unidad anterior:** [Unidad 09: ORDER BY, LIMIT y DISTINCT](../unidad09-order-limit/README.md)
- **Volver al índice:** [Todas las unidades](../README.md)
- **Siguiente unidad:** [Unidad 11: Funciones y expresiones](../unidad11-funciones/README.md)

---

### ¿Necesitas apoyo con este tema?

Si te bloqueaste con la práctica, necesitas revisar tu entorno o adaptar lo aprendido a tu proyecto, podemos trabajarlo en una sesión personalizada.

[**Solicitar asesoría para este tema por WhatsApp**](https://wa.me/573103618296?text=Hola%2C%20Leli.%20Estoy%20estudiando%20Unidad%2010%20%E2%80%94%20UPDATE%20y%20DELETE%20del%20curso%20Bases%20de%20Datos%20y%20SQL%20desde%20cero%20%28https%3A%2F%2Fgithub.com%2Flelyliliana%2FCurso-Bases-de-Datos-SQL%2Ftree%2Fmain%2Funidad10-update-delete%29%20y%20necesito%20una%20asesor%C3%ADa%20personalizada.%20Mi%20duda%20es%E2%80%A6)
