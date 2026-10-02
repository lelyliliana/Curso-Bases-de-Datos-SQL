# Unidad 10 — UPDATE y DELETE

## Qué aprenderás
Modificar y eliminar datos de forma controlada, comprobar el alcance de WHERE y utilizar transacciones para practicar con seguridad.

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
